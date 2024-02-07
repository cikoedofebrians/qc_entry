import 'package:flutter/material.dart';
import 'package:qc_entry/core/extension/text_extension.dart';
import 'package:qc_entry/core/theme/app_color.dart';
import 'package:qc_entry/core/theme/app_text.dart';

class WarningItem extends StatelessWidget {
  const WarningItem(
      {super.key,
      required this.left,
      required this.title,
      required this.subtitle});

  final String left;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          radius: 16,
          backgroundColor: AppColor.quaternaryColor,
          child: Text(
            left,
            style: AppTextStyle.body3
                .setSemiBold()
                .copyWith(color: AppColor.primaryColor),
          ),
        ),
        const SizedBox(
          width: 12,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: AppTextStyle.body2
                    .setSemiBold()
                    .copyWith(color: AppColor.primaryColor),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: AppTextStyle.body3
                    .setRegular()
                    .copyWith(color: AppColor.primaryColor),
              ),
            ],
          ),
        )
      ],
    );
  }
}
