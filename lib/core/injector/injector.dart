import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:qc_entry/core/network/dio_client.dart';
import 'package:qc_entry/core/network/network_info.dart';
import 'package:qc_entry/core/service/token_service.dart';
import 'package:qc_entry/data/repository/app_repository.dart';
import 'package:qc_entry/data/repository/auth_repository.dart';
import 'package:qc_entry/data/repository/raelcount_repository.dart';
import 'package:qc_entry/data/repository/survey_repository.dart';
import 'package:qc_entry/presentation/auth/provider/auth_provider.dart';
import 'package:qc_entry/presentation/profile/provider/profile_provider.dart';
import 'package:qc_entry/presentation/real_count/partai/provider/partai_provider.dart';
import 'package:qc_entry/presentation/real_count/pilleg/provider/pilleg_provider.dart';
import 'package:qc_entry/presentation/real_count/pilpres/provider/pilpres_provider.dart';
import 'package:qc_entry/presentation/survey/list/provider/survey_list_provider.dart';
import 'package:qc_entry/presentation/survey/take/provider/survey_take_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.I;

Future<void> configureDependencies() async {
  // NETWORK
  final sp = await SharedPreferences.getInstance();
  getIt.registerFactory(() => TokenService(sp));
  getIt.registerFactory(() => Dio());
  getIt.registerFactory(
      () => DioClient(getIt<Dio>(), getIt<TokenService>())..init());
  getIt.registerFactory(() => InternetConnectionChecker());
  getIt.registerFactory(() =>
      NetworkInfoImpl(connectionChecker: getIt<InternetConnectionChecker>()));

  // AUTH
  getIt.registerFactory(() => AuthRepository(
      dio: getIt<DioClient>(), tokenService: getIt<TokenService>()));
  getIt.registerFactory(
      () => AuthProvider(getIt<AuthRepository>(), getIt<TokenService>()));
  getIt.registerFactory(() => ProfileProvider(getIt<AuthRepository>()));
  getIt.registerFactory(() => SurveyRepository(getIt<DioClient>()));
  getIt.registerFactory(() => SurveyListProvider(getIt<SurveyRepository>()));

  getIt.registerFactory(() => SurveyTakeProvider(getIt<SurveyRepository>()));

  //APP
  getIt.registerFactory(() => AppRepository(getIt<DioClient>()));

  // REALCOUNT
  getIt.registerFactory(() => RealcountRepository(getIt<DioClient>()));
  getIt.registerFactory(() => PilpresProvider(getIt<RealcountRepository>()));
  getIt.registerFactory(() => PartaiProvider(getIt<RealcountRepository>()));
  getIt.registerFactory(() => PillegProvider(getIt<RealcountRepository>()));
}
