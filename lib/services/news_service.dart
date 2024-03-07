import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/news.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:firebase_auth/firebase_auth.dart';

class NewsService {
  Future<List<News>> fetchNews(String id) async {
    String baseUrl = dotenv.env['API_BASE_URL'] ?? "";
    String? token = await FirebaseAuth.instance.currentUser?.getIdToken();
    if (token == null) {
      throw Exception('Not authenticated');
    }
    final response = await http.get(
      Uri.parse('$baseUrl/api/category/$id/news'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((news) => News.fromJson(news)).toList();
    } else {
      throw Exception('Failed to load news');
    }
  }

  Future<void> likeNews(String newsId) async {
    String baseUrl = dotenv.env['API_BASE_URL'] ?? "";
    String? token = await FirebaseAuth.instance.currentUser?.getIdToken();

    if (token == null) {
      throw Exception('Not authenticated');
    }

    final response = await http.post(
      Uri.parse('$baseUrl/api/news/$newsId/like'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to like news');
    }
  }
}
