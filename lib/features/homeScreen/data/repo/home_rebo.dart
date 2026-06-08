import 'package:dartz/dartz.dart';
import 'package:graduation_project/features/homeScreen/data/model/team_model.dart';

abstract class HomeRepo {
  Future<Either<String, TeamModel>> getMyTeam();
}