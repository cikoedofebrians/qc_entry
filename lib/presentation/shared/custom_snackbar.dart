import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qc_entry/core/extension/text_extension.dart';
import 'package:qc_entry/core/theme/app_color.dart';
import 'package:qc_entry/core/theme/app_text.dart';
import 'package:qc_entry/presentation/auth/provider/auth_provider.dart';

void showQCEntrySnackBar({
  required BuildContext context,
  required String title,
  Color? color,
  bool withLogoutButton = false,
  bool automaticPop = false,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      duration: const Duration(seconds: 4),
      backgroundColor: color ?? AppColor.tertiaryColor,
      content: Text(
        title,
        style: AppTextStyle.body3.setSemiBold().copyWith(color: Colors.white),
      ),
      action: withLogoutButton
          ? SnackBarAction(
              label: "LOGOUT",
              onPressed: () {
                Navigator.popUntil(
                  context,
                  (route) => route.isFirst,
                );
                Provider.of<AuthProvider>(context, listen: false).logout();
              },
              textColor: Colors.white,
            )
          : null,
    ),
  );
  if (automaticPop) Navigator.pop(context);
}
