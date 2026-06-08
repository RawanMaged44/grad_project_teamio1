import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../../data/model/task_model.dart';
import '../../../data/repo/task_repo.dart';

part 'task_state.dart';

class TaskCubit extends Cubit<TaskState> {
  final TaskRepo taskRepo;

  TaskCubit(this.taskRepo) : super(TaskInitial());

  List<Tasks> myTasks = [];
  String? lastError;

  Future<void> getMyTasks({int? status}) async {
    emit(TaskLoading());
    final result = await taskRepo.getMyTasks(status: status);
    result.fold(
      (error) => emit(TaskError(error)),
      (data) {
        myTasks = data;
        emit(TaskSuccess(data));
      },
    );
  }

  Future<bool> createTask({
    required String title,
    required String description,
    required String deadline,
    String? teamId, // kept for backward compat but not used
  }) async {
    final request = CreateTaskRequest(
      title: title,
      description: description,
      deadline: deadline,
    );
    final result = await taskRepo.createTask(request);
    bool success = false;
    result.fold(
      (error) {
        lastError = error;
        success = false;
      },
      (_) {
        success = true;
      },
    );
    if (success) await getMyTasks();
    return success;
  }

  Future<void> deleteTask(String taskId) async {
    emit(TaskDeleteLoading());
    final result = await taskRepo.deleteTask(taskId);
    result.fold(
      (error) => emit(TaskDeleteError(error)),
      (_) async {
        myTasks.removeWhere((t) => t.id == taskId);
        emit(TaskDeleteSuccess());
        emit(TaskSuccess(List.from(myTasks)));
      },
    );
  }
}
