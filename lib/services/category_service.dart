import 'package:bullet_news/models/category.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CategoryService {
  Future<List<Category>> fetchNews() async {
    final response =
        await http.get(Uri.parse('http://localhost:8080/api/category'));
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((news) => Category.fromJson(news)).toList();
    } else {
      throw Exception('Failed to load news');
    }
  }
}
