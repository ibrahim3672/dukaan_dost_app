import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiException implements Exception {
  const ApiException(this.message, {this.statusCode});

  final String message;
  final int? statusCode;

  @override
  String toString() => 'ApiException($statusCode): $message';
}

class DatabaseService {
  DatabaseService({http.Client? client, String? baseUrl})
    : _client = client ?? http.Client(),
      baseUrl =
          baseUrl ??
          const String.fromEnvironment(
            'API_BASE_URL',
            defaultValue: 'http://localhost:8000/api',
          );

  final http.Client _client;
  final String baseUrl;
  static const _tokenKey = 'sanctum_token';

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }

  Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
  }

  Future<void> clearToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
  }

  Future<dynamic> get(String path, {bool auth = true}) =>
      _request('GET', path, auth: auth);
  Future<dynamic> post(
    String path,
    Map<String, dynamic> body, {
    bool auth = true,
  }) => _request('POST', path, body: body, auth: auth);
  Future<dynamic> put(
    String path,
    Map<String, dynamic> body, {
    bool auth = true,
  }) => _request('PUT', path, body: body, auth: auth);
  Future<dynamic> delete(String path, {bool auth = true}) =>
      _request('DELETE', path, auth: auth);

  Future<dynamic> _request(
    String method,
    String path, {
    Map<String, dynamic>? body,
    bool auth = true,
  }) async {
    final uri = Uri.parse('$baseUrl$path');
    final headers = <String, String>{
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    };

    if (auth) {
      final token = await getToken();
      if (token != null && token.isNotEmpty) {
        headers['Authorization'] = 'Bearer $token';
      }
    }

    final encodedBody = body == null ? null : jsonEncode(body);
    final response = switch (method) {
      'GET' => await _client.get(uri, headers: headers),
      'POST' => await _client.post(uri, headers: headers, body: encodedBody),
      'PUT' => await _client.put(uri, headers: headers, body: encodedBody),
      'DELETE' => await _client.delete(uri, headers: headers),
      _ => throw ApiException('Unsupported method: $method'),
    };

    final decoded = _decode(response.body);
    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw ApiException(
        _messageFrom(decoded),
        statusCode: response.statusCode,
      );
    }
    return decoded;
  }

  dynamic unwrap(dynamic response) {
    if (response is Map<String, dynamic>) {
      return response['data'] ?? response['result'] ?? response;
    }
    return response;
  }

  List<Map<String, dynamic>> unwrapList(dynamic response) {
    final data = unwrap(response);
    if (data is List) {
      return data
          .whereType<Map>()
          .map((item) => Map<String, dynamic>.from(item))
          .toList();
    }
    if (data is Map && data['data'] is List) {
      return (data['data'] as List)
          .whereType<Map>()
          .map((item) => Map<String, dynamic>.from(item))
          .toList();
    }
    return const [];
  }

  Map<String, dynamic> unwrapMap(dynamic response) {
    final data = unwrap(response);
    if (data is Map<String, dynamic>) return data;
    if (data is Map) return Map<String, dynamic>.from(data);
    return <String, dynamic>{};
  }

  dynamic _decode(String body) {
    if (body.trim().isEmpty) return null;
    try {
      return jsonDecode(body);
    } catch (_) {
      return body;
    }
  }

  String _messageFrom(dynamic decoded) {
    if (decoded is Map) {
      return (decoded['message'] ??
              decoded['error'] ??
              decoded['errors'] ??
              'Request failed')
          .toString();
    }
    return decoded?.toString() ?? 'Request failed';
  }
}
