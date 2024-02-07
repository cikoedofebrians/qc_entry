import 'package:flutter/material.dart';
import 'package:qc_entry/core/extension/text_extension.dart';
import 'package:qc_entry/core/theme/app_color.dart';
import 'package:qc_entry/core/theme/app_text.dart';
import 'package:qc_entry/presentation/main/component/main_option.dart';
import 'package:qc_entry/presentation/real_count/real_count_list/screen/real_count_list.dart';
import 'package:qc_entry/presentation/survey/list/screen/survey_list_page.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    final phoneSize = MediaQuery.sizeOf(context);
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            "assets/images/entryrc-logo.png",
            height: phoneSize.width * 0.5,
            width: phoneSize.width * 0.5,
          ),
          Text(
            "Selamat Datang di Entry RC!",
            textAlign: TextAlign.center,
            style: AppTextStyle.heading2
                .setSemiBold()
                .copyWith(color: AppColor.primaryColor),
          ),
          const Spacer(),
          const MainOption(
            route: SurveyListPage.route,
            title: "Survey",
            subtitle: "Pemilu 2024.",
          ),
          const SizedBox(height: 24),
          const MainOption(
              route: RealCountListPage.route,
              title: "Real Count",
              subtitle: "Hitung asli Pemilu 2024."),
          const Spacer(),
        ],
      ),
    );
  }
}
