import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:urlshortener/components/custom_app_bar.dart';

import 'package:urlshortener/utils/snackbar.dart';


import '../../../components/card.dart';
import '../providers/urlprovider.dart';

class UrlShortenerScreen extends ConsumerWidget {
  final TextEditingController _controller = TextEditingController();

   UrlShortenerScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final urlState = ref.watch(urlProvider);
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: customAppBar(context),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                SvgPicture.asset(
                  'assets/illustration-working.svg',
                  height: size.height * 0.25,
                  fit: BoxFit.cover,
                ),
                const SizedBox(height: 10),
                const Text(
                  "More than Just Shorter Links",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 40.0,
                    fontWeight: FontWeight.w900,
                    height: 1.2,
                  ),
                ),
                const Text(
                  "Build your brand recognition and get detailed insights on how your links are performing",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16.0,
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.cyan),
                  onPressed: () {},
                  child: const Text('Get Started'),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                    labelText: 'Enter URL',
                    filled: true,
                    fillColor: Colors.grey[200],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(color: Colors.cyan, width: 2.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(color: Colors.blueAccent, width: 2.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(color: Colors.cyan, width: 2.0),
                    ),
                    hintText: 'Paste your URL here',
                    hintStyle: const TextStyle(color: Colors.cyan),
                  ),
                  maxLength: 200,
                  keyboardType: TextInputType.url,
                ),
                const SizedBox(height: 20),
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
                          style: const TextStyle(color: Colors.red))),
                Flexible(
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
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
                const SizedBox(height: 50),
                const Text(
                  "Advanced Statistics",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 35.0,
                    fontWeight: FontWeight.w900,
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  "Track how your links are performing across the web with our advanced statistics dashboard",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16.0,
                  ),
                ),
                const SizedBox(height: 40),
                DetailedRecordCard(
                  height: size.height,
                  title: 'Brand Recognition',
                  description:
                  'Boost your brand recognition with each click. Generic links dont mean a thing, Branded links help instill confidence in your clients',
                  svgAssetPath: 'assets/icon-brand-recognition.svg',
                ),
                DetailedRecordCard(
                  height: size.height,
                  title: 'Detailed Records',
                  description:
                  'Gain insights into who is clicking your links. Knowing when and where people engage with your content helps inform better decisions.',
                  svgAssetPath: 'assets/icon-detailed-records.svg',
                ),
                DetailedRecordCard(
                  height: size.height,
                  title: 'Fully Customizable',
                  description:
                  'Improve brand awareness and content discoverability through customizable links, supercharging audience engagement',
                  svgAssetPath: 'assets/icon-fully-customizable.svg',
                ),
                Container(
                  width: size.width,
                  color: const Color.fromARGB(255, 51, 31, 61),
                  child: Stack(
                    children: [
                      Positioned(
                          child: SvgPicture.asset('assets/bg-boost-mobile.svg')),
                      Positioned(
                        top: 110,
                        right: 60,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "Boost your links today",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 25.0,
                                  fontWeight: FontWeight.w900,
                                  height: 1.2,
                                ),
                              ),
                              const SizedBox(height: 10),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.cyan),
                                onPressed: () {},
                                child: const Text(
                                  'Get Started',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}