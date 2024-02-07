import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qc_entry/core/injector/injector.dart';
import 'package:qc_entry/core/routes/routes.dart';
import 'package:qc_entry/core/theme/app_color.dart';
import 'package:qc_entry/presentation/auth/login/screen/login_page.dart';
import 'package:qc_entry/presentation/auth/provider/auth_provider.dart';
import 'package:qc_entry/presentation/home/screen/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (context) => getIt<AuthProvider>()..checkSignInStatus())
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Entry QC',
      routes: route,
      initialRoute: '/',
      theme: ThemeData(
        fontFamily: 'Poppins',
        primaryColor: AppColor.primaryColor,
        appBarTheme: const AppBarTheme(
          foregroundColor: Colors.white,
          backgroundColor: AppColor.primaryColor,
          centerTitle: true,
        ),
        useMaterial3: true,
      ),
      home: authProvider.isSignedIn ? const HomePage() : const LoginPage(),
    );
  }
}
