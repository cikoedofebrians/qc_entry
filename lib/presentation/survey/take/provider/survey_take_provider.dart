import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
  String? dateTimeAnswer;
  int? willSkipPage;
  String? otherRadioAnswer;
  String? numberAnswer;

  List<Map<String, dynamic>> submitBody = [];

  int surveyId = 0;
  changeSurveyId(int value) {
    surveyId = value;
  }

  changeNumberAnswer(String answer) {
    numberAnswer = answer;
  }

  changeDateTimeAnswer(DateTime newDateTime) {
    dateTimeAnswer = DateFormat('dd MMMM yyyy').format(newDateTime);
    notifyListeners();
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
    final currentQuestion = surveyQuestions[currentQuestionIndex];
    if (currentQuestion.type == QuestionType.RADIO) {
      if (radioAnswer.isEmpty) {
        return "Tolong pilih salah satu pilihan yang disediakan";
      }
      if (radioAnswer == "Lainnya" &&
          otherRadioAnswer != null &&
          otherRadioAnswer!.isNotEmpty) {
        submitBody[currentQuestionIndex]['answer'] = otherRadioAnswer;
      } else {
        submitBody[currentQuestionIndex]['answer'] = radioAnswer;
      }
    }
    if (currentQuestion.type == QuestionType.TEXT ||
        currentQuestion.type == QuestionType.TEXTAREA) {
      if (textAreaAnswer.isEmpty) return "Text field tidak boleh kosong";
      submitBody[currentQuestionIndex]['answer'] = textAreaAnswer;
    }

    if (currentQuestion.type == QuestionType.NUMBER) {
      if (numberAnswer == null) return "Angka tidak boleh kosong";
      submitBody[currentQuestionIndex]['answer'] = numberAnswer;
    }

    if (currentQuestion.type == QuestionType.TIME) {
      if (timeAnswer == null) return "Jam tidak boleh kosong";
      submitBody[currentQuestionIndex]['answer'] = timeAnswer;
    }

    if (currentQuestion.type == QuestionType.DATE) {
      submitBody[currentQuestionIndex]['answer'] = dateTimeAnswer;
    }

    if (currentQuestionIndex == surveyQuestions.length - 1) {
      final response = await surveyRepository.submitAnswer(submitBody);
      String message = "";
      response.fold((l) => message = l.message, (r) => message = "complete");
      return message;
    } else if (willSkipPage != null) {
      currentQuestionIndex = willSkipPage! - 1;
    } else {
      currentQuestionIndex += 1;
    }
    resetQuestion();
    notifyListeners();
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

      for (var i in r.data) {
        submitBody.add({
          'survey_question_id': i.id,
          'answer': null,
        });
      }
    });

    setLoading(false);
  }
}

String convertTo24Hour(TimeOfDay timeOfDay) {
  final int hour = timeOfDay.hour;
  final int minute = timeOfDay.minute;
  return '${hour < 10 ? '0$hour' : hour}:${minute < 10 ? '0$minute' : minute}';
}
