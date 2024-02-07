import 'package:flutter/material.dart';
import 'package:qc_entry/data/model/realcount/dapil/dapil_model.dart';
import 'package:qc_entry/data/model/realcount/partai/partai_model.dart';
import 'package:qc_entry/data/repository/raelcount_repository.dart';

class PartaiProvider extends ChangeNotifier {
  PartaiProvider(this.realcountRepository);
  final RealcountRepository realcountRepository;
  List<Partai> partaiList = [];

  bool isLoading = false;
  List<Dapil> dapilList = [];
  int? selectedDapilIndex;
  int? selectedKelurahanIndex;
  String unsuccessfulVotes = "";
  String tps = "";
  String enumeratorNotes = "";

  Future<String?> getData() async {
    isLoading = true;
    notifyListeners();
    final dapilResult = await getAllDapil();
    if (dapilResult != null) return dapilResult;
    final capresResult = await getAllPartai();
    isLoading = false;
    notifyListeners();
    return capresResult;
  }

  Future<String?> getAllDapil() async {
    String? errorMessage;
    final result = await realcountRepository.getAllDapil();
    result.fold((l) {
      errorMessage = l.message;
    }, (r) {
      dapilList = r;
      notifyListeners();
    });
    return errorMessage;
  }

  Future<String?> getAllPartai() async {
    String? errorMessage;
    final result = await realcountRepository.getAllPartai();
    result.fold((l) {
      errorMessage = l.message;
    }, (r) {
      partaiList = r;
      notifyListeners();
    });
    return errorMessage;
  }
}
