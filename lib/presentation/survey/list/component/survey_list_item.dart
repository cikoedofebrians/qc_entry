import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:qc_entry/core/extension/text_extension.dart';
import 'package:qc_entry/core/theme/app_color.dart';
import 'package:qc_entry/core/theme/app_text.dart';
import 'package:qc_entry/presentation/survey/warning/screen/warning_page.dart';

class SurveyListItem extends StatelessWidget {
  const SurveyListItem({
    super.key,
    required this.title,
    required this.id,
    required this.deskripsi,
  });

  final String title;
  final int id;
  final String deskripsi;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: () => Navigator.of(context)
          .pushNamed(WarningPage.route, arguments: SurveyTakeParams(title, id)),
      child: Ink(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(width: 2, color: AppColor.primaryColor),
          boxShadow: [
            BoxShadow(blurRadius: 10, color: Colors.black.withOpacity(0.1))
          ],
          borderRadius: BorderRadius.circular(10),
        ),
        width: double.infinity,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: AppTextStyle.heading5
                        .setSemiBold()
                        .copyWith(color: AppColor.primaryColor),
                  ),
                ),
                const Icon(
                  Icons.navigate_next_rounded,
                  size: 28,
                  color: AppColor.primaryColor,
                ),
              ],
            ),
            Html(
              data: deskripsi,
              style: {
                "b": Style(
                    fontSize: FontSize(14),
                    fontWeight: FontWeight.bold,
                    margin: Margins.zero,
                    padding: HtmlPaddings.zero,
                    color: AppColor.primaryColor),
                "p": Style(
                    fontSize: FontSize(14),
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
          ],
        ),
      ),
    );
  }
}

class SurveyTakeParams {
  final String title;
  final int id;

  SurveyTakeParams(this.title, this.id);
}
