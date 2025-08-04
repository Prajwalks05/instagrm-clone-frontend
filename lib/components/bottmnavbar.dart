import 'package:flutter/material.dart';
// import 'package:icons_plus/icons_plus.dart';
import 'package:instagram_clone/screens/home_screen.dart';
// import 'package:instagram_clone/screens/search_screen.dart';
import 'package:instagram_clone/screens/create_post_screen.dart';
// import 'package:instagram_clone/screens/reels_screen.dart';
import 'package:instagram_clone/screens/profile_screen.dart';

class BottomNavBarFb2 extends StatelessWidget {
  const BottomNavBarFb2({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Colors.white,
      child: SizedBox(
        height: 56,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconBottomBar(
                icon: Icons.home_outlined,
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => const HomeScreen()),
                  );
                },
              ),
              // IconBottomBar(
              //   icon: Icons.search_outlined,
              //   onPressed: () {
              //     Navigator.pushReplacement(
              //       context,
              //       MaterialPageRoute(builder: (_) => const SearchScreen()),
              //     );
              //   },
              // ),
              IconBottomBar(
                icon: Icons.add_box_outlined,
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => const CreatePostScreen()),
                  );
                },
              ),
              // IconBottomBar(
              //   icon: Icons.video_collection_outlined,
              //   onPressed: () {
              //     Navigator.pushReplacement(
              //       context,
              //       MaterialPageRoute(builder: (_) => const ReelsScreen()),
              //     );
              //   },
              // ),
              IconBottomBar(
                icon: Icons.person_outline,
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => const ProfileScreen()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class IconBottomBar extends StatelessWidget {
  const IconBottomBar({super.key, required this.icon, required this.onPressed});

  final IconData icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Icon(icon, size: 28, color: Colors.black),
    );
  }
}
