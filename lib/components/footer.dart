import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../utils/footercolumn.dart';
import '../utils/svgfile.dart';

class Footer extends StatefulWidget {
  const Footer({super.key});

  @override
  State<Footer> createState() => _FooterState();
}

class _FooterState extends State<Footer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF232127),
      padding:
      const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'assets/logo.svg',
            theme: const SvgTheme(currentColor: Colors.white),
            colorFilter: const ColorFilter.linearToSrgbGamma(),
          ),
          const SizedBox(height: 40),
           Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              buildColumn('Features', [
                'Link Shortening',
                'Branded Links',
                'Analytics',
              ]), buildColumn('Resources', [
                'Blog',
                'Developers',
                'Support',
              ]),
              buildColumn('Company', [
                'About',
                'Our Team',
                'Careers',
                'Contact',
              ]),
            ],
          ),
          const SizedBox(height: 40),
           Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildSvgIcon('assets/icon-facebook.svg'),
              const SizedBox(width: 20),
              buildSvgIcon('assets/icon-twitter.svg'),
              const SizedBox(width: 20),
              buildSvgIcon('assets/icon-pinterest.svg'),
              const SizedBox(width: 20),
              buildSvgIcon('assets/icon-instagram.svg'),
            ],
          ),
        ],
      ),
    );
  }
}
