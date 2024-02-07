import 'package:flutter/material.dart';
import 'package:qc_entry/core/extension/text_extension.dart';
import 'package:qc_entry/core/theme/app_color.dart';
import 'package:qc_entry/core/theme/app_text.dart';
import 'package:qc_entry/presentation/survey/warning/screen/warning_page.dart';

class SurveyListItem extends StatelessWidget {
  const SurveyListItem({
    super.key,
    required this.title,
    required this.id,
    required this.isTaken,
  });

  final String title;
  final int id;
  final bool isTaken;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: () => !isTaken
          ? Navigator.of(context).pushNamed(WarningPage.route, arguments: id)
          : null,
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
        child: Row(children: [
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
          )
        ]),
      ),
    );
  }
}
