import 'package:bullet_news/models/category.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class CategoryService {
  Future<List<Category>> fetchNews() async {
    String baseUrl = dotenv.env['API_BASE_URL'] ?? "";
    String? token = await FirebaseAuth.instance.currentUser?.getIdToken();
    if (token == null) {
      throw Exception('Not authenticated');
    }
    final response = await http.get(
      Uri.parse('$baseUrl/api/category'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((news) => Category.fromJson(news)).toList();
    } else {
      throw Exception('Failed to load news');
    }
  }
}
