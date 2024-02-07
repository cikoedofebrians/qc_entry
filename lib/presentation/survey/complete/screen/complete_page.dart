import 'package:flutter/material.dart';
import 'package:qc_entry/core/extension/text_extension.dart';
import 'package:qc_entry/core/theme/app_color.dart';
import 'package:qc_entry/core/theme/app_text.dart';
import 'package:qc_entry/presentation/shared/custom_button.dart';

class CompletePage extends StatelessWidget {
  const CompletePage({super.key});

  static const route = '/survey/complete';
  @override
  Widget build(BuildContext context) {
    final String pageType =
        ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              pageType == "survey" ? "Selamat!" : "Sukses!",
              style: AppTextStyle.heading2
                  .setSemiBold()
                  .copyWith(color: AppColor.primaryColor),
            ),
            const SizedBox(height: 4),
            Text(
              pageType == "survey"
                  ? "Anda telah berhasil menyelesaikan survey ini"
                  : "Data pemilihan berhasil dikirimkan",
              style: AppTextStyle.body3
                  .setRegular()
                  .copyWith(color: AppColor.secondaryColor),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              "Jangan lupa untuk langsung update kegiatan kepada tim monitoring masing - masing.",
              style: AppTextStyle.body3
                  .setRegular()
                  .copyWith(color: AppColor.secondaryColor),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 20,
            ),
            QCEntryButton(
                title: "Kembali ke Beranda",
                onTap: () => Navigator.pop(context)),
          ],
        ),
      ),
    );
  }
}
