import 'package:qc_entry/presentation/auth/login/screen/login_page.dart';
import 'package:qc_entry/presentation/home/screen/home_page.dart';
import 'package:qc_entry/presentation/real_count/partai/screen/partai_page.dart';
import 'package:qc_entry/presentation/real_count/pilleg/screen/pilleg_page.dart';
import 'package:qc_entry/presentation/real_count/pilpres/screen/pilpres_page.dart';
import 'package:qc_entry/presentation/real_count/real_count_list/screen/real_count_list.dart';
import 'package:qc_entry/presentation/survey/complete/screen/complete_page.dart';
import 'package:qc_entry/presentation/survey/list/screen/survey_list_page.dart';
import 'package:qc_entry/presentation/survey/surveyor_data/screen/respondent_data_page.dart';
import 'package:qc_entry/presentation/survey/take/screen/survey_take_page.dart';
import 'package:qc_entry/presentation/survey/warning/screen/warning_page.dart';

final route = {
  LoginPage.route: (context) => const LoginPage(),
  HomePage.route: (context) => const HomePage(),
  WarningPage.route: (context) => const WarningPage(),
  CompletePage.route: (context) => const CompletePage(),
  SurveyListPage.route: (context) => const SurveyListPage(),
  SurveyTakePage.route: (context) => const SurveyTakePage(),
  RealCountListPage.route: (context) => const RealCountListPage(),
  PilpresPage.route: (context) => const PilpresPage(),
  PartaiPage.route: (context) => const PartaiPage(),
  PillegPage.route: (context) => const PillegPage(),
  RespondentDataPage.route: (context) => const RespondentDataPage(),
};
