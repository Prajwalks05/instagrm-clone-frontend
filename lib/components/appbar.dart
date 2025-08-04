import 'package:flutter/material.dart';

class InstaAppBar extends StatelessWidget implements PreferredSizeWidget {
  const InstaAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 1,
      title: const Text(
        'Instagram Clone',
        style: TextStyle(
          color: Colors.black,
          fontFamily: 'Billabong',
          fontSize: 28,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: const InstaAppBar(),
        body: const Center(child: Text("Home Page")),
      ),
    );
  }
}
