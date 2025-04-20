import 'package:flutter/material.dart';

class LoanCardWidget extends StatelessWidget {
  final String title;
  final String description;
  final VoidCallback? onTap;
  final Color backgroundColor;

  const LoanCardWidget({
    Key? key,
    required this.title,
    required this.description,
    this.onTap,
    this.backgroundColor = const Color(0xFF2D6BFF),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              description,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
