import 'package:http/http.dart' as http;
import 'dart:convert';
import 'HttpCommon.dart';
import '../model/Artist.dart';

class ApiService {
  static const String baseUrl = 'http://10.0.2.2:5281/api/v1';

  Future<http.Response> signIn(Map<String, String> signInRequest) {
    final url = Uri.parse('$baseUrl/authentication/sign-in');
    return HttpCommon.client.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode(signInRequest),
    );
  }

  Future<http.Response> signUp(Map<String, String> signUpRequest) {
    final url = Uri.parse('$baseUrl/authentication/sign-up');
    return HttpCommon.client.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode(signUpRequest),
    );
  }

  Future<http.Response> getAllCustomers() {
    final url = Uri.parse('$baseUrl/customers');
    return HttpCommon.client.get(
      url,
      headers: {'Content-Type': 'application/json'},
    );
  }

  Future<http.Response> getCustomerById(String id) {
    final url = Uri.parse('$baseUrl/customers/$id');
    return HttpCommon.client.get(
      url,
      headers: {'Content-Type': 'application/json'},
    );
  }

  Future<http.Response> createCustomer(Map<String, String> customerResource) {
    final url = Uri.parse('$baseUrl/customers');
    return HttpCommon.client.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode(customerResource),
    );
  }

  Future<http.Response> updateCustomer(String id, Map<String, String> customerResource) {
    final url = Uri.parse('$baseUrl/customers/$id');
    return HttpCommon.client.put(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode(customerResource),
    );
  }

  Future<http.Response> getProfile(String username) {
    final url = Uri.parse('$baseUrl/customers/$username');
    return HttpCommon.client.get(
      url,
      headers: {'Content-Type': 'application/json'},
    );
  }

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