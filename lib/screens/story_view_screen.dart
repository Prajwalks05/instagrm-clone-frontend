import 'package:flutter/material.dart';

class StoryViewScreen extends StatefulWidget {
  final List<String> storyUrls;
  final String userId;

  const StoryViewScreen({
    super.key,
    required this.storyUrls,
    required this.userId,
  });

  @override
  State<StoryViewScreen> createState() => _StoryViewScreenState();
}

class _StoryViewScreenState extends State<StoryViewScreen> {
  int _currentIndex = 0;
  PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    final urls = widget.storyUrls;

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child:
            urls.isEmpty
                ? const Center(
                  child: Text(
                    "No Stories",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                )
                : Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    // Swipe between stories
                    PageView.builder(
                      controller: _pageController,
                      itemCount: urls.length,
                      onPageChanged: (index) {
                        setState(() {
                          _currentIndex = index;
                        });
                      },
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTapUp: (details) {
                            if (details.localPosition.dx <
                                MediaQuery.of(context).size.width / 2) {
                              // Tap left = previous
                              if (_currentIndex > 0) {
                                _pageController.previousPage(
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeInOut,
                                );
                              }
                            } else {
                              // Tap right = next
                              if (_currentIndex < urls.length - 1) {
                                _pageController.nextPage(
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeInOut,
                                );
                              }
                            }
                          },
                          child: Image.network(
                            urls[index],
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: double.infinity,
                          ),
                        );
                      },
                    ),

                    // Story progress indicators
                    Positioned(
                      top: 10,
                      left: 10,
                      right: 10,
                      child: Row(
                        children:
                            urls.asMap().entries.map((entry) {
                              return Expanded(
                                child: Container(
                                  margin: const EdgeInsets.symmetric(
                                    horizontal: 2,
                                  ),
                                  height: 3,
                                  decoration: BoxDecoration(
                                    color:
                                        entry.key <= _currentIndex
                                            ? Colors.white
                                            : Colors.white24,
                                    borderRadius: BorderRadius.circular(3),
                                  ),
                                ),
                              );
                            }).toList(),
                      ),
                    ),

                    // Close button
                    Positioned(
                      top: 40,
                      right: 20,
                      child: IconButton(
                        icon: const Icon(Icons.close, color: Colors.white),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),
                  ],
                ),
      ),
    );
  }
}
