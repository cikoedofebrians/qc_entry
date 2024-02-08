import 'package:flutter/material.dart';
import 'package:qc_entry/core/extension/text_extension.dart';
import 'package:qc_entry/core/theme/app_color.dart';
import 'package:qc_entry/core/theme/app_text.dart';

class VoiceTextField extends StatelessWidget {
  const VoiceTextField({
    super.key,
    required this.label,
    this.onChange,
    this.onChangeNormal,
    this.index,
    this.leading,
  });

  final String label;
  final int? index;
  final Function(int, String)? onChange;
  final Function(String)? onChangeNormal;
  final Widget? leading;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (leading != null) leading!,
        Expanded(
          child: Text(
            label,
            style: AppTextStyle.body2
                .setSemiBold()
                .copyWith(color: AppColor.primaryColor),
          ),
        ),
        const SizedBox(width: 12),
        SizedBox(
          width: 42,
          child: TextField(
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
                isDense: true, contentPadding: EdgeInsets.only(bottom: 4)),
            onChanged: (newValue) {
              if (onChangeNormal != null) {
                onChangeNormal!(newValue);
                return;
              }
              if (onChange != null && index != null) {
                onChange!(index!, newValue);
              }
            },
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
