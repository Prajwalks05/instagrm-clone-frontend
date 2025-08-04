import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;
import 'package:instagram_clone/components/metallic_background.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:instagram_clone/components/bottmnavbar.dart';

class CreatePostScreen extends StatefulWidget {
  const CreatePostScreen({super.key});

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  File? _selectedFile;
  String _caption = "";
  String _type = "post";
  bool _isUploading = false;

  /// 📌 Pick media file
  Future<void> pickMedia() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.media);
    if (result != null) {
      setState(() {
        _selectedFile = File(result.files.single.path!);
      });
      _showUploadDialog();
    }
  }

  /// 📌 Show Post/Story selector + caption
  void _showUploadDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return MetallicBackground(
          child: SafeArea(
            child: AlertDialog(
              title: const Text("Upload Media"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: RadioListTile(
                          title: const Text("Post"),
                          value: "post",
                          groupValue: _type,
                          onChanged: (value) {
                            setState(() => _type = value.toString());
                            Navigator.pop(context);
                            _showUploadDialog();
                          },
                        ),
                      ),
                      Expanded(
                        child: RadioListTile(
                          title: const Text("Story"),
                          value: "story",
                          groupValue: _type,
                          onChanged: (value) {
                            setState(() => _type = value.toString());
                            Navigator.pop(context);
                            _showUploadDialog();
                          },
                        ),
                      ),
                    ],
                  ),
                  if (_type == "post")
                    TextField(
                      decoration: const InputDecoration(
                        hintText: "Enter caption",
                      ),
                      onChanged: (value) {
                        _caption = value;
                      },
                    ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Cancel"),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    _startUploadAnimation();
                  },
                  child: const Text("Upload"),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  /// 📌 Show upload animation before actual upload
  void _startUploadAnimation() {
    setState(() {
      _isUploading = true;
    });

    Future.delayed(const Duration(seconds: 5), () {
      if (!mounted) return;
      setState(() {
        _isUploading = false;
      });
      uploadMedia();
    });
  }

  /// 📌 Upload via Node.js backend
  Future<void> uploadMedia() async {
    if (_selectedFile == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("No file selected")));
      return;
    }

    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString("userId");

    if (userId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("User ID not found. Please login again.")),
      );
      return;
    }

    final apiBaseUrl = dotenv.env['API_URL'] ?? "http://localhost:5001";

    try {
      final request = http.MultipartRequest(
        "POST",
        Uri.parse("$apiBaseUrl/upload"),
      );

      request.fields["userId"] = userId;
      request.fields["type"] = _type;
      request.fields["caption"] = _caption;

      request.files.add(
        await http.MultipartFile.fromPath("file", _selectedFile!.path),
      );

      final response = await request.send();
      final resBody = await response.stream.bytesToString();

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("✅ Uploaded to $userId/$_type successfully")),
        );
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("❌ Upload Failed: $resBody")));
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("⚠️ Error: $e")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Post"),
        centerTitle: true,
        elevation: 1,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 224, 255, 150),
                Color.fromARGB(255, 169, 240, 178),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),

      body: MetallicBackground(
        child: SafeArea(
          child: Center(
            child:
                _isUploading
    ? Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/upload_complete.gif',
            height: 150,
            fit: BoxFit.contain,
          ),
          const SizedBox(height: 20),
          const Text(
            "Uploading...",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ],
      )
    : GestureDetector(
        onTap: pickMedia,
        child: Container(
          padding: const EdgeInsets.all(16),
          margin: const EdgeInsets.symmetric(horizontal: 24),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFFD4FC79), Color(0xFF96E6A1)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 4),
              )
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.add_a_photo, color: Colors.black, size: 24),
              SizedBox(width: 8),
              Text(
                "Select Media",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      )

          ),
        ),
      ),
      bottomNavigationBar: const BottomNavBarFb2(),
    );
  }
}
