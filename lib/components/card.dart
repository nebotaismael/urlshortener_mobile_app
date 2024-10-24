import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart'; // Import for SVG support

class DetailedRecordCard extends StatelessWidget {
  final double height;
  final String title;
  final String description;
  final String svgAssetPath; // Path to your SVG icon

  const DetailedRecordCard({
    super.key,
    required this.height,
    required this.title,
    required this.description,
    required this.svgAssetPath,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      height: height*0.4,
      width: size.width, // Ensure full width
      child: Stack(
        children: [
          // Separator line
          Positioned(
            top: 50.0,
            left: 0.0,
            right: 0.0,
            child: Divider(
              thickness: 1.0,
              color: Colors.grey[300],
            ),
          ),

          // Centered text content
          Positioned(
            height: height * 0.3, // Consistent height calculation
            top: 60.0,
            left: 1,
            right: 1,
            child: Card(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center, // Center content
                  children: [
                    const SizedBox(height: 50.0),
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      description,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.grey[700],
                      ),
                    ),
                    const SizedBox(height: 7.0),
                  ],
                ),
              ),
            ),
          ),

          // SVG Icon at the top
          Positioned(
            top: 10.0,
            right: size.width * 0.38, // Assuming this is still desired
            child: CircleAvatar(
              radius: 40,
              backgroundColor: Colors.black,
              child: SvgPicture.asset(
                svgAssetPath,
                height: 40.0,
                width: 40.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}