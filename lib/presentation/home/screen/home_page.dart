import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qc_entry/core/theme/app_color.dart';
import 'package:qc_entry/presentation/home/provider/home_provider.dart';
import 'package:qc_entry/presentation/main/screen/main_page.dart';
import 'package:qc_entry/presentation/profile/screen/profile_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static const route = '/home';
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => HomeProvider(),
        ),
      ],
      child: const HomeView(),
    );
  }
}

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    const pageList = [
      MainPage(),
      ProfilePage(),
    ];
    final homeProvider = Provider.of<HomeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Entry RC"),
      ),
      body: pageList[homeProvider.currentPage],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: AppColor.primaryColor,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home_rounded,
            ),
            label: "Beranda",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person_rounded,
            ),
            label: "Profil",
          ),
        ],
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey.shade600,
        currentIndex: homeProvider.currentPage,
        onTap: (selectedPage) => homeProvider.setCurrentPage(selectedPage),
      ),
    );
  }
}
