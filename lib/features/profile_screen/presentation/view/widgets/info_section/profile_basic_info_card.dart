import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/core/utils/app_colors.dart';
import 'package:graduation_project/core/utils/app_texts.dart';
import 'package:graduation_project/features/profile_screen/data/model/profile_model.dart';
import 'profile_info_row.dart';

class ProfileBasicInfoCard extends StatelessWidget {
  final Data profile;

  const ProfileBasicInfoCard({super.key, required this.profile});

  String _departmentName(int? dept) {
    switch (dept) {
      case 0:
        return AppTexts.computerScience;
      case 1:
        return AppTexts.informationTechnology;
      case 2:
        return AppTexts.softwareEngineering;
      default:
        return 'N/A';
    }
  }

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
            AppTexts.basicInformation,
            style: TextStyle(
              color: const Color(0xFF96B3D4),
              fontSize: 15.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 15.h),
          ProfileInfoRow(label: AppTexts.name, value: profile.fullName ?? ''),
          ProfileInfoRow(
              label: AppTexts.department,
              value: _departmentName(profile.department)),
          ProfileInfoRow(
              label: AppTexts.year,
              value: profile.graduationYear?.toString() ?? ''),
          ProfileInfoRow(label: AppTexts.email, value: profile.email ?? ''),
        ],
      ),
    );
  }
}
