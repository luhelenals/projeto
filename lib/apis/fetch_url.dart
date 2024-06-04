import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl;

  ApiService(this.baseUrl);

  Future<String> fetchContent(String url) async {
    final response = await http.get(
      Uri.parse('$baseUrl/?html=$url'), // Passing the URL with query parameter
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      return jsonResponse['content'];
    } else {
      throw Exception('Failed to load content');
    }
  }
}
