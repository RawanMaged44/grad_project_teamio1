import 'dart:io';
import 'package:dartz/dartz.dart';

abstract class UpdateProfileRepo {
  Future<Either<String, String>> updateStudentProfile({
    required String desiredRole,
    required String email,
    required String phoneNumber,
    File? avatar,
    String? currentAvatarUrl,
  });
}
