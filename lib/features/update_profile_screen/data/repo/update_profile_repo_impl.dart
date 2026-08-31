import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:graduation_project/core/api/api_constants.dart';
import 'package:graduation_project/core/api/end_points.dart';
import '../model/update_profile_model.dart';
import 'update_profile_repo.dart';

class UpdateProfileRepoImpl implements UpdateProfileRepo {
  final Dio dio;

  UpdateProfileRepoImpl(this.dio);

  @override
  Future<Either<String, String>> updateStudentProfile({
    required String desiredRole,
    required String email,
    required String phoneNumber,
    File? avatar,
    String? currentAvatarUrl,
  }) async {
    try {
      final data = FormData();

      if (desiredRole.isNotEmpty) {
        data.fields.add(MapEntry('DesiredRole', desiredRole));
      }
      if (email.isNotEmpty) {
        data.fields.add(MapEntry('Email', email));
      }
      if (phoneNumber.isNotEmpty) {
        data.fields.add(MapEntry('PhoneNumber', phoneNumber));
      }

      if (avatar != null) {
        // User picked a new image — send it
        data.files.add(MapEntry(
          'Avatar',
          await MultipartFile.fromFile(
            avatar.path,
            filename: avatar.path.split('/').last,
          ),
        ));
      }
      // If no new avatar selected — skip it, backend will keep the existing one

      final response = await dio.put(
        EndPoints.updateStudentProfile,
        data: data,
        options: Options(contentType: 'multipart/form-data'),
      );

      final model = UpdateProfileModel.fromJson(response.data);
      if (model.success == true) {
        return Right(model.message ?? 'Profile updated successfully');
      }

      final errorMsg = model.errors?.toString() ??
          model.message ??
          'Failed to update profile';
      return Left(errorMsg);
    } on DioException catch (e) {
      final responseData = e.response?.data;
      if (responseData is Map) {
        final msg = responseData['message'] ??
            responseData['errors']?.toString() ??
            responseData['title'];
        if (msg != null) return Left(msg.toString());
      }
      return Left(e.message ?? 'Network error');
    } catch (e) {
      return Left(e.toString());
    }
  }
}
