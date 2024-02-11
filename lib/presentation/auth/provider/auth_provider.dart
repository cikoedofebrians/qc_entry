import 'dart:io';

import 'package:flutter/material.dart';
import 'package:qc_entry/core/service/token_service.dart';
import 'package:qc_entry/data/model/app/version/version_model.dart';
import 'package:qc_entry/data/repository/auth_repository.dart';

class AuthProvider extends ChangeNotifier {
  AuthProvider(this.authRepository, this.tokenService);

  final TokenService tokenService;
  final AuthRepository authRepository;

  bool _isSignedIn = false;
  bool get isSignedIn => _isSignedIn;

  Future<String?> checkSignInStatus() async {
    String? errorMessage;
    final getToken = tokenService.getToken();
    if (getToken != null) {
      _isSignedIn = true;
      notifyListeners();
    }
    return errorMessage;
  }

  Future<String?> login(String email, String password) async {
    String? errorMessage;
    if (email.isEmpty) {
      return "Email tidak boleh kosong";
    }
    if (password.isEmpty) {
      return "Password tidak boleh kosong";
    }

    final response = await authRepository.login(email, password);
    response.fold((l) {
      errorMessage = l.message;
    }, (r) {
      _isSignedIn = true;
      notifyListeners();
    });
    return errorMessage;
  }

  Future<String?> logout() async {
    String? errorMessage;
    _isSignedIn = false;
    tokenService.clearToken();
    notifyListeners();

    return errorMessage;
  }
}
