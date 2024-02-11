import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qc_entry/core/errors/error_handler.dart';
import 'package:qc_entry/core/extension/text_extension.dart';
import 'package:qc_entry/core/injector/injector.dart';
import 'package:qc_entry/core/theme/app_color.dart';
import 'package:qc_entry/core/theme/app_text.dart';
import 'package:qc_entry/presentation/auth/provider/auth_provider.dart';
import 'package:qc_entry/presentation/profile/component/profile_item.dart';
import 'package:qc_entry/presentation/profile/provider/profile_provider.dart';
import 'package:qc_entry/presentation/shared/custom_snackbar.dart';
import 'package:qc_entry/presentation/shared/custom_button.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => getIt<ProfileProvider>()
        ..fetchUsers(context)
            .then((value) => errorHandler(value, context, false)),
      child: const ProfileView(),
    );
  }
}

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final profileProvider = Provider.of<ProfileProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            const Icon(
              Icons.account_circle_rounded,
              size: 40,
              color: AppColor.primaryColor,
            ),
            const SizedBox(width: 12),
            Text(
              "Profil",
              style: AppTextStyle.heading2
                  .setSemiBold()
                  .copyWith(color: AppColor.primaryColor),
            ),
          ]),
          const SizedBox(height: 24),
          ProfileItem(left: "Nama", right: profileProvider.user?.name ?? "-"),
          ProfileItem(left: "Email", right: profileProvider.user?.email ?? "-"),
          ProfileItem(
              left: "No Telepon", right: profileProvider.user?.telepon ?? "-"),
          ProfileItem(left: "Peran", right: profileProvider.user?.role ?? "-"),
          const Spacer(),
          QCEntryButton(
            title: "Keluar",
            color: Colors.red,
            onTap: () async {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  backgroundColor: Colors.white,
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Apakah anda yakin untuk keluar?",
                        style: AppTextStyle.heading5
                            .setSemiBold()
                            .copyWith(color: AppColor.primaryColor),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: () async {
                                await authProvider.logout().then((value) {
                                  if (value != null) {
                                    showQCEntrySnackBar(
                                        context: context,
                                        title: "Terjadi kesalahan");
                                  } else {
                                    Navigator.pop(context);
                                  }
                                });
                              },
                              child: Ink(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: AppColor.tertiaryColor, width: 2),
                                  color: AppColor.tertiaryColor,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(
                                  "Ya",
                                  textAlign: TextAlign.center,
                                  style: AppTextStyle.body3
                                      .setSemiBold()
                                      .copyWith(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: InkWell(
                              onTap: () => Navigator.pop(context),
                              child: Ink(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: AppColor.secondaryColor, width: 2),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(
                                  "Tidak",
                                  textAlign: TextAlign.center,
                                  style: AppTextStyle.body3
                                      .setSemiBold()
                                      .copyWith(color: AppColor.secondaryColor),
                                ),
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
