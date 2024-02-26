import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/news.dart';

class NewsService {
  Future<List<News>> fetchNews() async {
    final response = await http.get(Uri.parse(''));
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((news) => News.fromJson(news)).toList();
    } else {
      throw Exception('Failed to load news');
    }
  }
}
