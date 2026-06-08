import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/core/utils/app_colors.dart';
import 'package:graduation_project/core/utils/app_styles.dart';
import 'package:graduation_project/core/utils/app_texts.dart';
import '../../../data/model/task_model.dart';
import '../../controller/task_cubit/task_cubit.dart';
import 'task_card_helpers.dart';

class TaskCard extends StatelessWidget {
  final Tasks task;
  const TaskCard({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(task.id ?? ''),
      direction: DismissDirection.endToStart,
      background: Container(
        margin: EdgeInsets.only(bottom: 16.h),
        decoration: BoxDecoration(
          color: AppColors.redColor,
          borderRadius: BorderRadius.circular(20.r),
        ),
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 24.w),
        child: Icon(Icons.delete, color: AppColors.whiteColor, size: 28.sp),
      ),
      confirmDismiss: (_) async => _showDeleteConfirm(context),
      onDismissed: (_) {
        if (task.id != null) {
          context.read<TaskCubit>().deleteTask(task.id!);
        }
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 16.h),
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        decoration: BoxDecoration(
          color: AppColors.grayColor.withOpacity(0.62),
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(task.title ?? '', style: AppStyles.white21bold),
                ),
                SizedBox(width: 12.w),
                TaskCardHelpers.buildStatusIcon(task.status),
              ],
            ),
            SizedBox(height: 8.h),
            Text(
              task.description ?? '',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: Colors.grey, fontSize: 14.sp, height: 1.4),
            ),
            SizedBox(height: 14.h),
            Row(
              children: [
                Text('📅', style: TextStyle(fontSize: 13.sp)),
                SizedBox(width: 6.w),
                Text(
                  TaskCardHelpers.formatDeadline(task.deadline),
                  style: TextStyle(color: Colors.grey, fontSize: 13.sp),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<bool> _showDeleteConfirm(BuildContext context) async {
    return await showDialog<bool>(
          context: context,
          builder: (ctx) => AlertDialog(
            backgroundColor: const Color(0xFF1A1A2E),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.r)),
            title: Text(AppTexts.deleteTask,
                style: TextStyle(color: Colors.white, fontSize: 16.sp)),
            content: Text(AppTexts.deleteTaskConfirm,
                style: TextStyle(color: Colors.grey, fontSize: 14.sp)),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(ctx, false),
                child: Text(AppTexts.cancel,
                    style: TextStyle(color: Colors.white70, fontSize: 14.sp)),
              ),
              TextButton(
                onPressed: () => Navigator.pop(ctx, true),
                child: Text(AppTexts.delete,
                    style:
                        TextStyle(color: AppColors.redColor, fontSize: 14.sp)),
              ),
            ],
          ),
        ) ??
        false;
  }
}
