import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/core/api/api_constants.dart';
import 'package:graduation_project/core/utils/app_colors.dart';

class UpdateProfileAvatar extends StatelessWidget {
  final String? currentAvatarUrl;
  final File? pickedImage;
  final VoidCallback onTap;

  const UpdateProfileAvatar({
    super.key,
    this.currentAvatarUrl,
    this.pickedImage,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          CircleAvatar(
            radius: 66.r,
            backgroundColor: AppColors.mainColor,
            backgroundImage: _resolveImage(),
            child: _resolveImage() == null
                ? Icon(Icons.person, size: 52.sp, color: AppColors.whiteColor)
                : null,
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: GestureDetector(
              onTap: onTap,
              child: Container(
                padding: EdgeInsets.all(6.r),
                decoration: const BoxDecoration(
                  color: AppColors.whiteColor,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.camera_alt,
                  size: 18.sp,
                  color: AppColors.darkBlueColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  ImageProvider? _resolveImage() {
    if (pickedImage != null) return FileImage(pickedImage!);
    final fullUrl = ApiConstants.buildImageUrl(currentAvatarUrl);
    if (fullUrl != null) return NetworkImage(fullUrl);
    return null;
  }
}
