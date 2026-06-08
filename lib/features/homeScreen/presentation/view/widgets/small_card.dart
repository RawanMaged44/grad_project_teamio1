import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/core/utils/app_colors.dart';
import 'package:graduation_project/core/utils/app_styles.dart';

class SmallInfoCard extends StatelessWidget {
  final String title;
  final String? imageUrl;
  final VoidCallback? onTap;

  const SmallInfoCard({super.key, required this.title, this.imageUrl, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 20.h),
        decoration: BoxDecoration(
          color: AppColors.grayColor.withOpacity(.62),
          borderRadius: BorderRadius.circular(40.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              backgroundColor: Colors.grey[800],
              radius: 18.r,
              backgroundImage: imageUrl != null ? NetworkImage(imageUrl!) : null,
              child: imageUrl == null
                  ? Icon(Icons.person, color: Colors.white, size: 18.sp)
                  : null,
            ),
            SizedBox(height: 8.h),
            Row(
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: AppStyles.white16bold,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Icon(Icons.arrow_forward, color: Colors.white, size: 22.sp),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
