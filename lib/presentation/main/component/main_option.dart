import 'package:flutter/material.dart';
import 'package:qc_entry/core/extension/text_extension.dart';
import 'package:qc_entry/core/theme/app_color.dart';
import 'package:qc_entry/core/theme/app_text.dart';

class MainOption extends StatelessWidget {
  const MainOption({
    super.key,
    required this.route,
    required this.title,
    required this.subtitle,
  });

  final String title;
  final String subtitle;
  final String route;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: () => Navigator.of(context).pushNamed(route),
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyle.heading5
                      .setSemiBold()
                      .copyWith(color: AppColor.primaryColor),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: AppTextStyle.body3
                      .setRegular()
                      .copyWith(color: AppColor.secondaryColor),
                ),
              ],
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
