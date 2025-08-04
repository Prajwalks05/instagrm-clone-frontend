import 'package:flutter/material.dart';
import 'package:instagram_clone/components/bottmnavbar.dart';
import 'package:instagram_clone/components/metallic_background.dart';
import 'package:instagram_clone/services/api_service.dart';
import 'package:instagram_clone/screens/story_view_screen.dart';
import 'package:instagram_clone/screens/post_detail_screen.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Future<void> _handleRefresh() async {
    await Future.wait([fetchStories(), fetchPosts()]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LiquidPullToRefresh(
        onRefresh: _handleRefresh, // your refresh function
        height: 200,
        color: Colors.blue,
        backgroundColor: Colors.white,
        animSpeedFactor: 2,

        child: MetallicBackground(
          child: SafeArea(
            child: FutureBuilder(
              future: Future.wait([fetchStories(), fetchPosts()]),
              builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return const Center(child: Text("Error loading feed"));
                }

                final stories = snapshot.data![0] as List<Map<String, dynamic>>;
                final posts = snapshot.data![1] as List<Map<String, String>>;

                return ListView(
                  children: [
                    // ---------- Stories Section ----------
                    MetallicBackground(
                      child: SizedBox(
                        height: 100,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: stories.length + 1,
                          itemBuilder: (context, index) {
                            if (index == 0) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                ),
                                child: Column(
                                  children: const [
                                    CircleAvatar(
                                      radius: 30,
                                      child: Icon(Icons.add),
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      "Your Story",
                                      style: TextStyle(fontSize: 12),
                                    ),
                                  ],
                                ),
                              );
                            }
                            final story = stories[index - 1];
                            final List<String> urls =
                                (story["urls"] as List<dynamic>)
                                    .map((e) => e.toString())
                                    .toList();
                            return GestureDetector(
                              onTap: () {
                                if (urls.isNotEmpty) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder:
                                          (_) => StoryViewScreen(
                                            storyUrls: urls,
                                            userId: story["userId"] as String,
                                          ),
                                    ),
                                  );
                                }
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                ),
                                child: Column(
                                  children: [
                                    CircleAvatar(
                                      radius: 30,
                                      backgroundImage:
                                          urls.isNotEmpty
                                              ? NetworkImage(urls[0])
                                              : const AssetImage(
                                                    "assets/default_avatar.png",
                                                  )
                                                  as ImageProvider,
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      (story["userId"] as String).substring(0, 5),
                                      style: const TextStyle(fontSize: 12),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    const Divider(height: 1),
                    // ---------- Posts Section ----------
                    ...posts.map((post) {
                      return Card(
                        margin: const EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 12,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ListTile(
                              onLongPress: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder:
                                        (context) => PostDetailScreen(
                                          caption: post["caption"] ?? "",
                                          imageUrl: post["url"]!,
                                          userId: post["userId"]!,
                                        ),
                                  ),
                                );
                              },
                              leading: CircleAvatar(
                                child: Text(post["userId"]!.substring(0, 2)),
                              ),
                              title: Text(
                                "User ${post["userId"]!.substring(0, 5)}",
                              ),
                            ),
                            Image.network(post["url"]!, fit: BoxFit.cover),
                          ],
                        ),
                      );
                    }),
                  ],
                );
              },
            ),
          ),
        ),
      ),
      bottomNavigationBar: const BottomNavBarFb2(),
    );
  }
}
