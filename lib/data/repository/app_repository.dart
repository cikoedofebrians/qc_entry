import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:qc_entry/core/errors/exception.dart';
import 'package:qc_entry/core/errors/failure.dart';
import 'package:qc_entry/core/network/dio_client.dart';
import 'package:qc_entry/core/network/endpoints.dart';
import 'package:qc_entry/data/model/app/version/version_model.dart';

class AppRepository {
  final DioClient dioClient;
  AppRepository(this.dioClient);

  Future<Either<Failure, Version>> getAppVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    try {
      final response = await dioClient.post(versionUrl, data: {
        'app_version': packageInfo.version,
      });
      final version = Version.fromJson(response.data);
      return Right(version);
    } on DioException catch (e) {
      final message = e.response?.data['message'];
      return Left(ServerFailure(
          message ?? "Terjadi kesalahan", e.response?.statusCode));
    } on NetworkException catch (_) {
      return const Left(NetworkFailure(
        "Tidak bisa terhubung keinternet",
      ));
    } catch (_) {
      return const Left(ParsingFailure("Terjadi kesalahan"));
    }
  }
}
