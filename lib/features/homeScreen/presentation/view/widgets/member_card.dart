import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/const Widgets/custom_button.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../data/model/team_model.dart';

class MemberCard extends StatelessWidget {
  final MemberModel member;
  final VoidCallback? onMessagePressed;

  const MemberCard({super.key, required this.member, this.onMessagePressed});

  /// Returns the first two words of [name] followed by '...' if there are more.
  String _truncateToTwoWords(String name) {
    final words = name.trim().split(RegExp(r'\s+'));
    if (words.length <= 2) return name;
    return '${words[0]} ${words[1]}...';
  }

  /// Detects whether the text is RTL (Arabic/Hebrew) or LTR.
  TextDirection _detectTextDirection(String text) {
    final rtlChar = RegExp(r'[\u0600-\u06FF\u0750-\u077F\u0590-\u05FF]');
    return rtlChar.hasMatch(text) ? TextDirection.rtl : TextDirection.ltr;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5.h, horizontal: 2.w),
      padding: EdgeInsets.all(10.r),
      decoration: BoxDecoration(
        color: AppColors.grayColor.withOpacity(0.62),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 18.r,
                backgroundColor: const Color(0xFF3A506B),
                backgroundImage:
                    (member.avatarUrl != null && member.avatarUrl!.isNotEmpty)
                        ? NetworkImage(member.avatarUrl!)
                        : null,
                child: (member.avatarUrl == null || member.avatarUrl!.isEmpty)
                    ? Icon(Icons.person, color: Colors.white, size: 16.sp)
                    : null,
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      _truncateToTwoWords(member.fullName ?? "No Name"),
                      overflow: TextOverflow.ellipsis,
                      textDirection: _detectTextDirection(member.fullName ?? ""),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13.sp,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      (member.skills != null && member.skills!.isNotEmpty)
                          ? member.skills![0]
                          : "Team Member",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 11.sp,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 15.h),
          SizedBox(
            width: double.infinity,
            child: CustomElevatedButton(
              text: 'Message',
              onPressed: onMessagePressed ?? () {},
              backgroundColor: Colors.white,
              textColor: Colors.black,
              fontSize: 14.sp,
              width: 120.w,
              height: 32.h,
            ),
          ),
        ],
      ),
    );
  }
}
