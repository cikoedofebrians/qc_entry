import 'package:flutter/material.dart';
import 'package:qc_entry/core/extension/text_extension.dart';
import 'package:qc_entry/core/theme/app_color.dart';
import 'package:qc_entry/core/theme/app_text.dart';

void showQCEntrySnackBar(
    {required BuildContext context, required String title, Color? color}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      duration: const Duration(seconds: 1),
      backgroundColor: color ?? AppColor.tertiaryColor,
      content: Text(
        title,
        style: AppTextStyle.body3.setSemiBold().copyWith(color: Colors.white),
      ),
    ),
  );
}
