import 'package:flutter/material.dart';
import 'package:qc_entry/core/extension/text_extension.dart';
import 'package:qc_entry/core/theme/app_color.dart';
import 'package:qc_entry/core/theme/app_text.dart';

class ProfileItem extends StatelessWidget {
  const ProfileItem({
    super.key,
    required this.left,
    required this.right,
  });

  final String left;
  final String right;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              left,
              style: AppTextStyle.body2.setBold(),
            ),
            const Spacer(),
            Text(
              right,
              style: AppTextStyle.body2.setRegular(),
            ),
          ],
        ),
        const SizedBox(
          height: 4,
        ),
        const Divider(
          height: 1,
          color: AppColor.quaternaryColor,
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
