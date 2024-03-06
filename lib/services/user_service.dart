import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class UserService {
  final String _baseUrl = dotenv.env['API_BASE_URL'] ?? "";

  Future<bool> createOrUpdateUser(User user) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/api/users'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'uuid': user.uid,
        'email': user.email,
      }),
    );
    return response.statusCode == 200;
  }
}
