import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/core/api/api_constants.dart';
import '../../../../../../core/utils/app_colors.dart';

class ProfileAvatar extends StatelessWidget {
  final String? avatarUrl;

  const ProfileAvatar({super.key, this.avatarUrl});

  @override
  Widget build(BuildContext context) {
    final fullUrl = ApiConstants.buildImageUrl(avatarUrl);
    return CircleAvatar(
      radius: 66.r,
      backgroundColor: AppColors.whiteColor,
      backgroundImage: fullUrl != null ? NetworkImage(fullUrl) : null,
      child: fullUrl == null
          ? Icon(Icons.person, size: 60.sp, color: AppColors.whiteColor)
          : null,
    );
  }
}
