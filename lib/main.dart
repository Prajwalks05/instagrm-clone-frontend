import 'package:flutter/material.dart';
import 'package:instagram_clone/screens/login_screen.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
Future<void> main() async {
  await dotenv.load(fileName: "assets/config/.env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Instagram Clone',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const LoginScreen(), // Opens login screen first
    );
  }
}
