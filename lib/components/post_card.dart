// lib/components/post_card.dart
import 'package:flutter/material.dart';
import 'package:instagram_clone/screens/post_detail_screen.dart';

class PostCard extends StatelessWidget {
  final String userId;
  final String imageUrl;
  final String caption;

  const PostCard({
    super.key,
    required this.userId,
    required this.imageUrl,
    required this.caption,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder:
                (_) => PostDetailScreen(
                  userId: userId,
                  imageUrl: imageUrl,
                  caption: caption,
                ),
          ),
        );
      },
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // User info
            ListTile(
              leading: CircleAvatar(child: Text(userId.substring(0, 2))),
              title: Text("User ${userId.substring(0, 5)}"),
            ),

            // Post image
            Image.network(imageUrl, fit: BoxFit.cover),

            // Caption
            Padding(padding: const EdgeInsets.all(8.0), child: Text(caption)),
          ],
        ),
      ),
    );
  }
}
