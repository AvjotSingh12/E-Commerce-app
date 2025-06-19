import 'base_client.dart';

class UserApi {
  static Future<Map<String, dynamic>> signup(String name, String email) async {
    final response = await BaseClient.post(
      "/api/users",
      {"name": name, "email": email},
    );
    return response;
  }

  static Future<Map<String, dynamic>> login(String email) async {
    final response = await BaseClient.post(
      "/api/users/login",
      {"email": email},
    );
    return response;
  }
}
