import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../../core/api/end_points.dart';
import 'login_repo.dart';

class LoginRepoImpl implements LoginRepo {
  final Dio dio;
  LoginRepoImpl(this.dio);

  @override
  Future<Either<String, Map<String, dynamic>>> login({
    required String nationalId,
    required String password,
  }) async {
    try {
      final response = await dio.post(
        EndPoints.login,
        data: {'nationalId': nationalId, 'password': password},
      );
      if (response.statusCode == 200) {
        return Right(response.data);
      } else {
        return Left('Login failed (status code: ${response.statusCode})');
      }
    } on DioException catch (e) {
      return Left('Login failed: ${e.message}');
    } catch (e) {
      return Left('Unexpected error: $e');
    }
  }

  @override
  Future<Either<String, Map<String, dynamic>>> refreshToken({
    required String refreshToken,
  }) async {
    try {
      final response = await dio.post(
        EndPoints.refreshToken,
        data: {'refreshToken': refreshToken},
      );
      if (response.statusCode == 200) {
        return Right(response.data);
      } else {
        return Left('Refresh token failed (status code: ${response.statusCode})');
      }
    } on DioException catch (e) {
      return Left('Refresh token failed: ${e.message}');
    } catch (e) {
      return Left('Unexpected error: $e');
    }
  }
}