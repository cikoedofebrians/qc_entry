import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:provider/provider.dart';
import 'package:qc_entry/core/extension/text_extension.dart';
import 'package:qc_entry/core/injector/injector.dart';
import 'package:qc_entry/core/theme/app_color.dart';
import 'package:qc_entry/core/theme/app_text.dart';
import 'package:qc_entry/data/model/survey/survey_question/survey_question.dart';
import 'package:qc_entry/presentation/shared/custom_.dart';
import 'package:qc_entry/presentation/shared/custom_button.dart';
import 'package:qc_entry/presentation/survey/complete/screen/complete_page.dart';
import 'package:qc_entry/presentation/survey/take/provider/survey_take_provider.dart';

class SurveyTakePage extends StatelessWidget {
  const SurveyTakePage({super.key});
  static const route = "/survey/take";

  @override
  Widget build(BuildContext context) {
    final surveyId = ModalRoute.of(context)!.settings.arguments as int;
    return ChangeNotifierProvider(
      create: (context) =>
          getIt<SurveyTakeProvider>()..getAllQuestions(surveyId),
      child: const SurveyTakeView(),
    );
  }
}

class SurveyTakeView extends StatefulWidget {
  const SurveyTakeView({super.key});

  @override
  State<SurveyTakeView> createState() => _SurveyTakeViewState();
}

class _SurveyTakeViewState extends State<SurveyTakeView> {
  late final TextEditingController textEditingController;
  @override
  void initState() {
    textEditingController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final surveyTakeProvider = Provider.of<SurveyTakeProvider>(context);
    final appbar = AppBar(
      automaticallyImplyLeading: true,
      title: const Text("Survei Tahap 2"),
    );
    final mediaQuery = MediaQuery.of(context);
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () async => true,
      child: Scaffold(
        appBar: appbar,
        body: Builder(builder: (context) {
          if (surveyTakeProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          final currentQuestion = surveyTakeProvider
              .surveyQuestions[surveyTakeProvider.currentQuestionIndex];
          final QuestionType currentQuestionType = currentQuestion.type;

          return SingleChildScrollView(
            child: Container(
              height: mediaQuery.size.height -
                  appbar.preferredSize.height -
                  mediaQuery.padding.top,
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            currentQuestion.surveyCategory.name,
                            style: AppTextStyle.body3
                                .setRegular()
                                .copyWith(color: AppColor.secondaryColor),
                          ),
                          const SizedBox(height: 8),
                          Html(
                            data: currentQuestion.question ?? "",
                            style: {
                              "b": Style(
                                  fontSize: FontSize(20),
                                  fontWeight: FontWeight.bold,
                                  margin: Margins.zero,
                                  padding: HtmlPaddings.zero,
                                  color: AppColor.primaryColor),
                              "p": Style(
                                  fontSize: FontSize(20),
                                  fontWeight: FontWeight.normal,
                                  margin: Margins.zero,
                                  padding: HtmlPaddings.zero,
                                  color: AppColor.primaryColor),
                              "body": Style(
                                padding: HtmlPaddings.zero,
                                margin: Margins.zero,
                              ),
                            },
                          ),
                          const SizedBox(height: 14),
                          Builder(
                            builder: (context) {
                              if (currentQuestionType ==
                                      QuestionType.TEXTAREA ||
                                  currentQuestionType == QuestionType.TEXT) {
                                return Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                        width: 2, color: AppColor.primaryColor),
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                          blurRadius: 10,
                                          color: Colors.black.withOpacity(0.1))
                                    ],
                                  ),
                                  child: TextField(
                                    controller: textEditingController,
                                    onChanged: (value) => surveyTakeProvider
                                        .changeTextArea(value),
                                    maxLines: null,
                                    decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        contentPadding: EdgeInsets.all(10),
                                        hintText: "Isi jawaban anda disini..."),
                                  ),
                                );
                              } else if (currentQuestionType ==
                                  QuestionType.RADIO) {
                                return ListView.separated(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemBuilder: (_, index) => Material(
                                          color: currentQuestion
                                                      .options[index].option ==
                                                  surveyTakeProvider.radioAnswer
                                              ? AppColor.primaryColor
                                              : Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: InkWell(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            onTap: () => surveyTakeProvider
                                                .selectRadio(currentQuestion
                                                    .options[index]),
                                            child: Ink(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 16,
                                                      vertical: 12),
                                              decoration: BoxDecoration(
                                                color: currentQuestion
                                                            .options[index]
                                                            .option ==
                                                        surveyTakeProvider
                                                            .radioAnswer
                                                    ? AppColor.primaryColor
                                                    : Colors.white,
                                                boxShadow: [
                                                  BoxShadow(
                                                      blurRadius: 10,
                                                      color: Colors.black
                                                          .withOpacity(0.1))
                                                ],
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                border: Border.all(
                                                  width: 2,
                                                  color: AppColor.primaryColor,
                                                ),
                                              ),
                                              child: index ==
                                                          currentQuestion
                                                                  .options
                                                                  .length -
                                                              1 &&
                                                      currentQuestion
                                                              .options[index]
                                                              .option ==
                                                          "Lainnya"
                                                  ? TextField(
                                                      controller:
                                                          textEditingController,
                                                      style: AppTextStyle.body2.copyWith(
                                                          color: surveyTakeProvider
                                                                      .radioAnswer ==
                                                                  currentQuestion
                                                                      .options[
                                                                          index]
                                                                      .option
                                                              ? Colors.white
                                                              : AppColor
                                                                  .primaryColor),
                                                      onChanged: (value) =>
                                                          surveyTakeProvider
                                                              .changeOtherRadioAnswer(
                                                                  value),
                                                      onTap: () =>
                                                          surveyTakeProvider
                                                              .selectRadio(
                                                                  currentQuestion
                                                                          .options[
                                                                      index]),
                                                      decoration:
                                                          InputDecoration(
                                                        hintStyle: AppTextStyle.body2.copyWith(
                                                            color: surveyTakeProvider
                                                                        .radioAnswer ==
                                                                    currentQuestion
                                                                        .options[
                                                                            index]
                                                                        .option
                                                                ? Colors.white
                                                                : AppColor
                                                                    .primaryColor),
                                                        hintText:
                                                            currentQuestion
                                                                .options[index]
                                                                .option,
                                                        contentPadding:
                                                            EdgeInsets.zero,
                                                        border:
                                                            InputBorder.none,
                                                      ),
                                                    )
                                                  : Text(
                                                      currentQuestion
                                                          .options[index]
                                                          .option,
                                                      style: AppTextStyle.body2.copyWith(
                                                          color: currentQuestion
                                                                      .options[
                                                                          index]
                                                                      .option ==
                                                                  surveyTakeProvider
                                                                      .radioAnswer
                                                              ? Colors.white
                                                              : AppColor
                                                                  .primaryColor),
                                                    ),
                                            ),
                                          ),
                                        ),
                                    separatorBuilder: (_, __) => const SizedBox(
                                          height: 12,
                                        ),
                                    itemCount: currentQuestion.options.length);
                              } else if (currentQuestionType ==
                                  QuestionType.TIME) {
                                return Column(
                                  children: [
                                    if (surveyTakeProvider.timeAnswer != null)
                                      Column(
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                "Waktu terpilih",
                                                style: AppTextStyle.body2
                                                    .setBold(),
                                              ),
                                              const Spacer(),
                                              Text(
                                                  surveyTakeProvider
                                                          .timeAnswer ??
                                                      "",
                                                  style: AppTextStyle.body2
                                                      .setRegular()),
                                            ],
                                          ),
                                          const Divider(),
                                          const SizedBox(height: 20),
                                        ],
                                      ),
                                    QCEntryButton(
                                        color: AppColor.secondaryColor,
                                        title: "Pilih Waktu",
                                        onTap: () {
                                          showTimePicker(
                                            context: context,
                                            initialTime: TimeOfDay.now(),
                                          ).then((value) {
                                            if (value != null) {
                                              surveyTakeProvider
                                                  .changeTime(value);
                                            }
                                          });
                                        }),
                                  ],
                                );
                              } else {
                                return const SizedBox();
                              }
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  QCEntryButton(
                    isLoading: surveyTakeProvider.isSubmitLoading,
                    title: "Selanjutnya",
                    onTap: () {
                      surveyTakeProvider
                          .continueQuestion(context)
                          .then((value) {
                        if (value != null) {
                          if (value == "complete") {
                            Navigator.of(context).pushReplacementNamed(
                                CompletePage.route,
                                arguments: "survey");
                          } else {
                            showQCEntrySnackBar(context: context, title: value);
                          }
                        } else {
                          textEditingController.clear();
                        }
                      });
                    },
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
