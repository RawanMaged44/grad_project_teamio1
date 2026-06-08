import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/core/const%20Widgets/app_background.dart';
import 'package:graduation_project/features/homeScreen/presentation/controller/home_cubit.dart';
import '../../controller/task_cubit/task_cubit.dart';
import '../widgets/body_widgets.dart';
import '../widgets/task_app_bar.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({super.key});
  static String routeName = "tasks";

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {

  @override
  void initState() {
    super.initState();
    context.read<TaskCubit>().getMyTasks();
    // Ensure teamId is loaded (in case HomeScreen hasn't loaded it yet)
    if (context.read<HomeCubit>().teamId == null) {
      context.read<HomeCubit>().getMyTeam();
    }
  }

  @override
  Widget build(BuildContext context) {
    return const AppBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: TaskAppBar(),
        body: TasksBody(),
      ),
    );
  }
}