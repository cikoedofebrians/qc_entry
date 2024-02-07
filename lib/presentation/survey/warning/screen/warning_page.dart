import 'package:flutter/material.dart';
import 'package:qc_entry/core/extension/text_extension.dart';
import 'package:qc_entry/core/theme/app_color.dart';
import 'package:qc_entry/core/theme/app_text.dart';
import 'package:qc_entry/presentation/shared/custom_button.dart';
import 'package:qc_entry/presentation/survey/take/screen/survey_take_page.dart';
import 'package:qc_entry/presentation/survey/warning/component/warning_item.dart';

class WarningPage extends StatelessWidget {
  const WarningPage({super.key});

  static const route = '/survey/warning';

  @override
  Widget build(BuildContext context) {
    int id = ModalRoute.of(context)!.settings.arguments as int;
    List<InterviewRule> interviewRules = [
      InterviewRule(
        key: "A",
        title: "WAWANCARA KOLEKTIF",
        subtitle:
            "Melakukan wawancara lebih dari 1 responden di tempat dan waktu bersamaan.",
      ),
      InterviewRule(
        key: "B",
        title: "WAWANCARA ATAS NAMA",
        subtitle:
            "Melakukan wawancara bukan kepada responden terpilih, tanpa melalui mekanisme metodologi.",
      ),
      InterviewRule(
        key: "C",
        title: "WAWANCARA KILAT",
        subtitle:
            "Melakukan wawancara dengan tidak baik/ dengan sengaja tidak membacakan pertanyaan yang seharusnya ditanyakan/Asumtif/memanipulasi wawancara.",
      ),
      InterviewRule(
        key: "D",
        title: "WAWANCARA FIKTIF",
        subtitle:
            "Tidak melakukan wawancara/ kuesioner diisi sendiri oleh surveyor tanpa proses wawancara.",
      ),
      InterviewRule(
        key: "E",
        title: "MANIPULATIF DATA RT/KK",
        subtitle:
            "Dengan sengaja memanipulasi/memodifikasi data yang diberikan informasi dengan maksud dan tujuan tertentu.",
      ),
    ];
    return Scaffold(
      appBar: AppBar(
        title: const Text("Peringatan"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              Text(
                "CHEATING/ PELANGGARAN DALAM SURVEY",
                style: AppTextStyle.heading2
                    .setSemiBold()
                    .copyWith(color: AppColor.primaryColor),
              ),
              const SizedBox(height: 24),
              ...List.generate(
                interviewRules.length,
                (index) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: WarningItem(
                      left: interviewRules[index].key,
                      title: interviewRules[index].title,
                      subtitle: interviewRules[index].subtitle),
                ),
              ),
              const SizedBox(height: 24),
              QCEntryButton(
                  title: "Mulai Survey",
                  onTap: () => Navigator.of(context).pushReplacementNamed(
                      SurveyTakePage.route,
                      arguments: id)),
            ],
          ),
        ),
      ),
    );
  }
}

class InterviewRule {
  final String key;
  final String title;
  final String subtitle;

  InterviewRule(
      {required this.key, required this.title, required this.subtitle});
}
