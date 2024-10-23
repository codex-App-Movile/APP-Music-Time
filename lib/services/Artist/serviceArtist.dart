import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../model/artist/Artist.dart';

class ApiService {
  static const String baseUrl = 'http://10.0.2.2:5281/api/v1';

  Future<List<Artist>> fetchArtists() async {
    final url = Uri.parse('$baseUrl/artists');
    final response = await http.get(
      url,
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      print('API Response: $body'); // Debug statement
      return body.map((dynamic item) => Artist.fromJson(item)).toList();
    } else {
      print('Failed to load artists: ${response.statusCode}'); // Debug statement
      throw Exception('Failed to load artists');
    }
  }
}