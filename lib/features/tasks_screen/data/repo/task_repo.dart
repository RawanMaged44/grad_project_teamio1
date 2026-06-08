import 'package:dartz/dartz.dart';
import '../model/task_model.dart';

abstract class TaskRepo {
  Future<Either<String, List<Tasks>>> getMyTasks({int? status});
  Future<Either<String, bool>> createTask(CreateTaskRequest request);
  Future<Either<String, bool>> deleteTask(String taskId);
}
