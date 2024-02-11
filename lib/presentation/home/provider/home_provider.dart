import 'dart:io';

import 'package:flutter/material.dart';
import 'package:qc_entry/data/model/app/version/version_model.dart';
import 'package:qc_entry/data/repository/app_repository.dart';

class HomeProvider extends ChangeNotifier {
  final AppRepository appRepository;
  HomeProvider(this.appRepository);
  int _currentPage = 0;

  int get currentPage => _currentPage;

  setCurrentPage(int newPage) {
    _currentPage = newPage;
    notifyListeners();
  }

  Future<Version?> checkAppVersion() async {
    if (Platform.isAndroid || Platform.isIOS) {
      Version? version;
      final result = await appRepository.getAppVersion();
      result.fold((l) => null, (r) => version = r);
      return version;
    } else {
      return null;
    }
  }
}
