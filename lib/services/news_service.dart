import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/news.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class NewsService {
  Future<List<News>> fetchNews() async {
    String baseUrl = dotenv.env['API_BASE_URL'] ?? "";
    final response = await http.get(Uri.parse('$baseUrl/api/category/1/news'));
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((news) => News.fromJson(news)).toList();
    } else {
      throw Exception('Failed to load news');
    }
  }
}
