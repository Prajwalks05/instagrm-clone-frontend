import 'package:flutter/material.dart';

class MetallicBackground extends StatelessWidget {
  final Widget child;

  const MetallicBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            Color(0xFFE3FFE7), // light mint green
            Color(0xFFD9E7FF), // soft pastel blue
          ],
        ),
      ),
      child: child,
    );
  }
}
