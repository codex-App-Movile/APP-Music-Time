import 'package:http/http.dart' as http;
import 'dart:convert';
import '../HttpCommon.dart';

class ServiceCustomer {
  static const String baseUrl = 'http://10.0.2.2:5281/api/v1';

  Future<http.Response> getAllCustomers() {
    final url = Uri.parse('$baseUrl/customers');
    return HttpCommon.client.get(
      url,
      headers: {'Content-Type': 'application/json'},
    );
  }

  Future<http.Response> getCustomerById(String customerId) {
    final url = Uri.parse('$baseUrl/customers/$customerId');
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

  Future<http.Response> updateCustomer(String customerId, Map<String, String> customerResource) {
    final url = Uri.parse('$baseUrl/customers/$customerId');
    return HttpCommon.client.put(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode(customerResource),
    );
  }
}