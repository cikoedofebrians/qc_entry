import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qc_entry/core/extension/text_extension.dart';
import 'package:qc_entry/core/theme/app_color.dart';
import 'package:qc_entry/core/theme/app_text.dart';
import 'package:qc_entry/presentation/auth/login/provider/login_provider.dart';
import 'package:qc_entry/presentation/auth/provider/auth_provider.dart';
import 'package:qc_entry/presentation/shared/custom_snackbar.dart';
import 'package:qc_entry/presentation/shared/custom_button.dart';
import 'package:qc_entry/presentation/shared/custom_text_field.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});
  static const route = '/auth/login';
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => LoginProvider(),
      child: const LoginView(),
    );
  }
}

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final loginProvider = Provider.of<LoginProvider>(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/images/entryrc-logo.png",
                  width: 320,
                  height: 320,
                ),
                Text(
                  "Masuk",
                  style: AppTextStyle.heading4
                      .setSemiBold()
                      .copyWith(color: AppColor.primaryColor),
                ),
                const SizedBox(height: 30),
                QCEntryTextField(
                  labelText: "Email",
                  onChange: (newValue) => loginProvider.setEmail(newValue),
                ),
                const SizedBox(
                  height: 20,
                ),
                QCEntryTextField(
                  labelText: "Password",
                  obsecureText: true,
                  onChange: (newValue) => loginProvider.setPassword(newValue),
                ),
                const SizedBox(
                  height: 30,
                ),
                QCEntryButton(
                  title: "Masuk",
                  isLoading: loginProvider.isLoading,
                  onTap: () async {
                    loginProvider.setLoading(true);
                    final result = await authProvider.login(
                        loginProvider.email, loginProvider.password);
                    if (!context.mounted) return;
                    if (result != null) {
                      loginProvider.setLoading(false);
                      showQCEntrySnackBar(context: context, title: result);
                    }
                  },
                ),
                const SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
