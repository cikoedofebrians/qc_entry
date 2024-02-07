import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qc_entry/core/injector/injector.dart';
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
          : ListView.separated(
              padding: const EdgeInsets.all(24),
              itemBuilder: (_, index) => SurveyListItem(
                    title: surveyListProvider.surveyList[index].title,
                    id: surveyListProvider.surveyList[index].id,
                    isTaken: surveyListProvider.surveyList[index].isTaken,
                  ),
              separatorBuilder: (_, __) => const SizedBox(
                    height: 12,
                  ),
              itemCount: surveyListProvider.surveyList.length),
    );
  }
}
