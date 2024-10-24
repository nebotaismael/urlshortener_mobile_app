import 'package:flutter/material.dart';

class CustomBottomSheet extends StatelessWidget {
  const CustomBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: 0.5,
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.deepPurple,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 20),
            buildListTile(context, 'Features'),
            buildListTile(context, 'Pricing'),
            buildListTile(context, 'Resources'),
            const Divider(color: Colors.white54),
            buildListTile(context, 'Login'),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.cyan,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text('Sign Up', style: TextStyle(color: Colors.white),),
              ),
            ),
          ],
        ),
      ),
    );
  }

  ListTile buildListTile(BuildContext context, String title) {
    return ListTile(
      title: Center(
        child: Text(
          title,
          style: const TextStyle(color: Colors.white),
        ),
      ),
      onTap: () {
        Navigator.pop(context);
      },
    );
  }
}