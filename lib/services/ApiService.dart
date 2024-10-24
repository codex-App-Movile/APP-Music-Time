import 'package:http/http.dart' as http;
import 'dart:convert';
import 'HttpCommon.dart';

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

  Future<void> signOut() async {
    // Simulate sign-out process
    await Future.delayed(Duration(seconds: 1));
  }
}