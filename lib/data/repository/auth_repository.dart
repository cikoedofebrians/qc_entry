import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:qc_entry/core/errors/exception.dart';
import 'package:qc_entry/core/errors/failure.dart';
import 'package:qc_entry/core/network/dio_client.dart';
import 'package:qc_entry/core/network/endpoints.dart';
import 'package:qc_entry/core/service/token_service.dart';
import 'package:qc_entry/data/model/auth/user/user_model.dart';

class AuthRepository {
  final DioClient dio;
  final TokenService tokenService;

  AuthRepository({required this.dio, required this.tokenService});
  Future<Either<Failure, void>> login(String email, String password) async {
    try {
      final response = await dio.post(loginUrl, data: {
        'email': email,
        'password': password,
      });
      tokenService.saveToken(response.data['data']['original']['access_token']);
      return const Right(null);
    } on DioException catch (e) {
      final message = e.response?.data['message'];
      return Left(ServerFailure(message ?? "Terjadi kesalahan"));
    } on NetworkException catch (_) {
      return const Left(NetworkFailure("Tidak bisa terhubung keinternet"));
    } catch (_) {
      return const Left(ParsingFailure("Terjadi kesalahan"));
    }
  }

  Future<Either<Failure, User>> getMe() async {
    try {
      final response = await dio.post(meUrl);
      final User user = User.fromJson(response.data['data']);
      return Right(user);
    } on DioException catch (e) {
      final message = e.response?.data['message'];
      return Left(ServerFailure(message ?? "Terjadi kesalahan"));
    } on NetworkException catch (_) {
      return const Left(NetworkFailure("Tidak bisa terhubung keinternet"));
    } catch (_) {
      return const Left(ParsingFailure("Terjadi kesalahan"));
    }
  }

  Future<Either<Failure, void>> logout() async {
    try {
      await dio.post(logoutUrl);
      return const Right(null);
    } on DioException catch (e) {
      final message = e.response?.data['message'];
      return Left(ServerFailure(message ?? "Terjadi kesalahan"));
    } on NetworkException catch (_) {
      return const Left(NetworkFailure("Tidak bisa terhubung keinternet"));
    } catch (_) {
      return const Left(ParsingFailure("Terjadi kesalahan"));
    }
  }
}
