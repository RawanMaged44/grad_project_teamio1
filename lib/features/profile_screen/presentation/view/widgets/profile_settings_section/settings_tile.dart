import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/core/utils/app_styles.dart';
import '../../../../../../core/utils/app_colors.dart';

class SettingsTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const SettingsTile({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Icon(icon, color: AppColors.whiteColor, size: 20.sp),
      title: Text(label, style: AppStyles.white15medium),
      contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 2.h),
    );
  }
}
