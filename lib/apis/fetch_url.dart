import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl;

  ApiService(this.baseUrl);

 Future<Map<String, dynamic>> fetchContent(String url) async {
    final response = await http.get(
      Uri.parse("$baseUrl?html=$url"),
    );

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body)['content'];
      final produtos = jsonResponse['produtos'];

      final postData = {'produtos': produtos};

      final postResponse = await http.post(
        Uri.parse("http://192.168.41.38:5000/predict"),
        headers: {
          "Content-Type": "application/json",
          "Access-Control-Allow-Origin": "*"},
        body: jsonEncode(postData),
      );

      if (postResponse.statusCode == 200) {
        final predictions = jsonDecode(postResponse.body);
        final results = {
          'produtos': produtos,
          'categoria': predictions,
          'data': jsonResponse['data'],
          'preços': jsonResponse['preços']
        };
        return results;
      }
      else {
        throw Exception('Failed to get predictions: ${postResponse.statusCode} ${postResponse.body}');
      }
    } else {
      throw Exception('Failed to load content');
    }
  }
}
