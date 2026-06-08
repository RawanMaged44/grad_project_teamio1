import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/core/utils/app_colors.dart';
import 'package:graduation_project/features/homeScreen/presentation/controller/home_cubit.dart';
import '../../controller/task_cubit/task_cubit.dart';
import 'add_task_sheet_content.dart';

void showAddTaskSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: AppColors.grayColor.withOpacity(0.62),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    builder: (_) => MultiBlocProvider(
      providers: [
        BlocProvider.value(value: context.read<TaskCubit>()),
        BlocProvider.value(value: context.read<HomeCubit>()),
      ],
      child: const AddTaskSheetContent(),
    ),
  );
}
