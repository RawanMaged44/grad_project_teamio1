import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/const Widgets/chat_avatar.dart';

class ChatAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String name;
  final String? avatar;
  final int? membersCount;
  final int? chatType;
  final Widget? actionWidget;

  const ChatAppBar({
    super.key,
    required this.name,
    this.avatar,
    this.membersCount,
    this.chatType,
    this.actionWidget,
  });

  bool get isGroup => chatType == 1;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      shadowColor: Colors.transparent,
      elevation: 0,
      leading: IconButton(
        icon: Icon(Icons.arrow_back, color: AppColors.whiteColor, size: 20.sp),
        onPressed: () => Navigator.pop(context),
      ),
      title: Row(
        children: [
          ChatAvatar(
            imageUrl: avatar,
            isGroup: isGroup,
            radius: 20.r,
          ),
          SizedBox(width: 12.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              if (isGroup && membersCount != null)
                Text(
                  "$membersCount Members",
                  style: TextStyle(fontSize: 11.sp, color: Colors.grey),
                ),
            ],
          ),
        ],
      ),
      actions: [
        if (actionWidget != null) actionWidget!,
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight.h);
}
