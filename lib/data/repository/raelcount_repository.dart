import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:qc_entry/core/errors/exception.dart';
import 'package:qc_entry/core/errors/failure.dart';
import 'package:qc_entry/core/network/dio_client.dart';
import 'package:qc_entry/core/network/endpoints.dart';
import 'package:qc_entry/data/model/realcount/caleg/caleg_model.dart';
import 'package:qc_entry/data/model/realcount/capres/capres_model.dart';
import 'package:qc_entry/data/model/realcount/dapil/dapil_model.dart';
import 'package:qc_entry/data/model/realcount/partai/partai_model.dart';

class RealcountRepository {
  final DioClient _dio;

  RealcountRepository(this._dio);

  Future<Either<Failure, List<Dapil>>> getAllDapil() async {
    try {
      final response = await _dio.get(dapilUrl);
      List<Dapil> dapilList = [];
      for (var dapil in response.data['data']) {
        dapilList.add(Dapil.fromJson(dapil));
      }
      return Right(dapilList);
    } on DioException catch (e) {
      final message = e.response?.data['message'];
      return Left(ServerFailure(message ?? "Terjadi kesalahan"));
    } on NetworkException catch (_) {
      return const Left(NetworkFailure("Tidak bisa terhubung keinternet"));
    } catch (_) {
      return const Left(ParsingFailure("Terjadi kesalahan"));
    }
  }

  Future<Either<Failure, List<Partai>>> getAllPartai() async {
    try {
      final response = await _dio.get(pilparUrl);
      List<Partai> partaiList = [];
      for (var partai in response.data['data']) {
        partaiList.add(Partai.fromJson(partai));
      }
      return Right(partaiList);
    } on DioException catch (e) {
      final message = e.response?.data['message'];
      return Left(ServerFailure(message ?? "Terjadi kesalahan"));
    } on NetworkException catch (_) {
      return const Left(NetworkFailure("Tidak bisa terhubung keinternet"));
    } catch (_) {
      return const Left(ParsingFailure("Terjadi kesalahan"));
    }
  }

  Future<Either<Failure, List<Caleg>>> getAllCaleg(
      {required int partaiId, required int dapilId}) async {
    try {
      final response = await _dio.get(pillegUrl(partaiId, dapilId));
      List<Caleg> calegList = [];
      for (var caleg in response.data['data']) {
        calegList.add(Caleg.fromJson(caleg));
      }
      return Right(calegList);
    } on DioException catch (e) {
      final message = e.response?.data['message'];
      return Left(ServerFailure(message ?? "Terjadi kesalahan"));
    } on NetworkException catch (_) {
      return const Left(NetworkFailure("Tidak bisa terhubung keinternet"));
    } catch (_) {
      // print(_);
      return const Left(ParsingFailure("Terjadi kesalahan"));
    }
  }

  Future<Either<Failure, List<Capres>>> getAllCapres() async {
    try {
      final response = await _dio.get(pilpresUrl);
      List<Capres> capresList = [];
      for (var capres in response.data['data']) {
        capresList.add(Capres.fromJson(capres));
      }
      return Right(capresList);
    } on DioException catch (e) {
      final message = e.response?.data['message'];
      return Left(ServerFailure(message ?? "Terjadi kesalahan"));
    } on NetworkException catch (_) {
      return const Left(NetworkFailure("Tidak bisa terhubung keinternet"));
    } catch (_) {
      return const Left(ParsingFailure("Terjadi kesalahan"));
    }
  }

  Future<Either<Failure, void>> submitCapres({
    required int dapilId,
    required String kelurahan,
    required String tps,
    required List<Map<String, int>> hasilSuaraSah,
    required int hasilSuaraTidakSah,
    required String notes,
  }) async {
    try {
      await _dio.post(submitPilpresUrl, data: {
        'dapil_id': dapilId,
        'kelurahan': kelurahan,
        'tps': tps,
        'hasil_suara_sah': hasilSuaraSah,
        'hasil_suara_tidak_sah': hasilSuaraTidakSah,
        'laporan': notes,
      });
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

  Future<Either<Failure, void>> submitPilpar({
    required int dapilId,
    required String kelurahan,
    required String tps,
    required List<Map<String, int>> hasilSuaraSah,
    required int hasilSuaraTidakSah,
    required String notes,
  }) async {
    try {
      await _dio.post(submitPilparUrl, data: {
        'dapil_id': dapilId,
        'kelurahan': kelurahan,
        'tps': tps,
        'hasil_suara_sah': hasilSuaraSah,
        'hasil_suara_tidak_sah': hasilSuaraTidakSah,
        'laporan': notes,
      });
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

  Future<Either<Failure, void>> submitPilleg({
    required int dapilId,
    required String kelurahan,
    required String tps,
    required List<Map<String, int>> hasilSuaraSah,
    required int hasilSuaraTidakSah,
    required String notes,
  }) async {
    try {
      await _dio.post(submitPillegUrl, data: {
        'dapil_id': dapilId,
        'kelurahan': kelurahan,
        'tps': tps,
        'hasil_suara_sah': hasilSuaraSah,
        'hasil_suara_tidak_sah': hasilSuaraTidakSah,
        'laporan': notes,
      });
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
