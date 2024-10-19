import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:qc_entry/data/model/survey/survey_question/survey_question.dart';
import 'package:qc_entry/data/repository/survey_repository.dart';
import 'package:qc_entry/data/model/survey/survey_option/survey_option.dart';

class SurveyTakeProvider extends ChangeNotifier {
  SurveyTakeProvider({
    required this.surveyRepository,
    required this.kecamatan,
    required this.kelurahan,
    required this.respondentName,
  });

  final SurveyRepository surveyRepository;
  final String kecamatan;
  final String kelurahan;
  final String respondentName;

  TextEditingController textEditingController = TextEditingController();
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
  List<int> previousIndex = [];

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
    numberAnswer = "";
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
      if (radioAnswer == "Lainnya" &&
          !(otherRadioAnswer != null && otherRadioAnswer!.isNotEmpty)) {
        return "Tolong pilih salah satu pilihan yang disediakan";
      }
      if (radioAnswer == "Lainnya") {
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
      if (dateTimeAnswer == null) return "Tanggal tidak boleh kosong";
      submitBody[currentQuestionIndex]['answer'] = dateTimeAnswer;
    }

    if (currentQuestionIndex == surveyQuestions.length - 1) {
      setSubmitLoading(true);
      final response = await surveyRepository.submitAnswer({
        "nama_responden": respondentName,
        "kecamatan": kecamatan,
        "kelurahan": kelurahan,
        "answers": submitBody,
      });
      setSubmitLoading(false);
      String message = "";
      response.fold((l) => message = l.message, (r) => message = "complete");
      return message;
    } else if (willSkipPage != null) {
      previousIndex.add(currentQuestionIndex);
      currentQuestionIndex = willSkipPage! - 1;
    } else {
      previousIndex.add(currentQuestionIndex);
      currentQuestionIndex += 1;
    }
    log(submitBody.toString());
    resetQuestion();
    textEditingController.clear();
    notifyListeners();
    Future.delayed(const Duration(milliseconds: 100)).then((_) {
      reAttach();
      notifyListeners();
    });
    return null;
  }

  goToPreviousQuestion() {
    final currentQuestion = surveyQuestions[currentQuestionIndex];
    if (currentQuestion.type == QuestionType.RADIO) {
      if (radioAnswer.isNotEmpty &&
          !(radioAnswer == "Lainnya" &&
              otherRadioAnswer == null &&
              otherRadioAnswer!.isEmpty)) {
        if (radioAnswer == "Lainnya") {
          submitBody[currentQuestionIndex]['answer'] =
              textEditingController.text;
        } else {
          submitBody[currentQuestionIndex]['answer'] = radioAnswer;
        }
      }
    }
    if (currentQuestion.type == QuestionType.TEXT ||
        currentQuestion.type == QuestionType.TEXTAREA) {
      if (textAreaAnswer.isNotEmpty) {
        submitBody[currentQuestionIndex]['answer'] = textAreaAnswer;
      }
    }

    if (currentQuestion.type == QuestionType.NUMBER) {
      if (numberAnswer != null && numberAnswer!.isNotEmpty) {
        submitBody[currentQuestionIndex]['answer'] = numberAnswer;
      }
    }

    if (currentQuestion.type == QuestionType.TIME) {
      if (timeAnswer != null && timeAnswer!.isNotEmpty) {
        submitBody[currentQuestionIndex]['answer'] = timeAnswer;
      }
    }

    if (currentQuestion.type == QuestionType.DATE) {
      if (dateTimeAnswer != null && dateTimeAnswer!.isNotEmpty) {
        submitBody[currentQuestionIndex]['answer'] = dateTimeAnswer;
      }
    }
    textEditingController.clear();
    currentQuestionIndex = previousIndex.last;
    previousIndex.removeLast();

    reAttach();
    notifyListeners();
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

  reAttach() {
    final String? answer = submitBody[currentQuestionIndex]['answer'];
    if (answer != null) {
      if (surveyQuestions[currentQuestionIndex].type == QuestionType.RADIO) {
        final isLainya = surveyQuestions[currentQuestionIndex]
            .options
            .indexWhere((element) => element.option == answer);

        if (isLainya < 0) {
          radioAnswer = 'Lainnya';
          otherRadioAnswer = answer;
          textEditingController.text = answer;
        } else {
          radioAnswer = answer;
        }
      }
      if (surveyQuestions[currentQuestionIndex].type == QuestionType.TEXT ||
          surveyQuestions[currentQuestionIndex].type == QuestionType.TEXTAREA) {
        textEditingController.text = answer;
        textAreaAnswer = answer;
      }

      if (surveyQuestions[currentQuestionIndex].type == QuestionType.NUMBER) {
        textEditingController.text = answer;
        numberAnswer = answer;
      }

      if (surveyQuestions[currentQuestionIndex].type == QuestionType.TIME) {
        timeAnswer = answer;
      }

      if (surveyQuestions[currentQuestionIndex].type == QuestionType.DATE) {
        dateTimeAnswer = answer;
      }
      // notifyListeners();
    }
  }
}

String convertTo24Hour(TimeOfDay timeOfDay) {
  final int hour = timeOfDay.hour;
  final int minute = timeOfDay.minute;
  return '${hour < 10 ? '0$hour' : hour}:${minute < 10 ? '0$minute' : minute}';
}

TimeOfDay stringToTimeOfDay(String time) {
  final format = time.split(":");
  final hour = int.parse(format[0]);
  final minute = int.parse(format[1]);

  return TimeOfDay(hour: hour, minute: minute);
}
