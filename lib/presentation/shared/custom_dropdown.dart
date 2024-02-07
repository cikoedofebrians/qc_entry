import 'package:flutter/material.dart';
import 'package:qc_entry/core/extension/text_extension.dart';
import 'package:qc_entry/core/theme/app_color.dart';
import 'package:qc_entry/core/theme/app_text.dart';

class QCEntryDropdown extends StatelessWidget {
  const QCEntryDropdown({
    super.key,
    required this.textEditingController,
    required this.items,
    required this.label,
    required this.onSelected,
  });
  final TextEditingController textEditingController;
  final List<DropdownMenuEntry> items;
  final String label;
  final Function(dynamic) onSelected;
  @override
  Widget build(BuildContext context) {
    return DropdownMenu(
      controller: textEditingController,
      onSelected: onSelected,
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              10,
            ),
            borderSide:
                const BorderSide(color: AppColor.primaryColor, width: 2)),
      ),
      width: MediaQuery.sizeOf(context).width - 48,
      label: Text(
        label,
        style: AppTextStyle.body3
            .setSemiBold()
            .copyWith(color: AppColor.primaryColor),
      ),
      dropdownMenuEntries: items,
    );
  }
}
