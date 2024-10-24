import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:urlshortener/utils/snackbar.dart';

import 'features/shortener/providers/urlprovider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProviderScope(child: URLShortener()));
}

class URLShortener extends StatelessWidget {
  const URLShortener({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Shorten your URLs',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      home: UrlShortenerScreen(),
    );
  }
}

class UrlShortenerScreen extends ConsumerWidget {
  final TextEditingController _controller = TextEditingController();

  UrlShortenerScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final urlState = ref.watch(urlProvider);
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: SvgPicture.asset('assets/logo.svg'),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.menu,
              size: 40,
            ),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (context) => FractionallySizedBox(
                  heightFactor: 1,
                  child: SafeArea(
                    child: Column(

                      children: [

                        const SizedBox(height: 50,),
                        ListTile(
                          title: const Text('Item 1'),
                          onTap: () {
                            // Handle item 1 tap
                            Navigator.pop(context);
                          },
                        ),
                        ListTile(
                          title: const Text('Item 2'),
                          onTap: () {
                            // Handle item 2 tap
                            Navigator.pop(context);
                          },
                        ),
                        ListTile(
                          title: const Text('Item 3'),
                          onTap: () {
                            // Handle item 3 tap
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              SvgPicture.asset(
                'assets/illustration-working.svg',
                height: size.height * 0.25,
                width: size.width * 2,
                fit: BoxFit.cover,
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: _controller,
                decoration: const InputDecoration(
                  labelText: 'Enter URL',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  if (_controller.text.isEmpty) {
                    showSnackbar('Please enter a URL');
                    return;
                  }
                  ref.read(urlProvider.notifier).shortenUrl(_controller.text);
                  _controller.clear();
                },
                child: const Text('Shorten URL'),
              ),
              const SizedBox(height: 20),
              if (urlState.isLoading)
                const Center(child: CircularProgressIndicator())
              else if (urlState.error != null)
                Center(
                    child: Text(urlState.error!,
                        style: const TextStyle(color: Colors.red)))
              else
                Expanded(
                  child: ListView.builder(
                    itemCount: urlState.urls.length,
                    itemBuilder: (context, index) {
                      final url = urlState.urls[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 8.0),
                        child: ListTile(
                          title: Text(url.original),
                          subtitle: Text(url.shortened),
                          trailing: IconButton(
                            icon: const Icon(Icons.copy),
                            onPressed: () {
                              Clipboard.setData(
                                  ClipboardData(text: url.shortened));
                              showSnackbar('Copied to clipboard');
                            },
                          ),
                        ),
                      );
                    },
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
