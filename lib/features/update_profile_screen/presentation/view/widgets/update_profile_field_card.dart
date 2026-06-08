import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/core/utils/app_colors.dart';

class UpdateProfileFieldCard extends StatelessWidget {
  final List<Widget> fields;

  const UpdateProfileFieldCard({super.key, required this.fields});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        color: AppColors.grayColor.withOpacity(0.62),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        children: List.generate(fields.length, (index) {
          return Column(
            children: [
              fields[index],
              if (index < fields.length - 1)
                Divider(
                  height: 1,
                  color: AppColors.whiteColor.withOpacity(0.1),
                  indent: 16.w,
                  endIndent: 16.w,
                ),
            ],
          );
        }),
      ),
    );
  }
}
