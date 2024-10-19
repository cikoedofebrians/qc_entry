import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:qc_entry/core/errors/exception.dart';
import 'package:qc_entry/core/errors/failure.dart';
import 'package:qc_entry/core/network/dio_client.dart';
import 'package:qc_entry/core/network/endpoints.dart';
import 'package:qc_entry/data/model/survey/survey/survey_model.dart';
import 'package:qc_entry/data/model/survey/survey_take/survey_take_model.dart';

class SurveyRepository {
  final DioClient _dio;

  SurveyRepository(this._dio);

  Future<Either<Failure, List<Survey>>> getSurveyList() async {
    try {
      final response = await _dio.get(surveyUrl);

      List<Survey> surveyList = [];
      for (var survey in response.data['data']) {
        surveyList.add(Survey.fromJson(survey));
      }

      return Right(surveyList);
    } on DioException catch (e) {
      final message = e.response?.data['message'];
      return Left(ServerFailure(
          message ?? "Terjadi kesalahan", e.response?.statusCode));
    } on NetworkException catch (_) {
      return const Left(NetworkFailure("Tidak bisa terhubung keinternet"));
    } catch (_) {
      return const Left(ParsingFailure("Terjadi kesalahan"));
    }
  }

  Future<Either<Failure, SurveyTake>> getAllQuestion(int id) async {
    try {
      final response = await _dio.get(surveyQuestionUrl(id.toString()));
      final surveyTake = SurveyTake.fromJson(response.data);

      return Right(surveyTake);
    } on DioException catch (e) {
      final message = e.response?.data['message'];
      return Left(ServerFailure(
          message ?? "Terjadi kesalahan", e.response?.statusCode));
    } on NetworkException catch (_) {
      return const Left(NetworkFailure("Tidak bisa terhubung keinternet"));
    } catch (_) {
      return const Left(ParsingFailure("Terjadi kesalahan"));
    }
  }

  Future<Either<Failure, void>> submitAnswer(Map<String, dynamic> data) async {
    try {
      log("SURVEY REQUEST BODY: $data");
      final response = await _dio.post(
        answerSurveyUrl,
        data: data,
      );
      if (response.statusCode != 200) {
        throw Exception();
      }
      return const Right(null);
    } on DioException catch (e) {
      final message = e.response?.data['message'];
      return Left(ServerFailure(
          message ?? "Terjadi kesalahan", e.response?.statusCode));
    } on NetworkException catch (_) {
      return const Left(NetworkFailure("Tidak bisa terhubung keinternet"));
    } catch (_) {
      return const Left(ParsingFailure("Terjadi kesalahan"));
    }
  }

  Future<Either<Failure, void>> finishSurvey(int id) async {
    try {
      final response = await _dio.post(finishSurveyUrl(
        id.toString(),
      ));
      if (response.statusCode != 200) {
        throw Exception();
      }
      return const Right(null);
    } on DioException catch (e) {
      final message = e.response?.data['message'];
      return Left(ServerFailure(
          message ?? "Terjadi kesalahan", e.response?.statusCode));
    } on NetworkException catch (_) {
      return const Left(NetworkFailure("Tidak bisa terhubung keinternet"));
    } catch (_) {
      return const Left(ParsingFailure("Terjadi kesalahan"));
    }
  }
}
