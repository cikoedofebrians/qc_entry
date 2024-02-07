import 'package:flutter/material.dart';

class HomeProvider extends ChangeNotifier {
  int _currentPage = 0;

  int get currentPage => _currentPage;

  setCurrentPage(int newPage) {
    _currentPage = newPage;
    notifyListeners();
  }
}
