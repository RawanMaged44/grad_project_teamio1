import 'package:dartz/dartz.dart';

abstract class LoginRepo {
  Future<Either<String, Map<String, dynamic>>> login({
    required String nationalId,
    required String password,
  });

  Future<Either<String, Map<String, dynamic>>> refreshToken({
    required String refreshToken,
  });
}