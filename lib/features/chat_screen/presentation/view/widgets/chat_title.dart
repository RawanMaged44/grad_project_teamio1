import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/const Widgets/chat_avatar.dart';

class ChatTile extends StatelessWidget {
  final String name;
  final String lastMessage;
  final int? unreadCount;
  final String? imageUrl;
  final bool isPinned;
  final bool isGroup;
  final VoidCallback onTap;

  const ChatTile({
    super.key,
    required this.name,
    required this.lastMessage,
    required this.onTap,
    this.unreadCount,
    this.imageUrl,
    this.isPinned = false,
    this.isGroup = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 6.h),
          child: ListTile(
            dense: true,
            visualDensity: const VisualDensity(vertical: -2),
            minLeadingWidth: 0,
            contentPadding:
                EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
            onTap: onTap,
            leading: ChatAvatar(
              imageUrl: imageUrl,
              isGroup: isGroup,
              radius: 25.r,
            ),
            title: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: AppColors.whiteColor,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            subtitle: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                lastMessage,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: AppColors.lightGrayColor,
                  fontSize: 13.sp,
                ),
              ),
            ),
            trailing: unreadCount != null && unreadCount! > 0
                ? Container(
                    padding: EdgeInsets.all(6.r),
                    decoration: const BoxDecoration(
                      color: Colors.blue,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      "$unreadCount",
                      style: TextStyle(
                        color: AppColors.whiteColor,
                        fontSize: 12.sp,
                      ),
                    ),
                  )
                : isPinned
                    ? Icon(Icons.push_pin, color: Colors.white, size: 18.sp)
                    : null,
          ),
        ),
        const Divider(color: Colors.white12, height: 1),
      ],
    );
  }
}
