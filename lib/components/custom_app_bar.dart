import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'custom_bottom_sheet.dart';

AppBar customAppBar(BuildContext context) {
  return AppBar(
    backgroundColor: Colors.grey[200],
    title: SvgPicture.asset('assets/logo.svg'),
    actions: [
      IconButton(
        icon: const Icon(Icons.menu, size: 40),
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (context) => const CustomBottomSheet(),
          );
        },
      ),
    ],
  );
}