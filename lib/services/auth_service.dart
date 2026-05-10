import '../models/user_model.dart';
import 'database_service.dart';

class AuthService {
  AuthService(this._api);

  final DatabaseService _api;

  Future<UserModel> register({
    required String name,
    required String email,
    required String password,
    String? phone,
    String? shopName,
  }) async {
    final response = await _api.post('/register', {
      'name': name,
      'email': email,
      'password': password,
      'phone': ?phone,
      'shop_name': ?shopName,
    }, auth: false);
    await _persistToken(response);
    return _userFrom(response);
  }

  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    final response = await _api.post('/login', {
      'email': email,
      'password': password,
    }, auth: false);
    await _persistToken(response);
    return _userFrom(response);
  }

  Future<UserModel> currentUser() async {
    final response = await _api.get('/user');
    return UserModel.fromJson(_api.unwrapMap(response));
  }

  Future<void> logout() async {
    try {
      await _api.post('/logout', {});
    } finally {
      await _api.clearToken();
    }
  }

  Future<bool> hasToken() async => (await _api.getToken())?.isNotEmpty ?? false;

  Future<void> _persistToken(dynamic response) async {
    if (response is Map) {
      final token =
          response['token'] ??
          response['access_token'] ??
          response['plainTextToken'];
      if (token != null) {
        await _api.saveToken(token.toString());
      }
    }
  }

  UserModel _userFrom(dynamic response) {
    if (response is Map) {
      final user =
          response['user'] ?? response['data']?['user'] ?? response['data'];
      if (user is Map) {
        return UserModel.fromJson(Map<String, dynamic>.from(user));
      }
    }
    return UserModel.fromJson(_api.unwrapMap(response));
  }
}
