import 'package:flutter/material.dart';
import 'package:qc_entry/core/extension/text_extension.dart';
import 'package:qc_entry/core/theme/app_color.dart';
import 'package:qc_entry/core/theme/app_text.dart';

class QCEntryButton extends StatelessWidget {
  const QCEntryButton({
    super.key,
    required this.title,
    required this.onTap,
    this.isLoading = false,
    this.color,
    this.textColor,
  });

  final Function() onTap;
  final String title;
  final bool isLoading;
  final Color? color;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(10),
      color: color ?? AppColor.primaryColor,
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          width: double.infinity,
          child: isLoading
              ? SizedBox(
                  height: 27,
                  width: 27,
                  child: CircularProgressIndicator(
                    valueColor:
                        AlwaysStoppedAnimation(textColor ?? Colors.white),
                  ),
                )
              : Text(
                  title,
                  textAlign: TextAlign.center,
                  style: AppTextStyle.body2.setSemiBold().copyWith(
                        color: textColor ?? Colors.white,
                      ),
                ),
        ),
      ),
    );
  }
}
