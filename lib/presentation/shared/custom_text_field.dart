import 'package:flutter/material.dart';
import 'package:qc_entry/core/extension/text_extension.dart';
import 'package:qc_entry/core/theme/app_color.dart';
import 'package:qc_entry/core/theme/app_text.dart';

class QCEntryTextField extends StatelessWidget {
  const QCEntryTextField({
    super.key,
    this.obsecureText = false,
    required this.onChange,
    this.onTapPrefix,
    this.suffixIcon,
    this.onTapSuffix,
    this.prefixIcon,
    this.hintText,
    this.labelText,
  });
  final String? labelText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final Function()? onTapPrefix;
  final Function()? onTapSuffix;
  final bool obsecureText;
  final Function(String) onChange;
  final String? hintText;
  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChange,
      style: AppTextStyle.body3.setRegular(),
      obscureText: obsecureText,
      decoration: InputDecoration(
        label: labelText != null ? Text(labelText!) : null,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        prefixIcon: prefixIcon != null
            ? InkWell(
                borderRadius: BorderRadius.circular(80),
                onTap: onTapPrefix,
                child: prefixIcon,
              )
            : null,
        suffixIcon: suffixIcon != null
            ? InkWell(
                borderRadius: BorderRadius.circular(80),
                onTap: onTapSuffix,
                child: suffixIcon,
              )
            : null,
        hintText: hintText,
        hintStyle: AppTextStyle.body3.setRegular(),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColor.primaryColor, width: 2),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColor.primaryColor, width: 2),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
