import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:graduation_project/core/api/api_constants.dart';
import 'package:graduation_project/core/api/end_points.dart';
import 'package:graduation_project/core/functions/storage_helper.dart';
import '../model/task_model.dart';
import 'task_repo.dart';

class TaskRepoImpl implements TaskRepo {
  final Dio dio;

  TaskRepoImpl(this.dio);

  /// personal-tasks lives under /api not /api/V1 — build full URL manually
  String _url(String path) => '${ApiConstants.baseUrlV2}$path';

  Future<Options> _authOptions() async {
    final token = await StorageHelper.getAccessToken();
    return Options(headers: {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    });
  }

  @override
  Future<Either<String, List<Tasks>>> getMyTasks({int? status}) async {
    try {
      final opts = await _authOptions();
      final response = await dio.get(
        _url(EndPoints.myTasks),
        queryParameters: status != null ? {'status': status} : null,
        options: opts,
      );
      if (response.statusCode == 404) return const Right([]);
      final raw = response.data;
      List<Tasks> tasks = [];
      if (raw['data'] is List) {
        tasks = (raw['data'] as List).map((v) => Tasks.fromJson(v)).toList();
      }
      return Right(tasks);
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) return const Right([]);
      return Left(_extractError(e));
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, bool>> createTask(CreateTaskRequest request) async {
    try {
      final opts = await _authOptions();
      final response = await dio.post(
        _url(EndPoints.createTask),
        data: request.toJson(),
        options: opts,
      );
      if (response.statusCode != null &&
          response.statusCode! >= 200 &&
          response.statusCode! < 300) {
        return const Right(true);
      }
      return Left('Server returned status ${response.statusCode}');
    } on DioException catch (e) {
      return Left(_extractError(e));
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, bool>> updateTask(String taskId, CreateTaskRequest request) async {
    try {
      final opts = await _authOptions();
      final response = await dio.put(
        _url(EndPoints.updateTask(taskId)),
        data: request.toJson(),
        options: opts,
      );
      if (response.statusCode != null &&
          response.statusCode! >= 200 &&
          response.statusCode! < 300) {
        return const Right(true);
      }
      return Left('Server returned status ${response.statusCode}');
    } on DioException catch (e) {
      return Left(_extractError(e));
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, bool>> completeTask(String taskId) async {
    try {
      final opts = await _authOptions();
      final response = await dio.put(
        _url(EndPoints.completeTask(taskId)),
        options: opts,
      );
      if (response.statusCode != null &&
          response.statusCode! >= 200 &&
          response.statusCode! < 300) {
        return const Right(true);
      }
      return Left('Server returned status ${response.statusCode}');
    } on DioException catch (e) {
      return Left(_extractError(e));
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, bool>> deleteTask(String taskId) async {
    try {
      final opts = await _authOptions();
      final response = await dio.delete(
        _url(EndPoints.deleteTask(taskId)),
        options: opts,
      );
      if (response.statusCode != null &&
          response.statusCode! >= 200 &&
          response.statusCode! < 300) {
        return const Right(true);
      }
      return Left('Failed to delete task');
    } on DioException catch (e) {
      return Left(_extractError(e));
    } catch (e) {
      return Left(e.toString());
    }
  }

  String _extractError(DioException e) {
    final data = e.response?.data;
    if (data is Map) {
      final errors = data['errors'];
      if (errors is List && errors.isNotEmpty) return errors.first.toString();
      if (errors is Map && errors.isNotEmpty) {
        return errors.values.first.toString();
      }
      final msg = data['message'];
      if (msg != null) return msg.toString();
      final title = data['title'];
      if (title != null) return title.toString();
    }
    return e.message ?? e.toString();
  }
}
