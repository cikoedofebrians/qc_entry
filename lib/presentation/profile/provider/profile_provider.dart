import 'package:flutter/material.dart';
import 'package:qc_entry/core/errors/failure.dart';
import 'package:qc_entry/data/model/auth/user/user_model.dart';
import 'package:qc_entry/data/repository/auth_repository.dart';

class ProfileProvider extends ChangeNotifier {
  ProfileProvider(this.authRepository);
  AuthRepository authRepository;

  User? _user;
  User? get user => _user;

  setUser(User newUser) {
    _user = newUser;
    notifyListeners();
  }

  Future<Failure?> fetchUsers(BuildContext context) async {
    Failure? failure;
    final response = await authRepository.getMe();
    response.fold((l) {
      failure = l;
    }, (r) => setUser(r));
    return failure;
  }
}
