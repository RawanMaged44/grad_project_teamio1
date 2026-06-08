import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/core/utils/app_texts.dart';
import '../../controller/task_cubit/task_cubit.dart';
import 'task_card.dart';

class TasksBody extends StatelessWidget {
  const TasksBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskCubit, TaskState>(
      builder: (context, state) {

        if (state is TaskInitial || state is TaskLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is TaskError) {
          // 404 = no tasks yet, show empty state instead of error
          if (state.message.contains('404')) {
            return const Center(
              child: Text(AppTexts.noTasksYet,
                  style: TextStyle(color: Colors.white54)),
            );
          }
          return Center(
            child: Text(
              state.message,
              style: const TextStyle(color: Colors.red),
            ),
          );
        }

        if (state is TaskSuccess) {
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: state.tasks.length,
            itemBuilder: (context, index) {
              return TaskCard(task: state.tasks[index]);
            },
          );
        }

        return const SizedBox();
      },
    );
  }
}