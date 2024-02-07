import 'package:shared_preferences/shared_preferences.dart';

class TokenService {
  final SharedPreferences sharedPreferences;

  TokenService(this.sharedPreferences);
  String? getToken() {
    final token = sharedPreferences.getString('token');
    return token;
  }

  void saveToken(String token) async {
    await sharedPreferences.setString('token', token);
  }

  void clearToken() async {
    await sharedPreferences.remove('token');
    await sharedPreferences.clear();
  }
}
