import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:instagram_clone/components/metallic_background.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart'; // Make sure dotenv is imported

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _obscurePassword = true;

  Future<void> signUp(String email, String password, String username) async {
    final apiBaseUrl = (dotenv.env['API_URL'] ?? '').replaceAll(
      RegExp(r'/$'),
      '',
    );
    try {
      final response = await http.post(
        Uri.parse('$apiBaseUrl/auth/signup'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "email": email,
          "password": password,
          "username": username,
        }),
      );

      final Map<String, dynamic> resBody = jsonDecode(response.body);

      if (response.statusCode == 200 && resBody["success"] == true) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString("userId", resBody["userId"]);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(resBody["error"] ?? "Signup failed")),
        );
      }
    } catch (e) {
      print("Error during signup: $e");
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error: ${e.toString()}')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: MetallicBackground(
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ColorFiltered(
                    colorFilter: const ColorFilter.mode(
                      Colors.transparent,
                      BlendMode.multiply,
                    ),
                    child: Image.asset('assets/instagram_logo.png', height: 64),
                  ),
                  const SizedBox(height: 48),
                  TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      hintText: 'Email',
                      filled: true,
                      fillColor: Colors.grey[100],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: usernameController,
                    decoration: InputDecoration(
                      hintText: 'Username',
                      filled: true,
                      fillColor: Colors.grey[100],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: passwordController,
                    obscureText: _obscurePassword,
                    decoration: InputDecoration(
                      hintText: 'Password',
                      filled: true,
                      fillColor: Colors.grey[100],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      minimumSize: const Size.fromHeight(50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () async {
                      final email = emailController.text.trim();
                      final username = usernameController.text.trim();
                      final password = passwordController.text.trim();

                      print("Signup button clicked with: $email, $username");
                      await signUp(email, password, username);
                    },
                    child: const Text(
                      "Sign Up",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("Already have an account? Log in"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
