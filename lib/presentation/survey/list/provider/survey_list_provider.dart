import 'package:flutter/material.dart';
import 'package:qc_entry/core/errors/failure.dart';
import 'package:qc_entry/data/model/survey/survey/survey_model.dart';
import 'package:qc_entry/data/repository/survey_repository.dart';

class SurveyListProvider extends ChangeNotifier {
  SurveyListProvider(this.surveyRepository);
  final SurveyRepository surveyRepository;
  List<Survey> _surveyList = [];
  List<Survey> get surveyList => _surveyList;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  setLoading(bool newValue) {
    _isLoading = newValue;
    notifyListeners();
  }

  Future<Failure?> fetchSurveyList(BuildContext context) async {
    setLoading(true);
    final response = await surveyRepository.getSurveyList();
    Failure? failure;
    response.fold((l) => failure = l, (r) {
      _surveyList = r;
    });
    setLoading(false);
    return failure;
  }
}
