import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import '../models/comment.dart';

class CommentService {
  Future<List<Comment>> fetchCommentsForNews(String newsId) async {
    String baseUrl = dotenv.env['API_BASE_URL'] ?? "";
    String? token = await FirebaseAuth.instance.currentUser?.getIdToken();
    if (token == null) {
      throw Exception('Not authenticated');
    }

    final response = await http.get(
      Uri.parse('$baseUrl/api/comments/news/$newsId'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((comment) => Comment.fromJson(comment)).toList();
    } else {
      throw Exception('Failed to load news');
    }
  }

  Future<Comment> addCommentForNews(String newsId, String content) async {
    String baseUrl = dotenv.env['API_BASE_URL'] ?? "";
    String? token = await FirebaseAuth.instance.currentUser?.getIdToken();
    if (token == null) {
      throw Exception('Not authenticated');
    }

    final response = await http.post(
      Uri.parse('$baseUrl/api/comments/news/$newsId'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'content': content,
      }),
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = json.decode(response.body);
      return Comment.fromJson(jsonResponse);
    } else {
      throw Exception('Failed to load news');
    }
  }

  Future<void> deleteCommentById(int commentId) async {
    String baseUrl = dotenv.env['API_BASE_URL'] ?? "";
    String? token = await FirebaseAuth.instance.currentUser?.getIdToken();
    if (token == null) {
      throw Exception('Not authenticated');
    }

    final response = await http.delete(
      Uri.parse('$baseUrl/api/comments/$commentId'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 204) {
      if (kDebugMode) {
        print("Comment deleted successfully");
      }
    } else {
      throw Exception('Failed to delete news');
    }
  }
}
