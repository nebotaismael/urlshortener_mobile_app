import 'package:flutter/material.dart';

Widget buildColumn(String title, List<String> items) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
      const SizedBox(height: 20),
      ...items.map((item) => Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Text(
          item,
          style: TextStyle(color: Colors.grey[400], fontSize: 14),
        ),
      )),
    ],
  );
}
