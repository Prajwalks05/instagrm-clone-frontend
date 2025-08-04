// lib/screens/post_detail_screen.dart
import 'package:flutter/material.dart';
import 'package:instagram_clone/components/metallic_background.dart';

class PostDetailScreen extends StatelessWidget {
  final String userId;
  final String imageUrl;
  final String caption;

  const PostDetailScreen({
    super.key,
    required this.userId,
    required this.imageUrl,
    required this.caption,
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Post by ${userId.substring(0, 5)}")),
      body: MetallicBackground(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(caption, style: const TextStyle(fontSize: 16)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
