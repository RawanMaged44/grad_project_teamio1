import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/core/const%20Widgets/custom_button.dart';
import 'package:graduation_project/core/utils/app_colors.dart';
import 'package:graduation_project/core/utils/app_styles.dart';
import 'package:graduation_project/core/utils/app_texts.dart';
import '../../controller/task_cubit/task_cubit.dart';

class AddTaskSheetContent extends StatefulWidget {
  const AddTaskSheetContent({super.key});

  @override
  State<AddTaskSheetContent> createState() => _AddTaskSheetContentState();
}

class _AddTaskSheetContentState extends State<AddTaskSheetContent> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descController = TextEditingController();
  final _deadlineController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    _deadlineController.dispose();
    super.dispose();
  }

  Future<void> _pickDeadline() async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
    );
    if (date == null || !mounted) return;

    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (time == null || !mounted) return;

    final dt = DateTime(date.year, date.month, date.day, time.hour, time.minute);
    _deadlineController.text = dt.toIso8601String();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);
    final taskCubit = context.read<TaskCubit>();

    final success = await taskCubit.createTask(
      title: _titleController.text.trim(),
      description: _descController.text.trim(),
      deadline: _deadlineController.text.trim(),
    );

    if (!mounted) return;
    setState(() => _isLoading = false);

    if (success) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text(AppTexts.taskCreatedSuccess)),
      );
    } else {
      final error = taskCubit.lastError ?? AppTexts.taskCreatedFailed;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(error),
          backgroundColor: Colors.red.shade700,
          duration: const Duration(seconds: 4),
        ),
      );
    }
  }

  Widget _buildField({
    required TextEditingController controller,
    required String hint,
    Widget? suffix,
    VoidCallback? onTap,
    int maxLines = 1,
  }) {
    final field = TextFormField(
      controller: controller,
      maxLines: maxLines,
      style: TextStyle(color: AppColors.whiteColor, fontSize: 15.sp),
      cursorColor: Colors.white,
      validator: (v) => (v == null || v.trim().isEmpty) ? AppTexts.required : null,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: AppColors.lightGrayColor, fontSize: 15.sp),
        suffixIcon: suffix,
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        filled: false,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.r),
          borderSide: const BorderSide(color: AppColors.whiteColor, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.r),
          borderSide: const BorderSide(color: AppColors.whiteColor, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.r),
          borderSide: const BorderSide(color: AppColors.redColor, width: 1),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.r),
          borderSide: const BorderSide(color: AppColors.redColor, width: 1),
        ),
      ),
    );

    if (onTap != null) {
      return GestureDetector(onTap: onTap, child: AbsorbPointer(child: field));
    }
    return field;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 16.w,
        right: 16.w,
        top: 24.h,
        bottom: MediaQuery.of(context).viewInsets.bottom + 24.h,
      ),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(width: 32.w),
                Text(AppTexts.addTask, style: AppStyles.white18bold),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Icon(Icons.close, color: Colors.white, size: 24.sp),
                ),
              ],
            ),
            SizedBox(height: 24.h),
            _buildField(controller: _titleController, hint: AppTexts.addTitle),
            SizedBox(height: 16.h),
            _buildField(
                controller: _descController,
                hint: AppTexts.addDescription,
                maxLines: 2),
            SizedBox(height: 16.h),
            _buildField(
              controller: _deadlineController,
              hint: AppTexts.addDeadline,
              suffix: Icon(Icons.calendar_today, color: Colors.white54, size: 18.sp),
              onTap: _pickDeadline,
            ),
            SizedBox(height: 24.h),
            Center(
              child: CustomElevatedButton(
                text: AppTexts.saveTask,
                onPressed: _save,
                isLoading: _isLoading,
                backgroundColor: AppColors.whiteColor,
                textColor: AppColors.mainColor,
                fontSize: 16.sp,
                width: 0.90.sw,
                height: 48.h,
                borderRadius: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
