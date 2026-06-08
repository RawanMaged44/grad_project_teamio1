import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:graduation_project/features/homeScreen/data/model/team_model.dart';
import '../../../../core/api/end_points.dart';
import 'home_rebo.dart';
import 'package:flutter/material.dart';
class HomeRepoImpl implements HomeRepo {
  final Dio dio;

  HomeRepoImpl({required this.dio});

  @override
  Future<Either<String, TeamModel>> getMyTeam() async {
    try {
      final response = await dio.get(EndPoints.myTeam);
      if (response.statusCode == 200) {
        return Right(TeamModel.fromJson(response.data));
      } else {
        return Left('Failed to load team data (status code: ${response.statusCode})');
      }
    } on DioException catch (e) {
      return Left('Failed to load team data: ${e.message}');
    } catch (e) {
      return Left('Unexpected error: $e');
    }
  }
}