import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/core/utils/app_styles.dart';
import 'package:graduation_project/core/utils/app_texts.dart';
import 'add_task_sheet.dart';

class TaskAppBar extends StatelessWidget implements PreferredSizeWidget {
  const TaskAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      titleSpacing: 20.w,
      title: Text(AppTexts.tasks, style: AppStyles.white18bold),
      actions: [
        IconButton(
          onPressed: () => showAddTaskSheet(context),
          icon: Icon(Icons.add_circle, color: Colors.white, size: 26.sp),
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.delete, color: Colors.white, size: 24.sp),
        ),
        SizedBox(width: 4.w),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight.h);
}
