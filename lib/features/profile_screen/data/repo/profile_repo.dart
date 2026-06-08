import 'package:dartz/dartz.dart';
import '../model/profile_model.dart';

abstract class ProfileRepo {
  Future<Either<String, Data>> getMyProfile();
}
