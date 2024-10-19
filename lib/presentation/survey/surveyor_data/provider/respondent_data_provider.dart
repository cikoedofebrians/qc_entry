import 'package:flutter/material.dart';
import 'package:qc_entry/core/errors/failure.dart';
import 'package:qc_entry/data/model/realcount/capres/capres_model.dart';
import 'package:qc_entry/data/model/realcount/dapil/dapil_model.dart';
import 'package:qc_entry/data/repository/raelcount_repository.dart';
import 'package:qc_entry/presentation/survey/list/component/survey_list_item.dart';

class RespondentDataProvider extends ChangeNotifier {
  final RealcountRepository realcountRepository;
  RespondentDataProvider(
    this.realcountRepository,
    this.id,
  );

  final SurveyTakeParams id;
  bool isLoading = false;
  List<Dapil> dapilList = [];
  int? selectedDapilIndex;
  int? selectedKelurahanIndex;
  String kecamatan = "";
  String respondentName = "";

  List<Capres> capresList = [];

  Future<Failure?> getData() async {
    isLoading = true;
    notifyListeners();
    final dapilResult = await getAllDapil();
    isLoading = false;
    notifyListeners();
    return dapilResult;
  }

  Future<Failure?> getAllDapil() async {
    Failure? failure;
    final result = await realcountRepository.getAllDapil();
    result.fold((l) {
      failure = l;
    }, (r) {
      dapilList = r;
      notifyListeners();
    });
    return failure;
  }

  setSelectedDapilIndex(int? newIndex) {
    selectedDapilIndex = newIndex;
    kecamatan = extractKecamatan(dapilList[selectedDapilIndex!].index);
    notifyListeners();
  }

  setSelectedKelurahanIndex(int? newIndex) {
    selectedKelurahanIndex = newIndex;
    notifyListeners();
  }

  setRespondentName(String newName) {
    respondentName = newName;
    notifyListeners();
  }

  String? checkRespondentData() {
    if (selectedDapilIndex == null) return "Dapil tidak boleh kosong";
    if (kecamatan.isEmpty) return "Kecamatan tidak boleh kosong";
    if (selectedKelurahanIndex == null) return "Kelurahan tidak boleh kosong";
    if (respondentName.isEmpty) return "Nama responden tidak boleh kosong";
    return null;
  }

  String extractKecamatan(String text) {
    RegExp regExp = RegExp(r'\((.*?)\)');
    Match? match = regExp.firstMatch(text);
    if (match != null) {
      return match.group(1)!;
    }
    return '';
  }
}
