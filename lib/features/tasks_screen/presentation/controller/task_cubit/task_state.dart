part of 'task_cubit.dart';

@immutable
sealed class TaskState {}

final class TaskInitial extends TaskState {}

class TaskLoading extends TaskState {}

class TaskSuccess extends TaskState {
  final List<Tasks> tasks;
  TaskSuccess(this.tasks);
}

class TaskError extends TaskState {
  final String message;
  TaskError(this.message);
}

class TaskDeleteLoading extends TaskState {}

class TaskDeleteSuccess extends TaskState {}

class TaskDeleteError extends TaskState {
  final String message;
  TaskDeleteError(this.message);
}
