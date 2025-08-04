import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone/components/bottmnavbar.dart';
import 'package:instagram_clone/screens/login_screen.dart';
import 'package:instagram_clone/components/metallic_background.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Uint8List? profileImageBytes;
  String bio = "";

  @override
  void initState() {
    super.initState();
    _loadProfileData();
  }

  Future<void> _loadProfileData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? base64Image = prefs.getString('profileImage');
    String? savedBio = prefs.getString('bio');

    setState(() {
      if (base64Image != null) {
        profileImageBytes = base64Decode(base64Image);
      }
      bio = savedBio ?? "";
    });
  }

  Future<void> _updateProfileImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      Uint8List imageBytes = await pickedFile.readAsBytes();
      String base64Image = base64Encode(imageBytes);

      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('profileImage', base64Image);

      setState(() {
        profileImageBytes = imageBytes;
      });
    }
  }

  Future<void> _editBio() async {
    TextEditingController bioController = TextEditingController(text: bio);
    await showDialog(
      context: context,
      builder:
          (_) => MetallicBackground(
            child: SafeArea(
              child: AlertDialog(
                title: const Text("Edit Bio"),
                content: TextField(
                  controller: bioController,
                  maxLines: 2,
                  decoration: const InputDecoration(hintText: "Enter your bio"),
                ),
                actions: [
                  TextButton(
                    onPressed: () async {
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      await prefs.setString('bio', bioController.text);
                      setState(() {
                        bio = bioController.text;
                      });
                      Navigator.pop(context);
                    },
                    child: const Text("Save"),
                  ),
                ],
              ),
            ),
          ),
    );
  }

  Future<void> _logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false);

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const LoginScreen()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MetallicBackground(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile Row
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: _updateProfileImage,
                      child: CircleAvatar(
                        radius: 40,
                        backgroundImage:
                            profileImageBytes != null
                                ? MemoryImage(profileImageBytes!)
                                : const AssetImage("assets/default_avatar.png")
                                    as ImageProvider,
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  bio.isEmpty ? "No bio set" : bio,
                                  style: const TextStyle(fontSize: 14),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              IconButton(
                                icon: const Icon(Icons.edit, size: 20),
                                onPressed: _editBio,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Logout Button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                    minimumSize: const Size(double.infinity, 45),
                  ),
                  onPressed: _logout,
                  child: const Text(
                    style: TextStyle(color: Colors.white),
                    "Logout"),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomNavBarFb2(),
    );
  }
}
