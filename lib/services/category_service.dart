import 'package:bullet_news/models/category.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class CategoryService {
  Future<List<Category>> fetchNews() async {
    String baseUrl = dotenv.env['API_BASE_URL'] ?? "";
    final response = await http.get(Uri.parse('$baseUrl/api/category'));
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((news) => Category.fromJson(news)).toList();
    } else {
      throw Exception('Failed to load news');
    }
  }
}
