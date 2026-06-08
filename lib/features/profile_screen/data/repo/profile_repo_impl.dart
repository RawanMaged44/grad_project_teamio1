import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:graduation_project/core/api/end_points.dart';
import '../model/profile_model.dart';
import 'profile_repo.dart';

class ProfileRepoImpl implements ProfileRepo {
  final Dio dio;

  ProfileRepoImpl(this.dio);

  @override
  Future<Either<String, Data>> getMyProfile() async {
    try {
      final response = await dio.get(EndPoints.myProfile);
      final model = ProfileModel.fromJson(response.data);
      if (model.success == true && model.data != null) {
        return Right(model.data!);
      }
      return const Left('Failed to load profile');
    } on DioException catch (e) {
      return Left(e.message ?? 'Network error');
    } catch (e) {
      return Left(e.toString());
    }
  }
}
