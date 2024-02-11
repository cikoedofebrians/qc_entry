import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:qc_entry/core/errors/error_handler.dart';
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
      create: (context) => getIt<SurveyListProvider>()
        ..fetchSurveyList(context)
            .then((value) => errorHandler(value, context, false)),
      child: const SurveyListView(),
    );
  }
}

class SurveyListView extends StatelessWidget {
  const SurveyListView({super.key});

  @override
  Widget build(BuildContext context) {
    final surveyListProvider = Provider.of<SurveyListProvider>(context);
    final phoneWidth = MediaQuery.sizeOf(context).width;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Daftar Survey"),
      ),
      body: surveyListProvider.isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : surveyListProvider.surveyList.isEmpty
              ? Container(
                  width: phoneWidth,
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        "assets/images/empty-box.svg",
                        height: phoneWidth * 0.5,
                        width: phoneWidth * 0.5,
                        fit: BoxFit.scaleDown,
                        colorFilter: const ColorFilter.mode(
                            AppColor.primaryColor, BlendMode.srcIn),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        "Tidak ada survey yang tersedia untuk sekarang",
                        textAlign: TextAlign.center,
                        style: AppTextStyle.heading5
                            .setSemiBold()
                            .copyWith(color: AppColor.primaryColor),
                      ),
                    ],
                  ),
                )
              : ListView.separated(
                  padding: const EdgeInsets.all(24),
                  itemBuilder: (_, index) => SurveyListItem(
                    deskripsi: surveyListProvider.surveyList[index].deskripsi,
                    title: surveyListProvider.surveyList[index].judul,
                    id: surveyListProvider.surveyList[index].id,
                  ),
                  separatorBuilder: (_, __) => const SizedBox(
                    height: 12,
                  ),
                  itemCount: surveyListProvider.surveyList.length,
                ),
    );
  }
}
