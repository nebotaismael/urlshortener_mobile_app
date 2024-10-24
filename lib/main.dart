import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'features/shortener/screens/url_shortener_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();
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
        primaryColor: Colors.cyan,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.cyan,
          primary: Colors.cyan,
          secondary: Colors.red,
          surface: const Color(0xFFE0E0E0), // Gray

          error: Colors.red,
          onPrimary: Colors.white,
          onSecondary: Colors.white,
          onSurface: const Color(0xFF3A3A3A), // Very Dark Blue

          onError: Colors.white,
          brightness: Brightness.light,
        ),
        textTheme: TextTheme(
          bodyLarge: GoogleFonts.poppins(
            fontSize: 18.0,
            fontWeight: FontWeight.w500,
          ),
          bodyMedium: GoogleFonts.poppins(
            fontSize: 16.0,
            fontWeight: FontWeight.w500,
          ),
          displayLarge: GoogleFonts.poppins(
            fontSize: 40.0,
            fontWeight: FontWeight.w900,
          ),
          displayMedium: GoogleFonts.poppins(
            fontSize: 35.0,
            fontWeight: FontWeight.w900,
          ),
        ),
        useMaterial3: true,
      ),
      home: UrlShortenerScreen(),
    );
  }
}