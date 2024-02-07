import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qc_entry/core/extension/text_extension.dart';
import 'package:qc_entry/core/injector/injector.dart';
import 'package:qc_entry/core/theme/app_color.dart';
import 'package:qc_entry/core/theme/app_text.dart';
import 'package:qc_entry/presentation/survey/list/component/survey_list_item.dart';
import 'package:qc_entry/presentation/survey/list/provider/survey_list_provider.dart';

class SurveyListPage extends StatelessWidget {
  const SurveyListPage({super.key});
  static const route = "/survey/list";
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) =>
          getIt<SurveyListProvider>()..fetchSurveyList(context),
      child: const SurveyListView(),
    );
  }
}

class SurveyListView extends StatelessWidget {
  const SurveyListView({super.key});

  @override
  Widget build(BuildContext context) {
    final surveyListProvider = Provider.of<SurveyListProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Daftar Survey"),
      ),
      body: surveyListProvider.isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : surveyListProvider.surveyList.isEmpty
              ? Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Text(
                      "Tidak ada survey yang tersedia untuk sekarang",
                      textAlign: TextAlign.center,
                      style: AppTextStyle.heading5
                          .setSemiBold()
                          .copyWith(color: AppColor.primaryColor),
                    ),
                  ),
                )
              : ListView.separated(
                  padding: const EdgeInsets.all(24),
                  itemBuilder: (_, index) => SurveyListItem(
                        deskripsi:
                            surveyListProvider.surveyList[index].deskripsi,
                        title: surveyListProvider.surveyList[index].judul,
                        id: surveyListProvider.surveyList[index].id,
                      ),
                  separatorBuilder: (_, __) => const SizedBox(
                        height: 12,
                      ),
                  itemCount: surveyListProvider.surveyList.length),
    );
  }
}
