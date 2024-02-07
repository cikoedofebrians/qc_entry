import 'package:flutter/material.dart';

class LoginProvider extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  setLoading(bool newLoading) {
    _isLoading = newLoading;
    notifyListeners();
  }

  String _email = "";
  String get email => _email;
  setEmail(String newEmail) {
    _email = newEmail;
    notifyListeners();
  }

  String _password = "";
  String get password => _password;
  setPassword(String newPassword) {
    _password = newPassword;
    notifyListeners();
  }
}
