import 'package:flutter/material.dart';
import 'package:qc_entry/data/model/survey/survey_question/survey_question.dart';
import 'package:qc_entry/data/repository/survey_repository.dart';
import 'package:qc_entry/data/model/survey/survey_option/survey_option.dart';

class SurveyTakeProvider extends ChangeNotifier {
  SurveyTakeProvider(this.surveyRepository);
  final SurveyRepository surveyRepository;
  List<SurveyQuestion> surveyQuestions = [];
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  int currentQuestionIndex = 0;
  bool isAllComplete = false;
  String radioAnswer = "";
  String textAreaAnswer = "";
  String? timeAnswer;
  DateTime? dateTimeAnswer;
  int? willSkipPage;
  String? otherRadioAnswer;

  int surveyId = 0;
  changeSurveyId(int value) {
    surveyId = value;
  }

  changeOtherRadioAnswer(String newValue) {
    otherRadioAnswer = newValue;
  }

  void changeTime(TimeOfDay tod) {
    timeAnswer = convertTo24Hour(tod);
    notifyListeners();
  }

  void changeTextArea(String newValue) {
    textAreaAnswer = newValue;
  }

  void resetQuestion() {
    radioAnswer = "";
    textAreaAnswer = "";
    timeAnswer = null;
    dateTimeAnswer = null;
    willSkipPage = null;
  }

  selectRadio(Option option) {
    radioAnswer = option.option;
    willSkipPage = option.skip;
    notifyListeners();
  }

  Future<String?> continueQuestion(BuildContext context) async {
    bool isError = false;

    final currentQuestion = surveyQuestions[currentQuestionIndex];
    if (currentQuestion.type == QuestionType.RADIO) {
      if (radioAnswer.isEmpty) {
        return "Tolong pilih salah satu pilihan yang disediakan";
      }
      _isSubmitLoading = true;
      notifyListeners();
      if (radioAnswer == "Lainnya" &&
          otherRadioAnswer != null &&
          otherRadioAnswer!.isNotEmpty) {
        final response = await surveyRepository.submitOneAnswer(
            currentQuestion.id, otherRadioAnswer!);
        response.fold((l) => isError = true, (r) => null);
      } else {
        final response = await surveyRepository.submitOneAnswer(
            currentQuestion.id, radioAnswer);
        response.fold((l) => isError = true, (r) => null);
      }

      _isSubmitLoading = false;
      notifyListeners();
    }
    if (currentQuestion.type == QuestionType.TEXT ||
        currentQuestion.type == QuestionType.TEXTAREA) {
      if (textAreaAnswer.isEmpty) return "Text field tidak boleh kosong";
      _isSubmitLoading = true;
      notifyListeners();
      final response = await surveyRepository.submitOneAnswer(
          currentQuestion.id, textAreaAnswer);
      response.fold((l) => isError = true, (r) => null);
      _isSubmitLoading = false;
      notifyListeners();
    }
    // if (currentQuestion.type == QuestionType.DATE) {}
    if (currentQuestion.type == QuestionType.TIME) {
      if (timeAnswer == null) return "Jam tidak boleh kosong";
      _isSubmitLoading = true;
      notifyListeners();
      final response = await surveyRepository.submitOneAnswer(
          currentQuestion.id, timeAnswer!);
      response.fold((l) => isError = true, (r) => null);
      _isSubmitLoading = false;
      notifyListeners();
    }

    if (isError) return "Terjadi kesalahan";

    if (willSkipPage != null) {
      currentQuestionIndex = willSkipPage! - 1;
      notifyListeners();
      resetQuestion();
      return null;
    }

    resetQuestion();
    if (currentQuestionIndex == (surveyQuestions.length - 1)) {
      surveyRepository.finishSurvey(surveyId);
      return "complete";
    } else {
      currentQuestionIndex += 1;
    }
    return null;
  }

  setLoading(bool newValue) {
    _isLoading = newValue;
    notifyListeners();
  }

  bool _isSubmitLoading = false;
  bool get isSubmitLoading => _isSubmitLoading;

  setSubmitLoading(bool newValue) {
    _isSubmitLoading = newValue;
    notifyListeners();
  }

  getAllQuestions(int id) async {
    setLoading(true);
    final response = await surveyRepository.getAllQuestion(id);

    response.fold((l) => null, (r) {
      surveyQuestions = r.data;
    });

    setLoading(false);
  }
}

String convertTo24Hour(TimeOfDay timeOfDay) {
  final int hour = timeOfDay.hour;
  final int minute = timeOfDay.minute;
  return '${hour < 10 ? '0$hour' : hour}:${minute < 10 ? '0$minute' : minute}';
}
