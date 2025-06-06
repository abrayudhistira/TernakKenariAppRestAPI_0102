import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class ServicesHttpClient {
  final String baseUrl = 'https://10.0.0.2:8000/api';
  final secureStorage = FlutterSecureStorage();
  
  Future<http.Response> post(String endpoint, Map<String, dynamic> body) async {
    final url = Uri.parse('$baseUrl/$endpoint');
    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode(body),
      );
      return response;
    } catch (e) {
      throw Exception('POST request failed: $e');
    }
  }

  Future<http.Response> postiWithToken(String endpoint, Map<String, dynamic> body) async {
    final url = Uri.parse('$baseUrl/$endpoint');
    final token = await secureStorage.read(key: "token");
    try {
      final response = await http.post(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode(body),
      );
      return response;
    } catch (e) {
      throw Exception('POST request failed: $e');
    }
  }

  Future<http.Response> get(String endpoint) async {
    final url = Uri.parse('$baseUrl/$endpoint');
    final token = await secureStorage.read(key: "token");
    try {
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );
      return response;
    } catch (e) {
      throw Exception('GET request failed: $e');
    }
  }
}