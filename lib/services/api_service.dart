import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<List<Map<String, dynamic>>> fetchStories() async {
  final apiBaseUrl = dotenv.env['API_URL'] ?? "http://localhost:5001";
  final response = await http.get(Uri.parse("$apiBaseUrl/stories"));

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    if (data["success"] == true && data["stories"] is List) {
      return (data["stories"] as List)
          .map(
            (story) => {
              "userId": story["userId"].toString(),
              "urls": story["urls"] as List<dynamic>, // Keep as List<dynamic>
            },
          )
          .toList();
    }
  }
  return [];
}

Future<List<Map<String, String>>> fetchPosts() async {
  final apiBaseUrl = dotenv.env['API_URL'] ?? "http://localhost:5001";
  final response = await http.get(Uri.parse("$apiBaseUrl/posts"));

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);

    if (data["success"] == true && data["posts"] is List) {
      return (data["posts"] as List)
          .map(
            (post) => {
              "userId": post["userId"].toString(),
              "url": post["url"].toString(),
            },
          )
          .toList();
    }
  }
  return [];
}
