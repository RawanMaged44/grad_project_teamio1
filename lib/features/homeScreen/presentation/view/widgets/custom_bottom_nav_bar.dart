import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/utils/app_colors.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70.h,
      margin: EdgeInsets.all(25.r),
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      decoration: BoxDecoration(
        color: AppColors.grayColor.withOpacity(0.92),
        borderRadius: BorderRadius.circular(40.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _item(0, Icons.group, "Team"),
          _item(1, Icons.messenger_outlined, "Chats"),
          _item(2, Icons.access_time_filled, "Task"),
          _item(3, Icons.person, "Profile"),
        ],
      ),
    );
  }

  Widget _item(int index, IconData icon, String text) {
    final isSelected = currentIndex == index;

    return GestureDetector(
      onTap: () => onTap(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: EdgeInsets.symmetric(
          horizontal: isSelected ? 16.w : 0,
          vertical: 10.h,
        ),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(30.r),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: isSelected ? Colors.black : Colors.white,
              size: isSelected ? 20.sp : 26.sp,
            ),
            if (isSelected) ...[
              SizedBox(width: 6.w),
              Text(
                text,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 14.sp,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
