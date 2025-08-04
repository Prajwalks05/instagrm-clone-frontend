// search_screen.dart
import 'package:flutter/material.dart';
import 'package:instagram_clone/components/bottmnavbar.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Search"),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: const Center(
        child: Text("Search Screen Content"),
      ),
      bottomNavigationBar: const BottomNavBarFb2(),
    );
  }
}
