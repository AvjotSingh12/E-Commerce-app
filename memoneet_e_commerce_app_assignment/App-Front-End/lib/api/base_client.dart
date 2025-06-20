import 'dart:convert';
import 'package:http/http.dart' as http;

class BaseClient {
  static const String _baseUrl = "https://e-commerce-app-0t93.onrender.com"; // Change for real device

  static Future<dynamic> post(String endpoint, Map<String, dynamic> data) async {
    final url = Uri.parse("$_baseUrl$endpoint");

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(data),
      );

      final decoded = jsonDecode(response.body);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return decoded;
      } else {
        throw decoded["error"] ?? "Something went wrong";
      }
    } catch (e) {
      rethrow;
    }
  }
}
