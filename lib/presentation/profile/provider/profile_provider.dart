import 'package:flutter/material.dart';
import 'package:qc_entry/data/model/auth/user/user_model.dart';
import 'package:qc_entry/data/repository/auth_repository.dart';
import 'package:qc_entry/presentation/shared/custom_.dart';

class ProfileProvider extends ChangeNotifier {
  ProfileProvider(this.authRepository);
  AuthRepository authRepository;

  User? _user;
  User? get user => _user;

  setUser(User newUser) {
    _user = newUser;
    notifyListeners();
  }

  fetchUsers(BuildContext context) async {
    final response = await authRepository.getMe();
    response.fold((l) {
      showQCEntrySnackBar(context: context, title: l.message);
    }, (r) => setUser(r));
  }
}
