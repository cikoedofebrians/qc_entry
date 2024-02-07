import 'package:flutter/material.dart';
import 'package:qc_entry/core/extension/text_extension.dart';
import 'package:qc_entry/core/theme/app_color.dart';
import 'package:qc_entry/core/theme/app_text.dart';

class EnumeratorNotes extends StatelessWidget {
  const EnumeratorNotes({super.key, required this.onChange});

  final Function(String) onChange;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Catatan Enumerator",
          style: AppTextStyle.heading5
              .setSemiBold()
              .copyWith(color: AppColor.secondaryColor),
        ),
        const SizedBox(height: 20),
        TextField(
          onChanged: onChange,
          maxLines: null,
          decoration: InputDecoration(
            hintText: 'Tuliskan catatan anda disini...',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ],
    );
  }
}
