import 'package:flutter/material.dart';
import 'package:qc_entry/core/extension/text_extension.dart';
import 'package:qc_entry/core/theme/app_color.dart';
import 'package:qc_entry/core/theme/app_text.dart';
import 'package:qc_entry/presentation/real_count/partai/screen/partai_page.dart';
import 'package:qc_entry/presentation/real_count/pilkada/screen/pilkada_page.dart';
import 'package:qc_entry/presentation/real_count/pilleg/screen/pilleg_page.dart';
import 'package:qc_entry/presentation/real_count/pilpres/screen/pilpres_page.dart';

class RealCountListPage extends StatelessWidget {
  const RealCountListPage({super.key});

  static const route = '/real-count';
  @override
  Widget build(BuildContext context) {
    return const RealCountListView();
  }
}

class RealCountListView extends StatelessWidget {
  const RealCountListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Real Count"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Text(
              "Real Count Pemilu 2024",
              textAlign: TextAlign.center,
              style: AppTextStyle.heading3.setSemiBold().copyWith(
                    color: AppColor.primaryColor,
                  ),
            ),
            const Spacer(),
            const _RealCountListItem(
              route: PilkadaPage.route,
              title: "Pemilihan Kepala Daerah",
              shorten: "PILKADA",
            ),
            const SizedBox(height: 12),
            const _RealCountListItem(
              route: PilpresPage.route,
              title: "Pemilihan Presiden",
              shorten: "PILPRES",
              disable: true,
            ),
            const SizedBox(height: 12),
            const _RealCountListItem(
              route: PartaiPage.route,
              title: "Pemilihan Partai",
              shorten: "PARPOL",
              disable: true,
            ),
            const SizedBox(height: 12),
            const _RealCountListItem(
              route: PillegPage.route,
              title: "Pemilihan Legislatif",
              shorten: "PILEG",
              disable: true,
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}

class _RealCountListItem extends StatelessWidget {
  const _RealCountListItem({
    required this.route,
    required this.title,
    required this.shorten,
    this.disable = false,
  });

  final String title;
  final String route;
  final String shorten;
  final bool disable;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: disable ? null : () => Navigator.of(context).pushNamed(route),
      child: Ink(
        // padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          color: disable ? Colors.grey[300] : Colors.white,
          border: Border.all(
              width: 2,
              color: disable ? Colors.grey[600]! : AppColor.primaryColor),
          boxShadow: [
            BoxShadow(blurRadius: 10, color: Colors.black.withOpacity(0.1))
          ],
          borderRadius: BorderRadius.circular(10),
        ),
        width: double.infinity,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      title,
                      style: AppTextStyle.heading5.setSemiBold().copyWith(
                          color: disable
                              ? Colors.grey[600]
                              : AppColor.primaryColor),
                    ),
                  ),
                  Icon(
                    Icons.navigate_next_rounded,
                    size: 28,
                    color: disable ? Colors.grey[600] : AppColor.primaryColor,
                  )
                ],
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                  color: disable ? Colors.grey[600] : AppColor.primaryColor,
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(4),
                      bottomRight: Radius.circular(4))),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              child: Text(
                shorten,
                style: AppTextStyle.body2.setSemiBold().copyWith(
                    color:
                        disable ? Colors.grey[400] : AppColor.quaternaryColor),
              ),
            )
          ],
        ),
      ),
    );
  }
}
