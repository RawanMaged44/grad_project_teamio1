import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/core/utils/app_colors.dart';
import 'package:graduation_project/core/utils/app_styles.dart';
import '../../../../../../core/utils/app_texts.dart';

class ProfileSkillsCard extends StatelessWidget {
  final List<String> skills;

  const ProfileSkillsCard({super.key, required this.skills});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: AppColors.grayColor.withOpacity(0.62),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppTexts.skills,
            style: TextStyle(
              color: const Color(0xFF96B3D4),
              fontSize: 15.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 12.h),
          if (skills.isEmpty)
            Text(AppTexts.noSkillsAdded, style: AppStyles.white14medium)
          else
            ...skills.map(
              (skill) => Padding(
                padding: EdgeInsets.only(bottom: 8.h),
                child: Text(skill, style: AppStyles.white14medium),
              ),
            ),
        ],
      ),
    );
  }
}
