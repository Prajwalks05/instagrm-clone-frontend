// reels_screen.dart
import 'package:flutter/material.dart';
import 'package:instagram_clone/components/bottmnavbar.dart';

class ReelsScreen extends StatelessWidget {
  const ReelsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Reels"),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: const Center(child: Text("Reels Screen Content")),
      bottomNavigationBar: const BottomNavBarFb2(),
    );
  }
}
