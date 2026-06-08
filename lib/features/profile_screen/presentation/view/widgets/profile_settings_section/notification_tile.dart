import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../core/utils/app_texts.dart';

class NotificationTile extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  const NotificationTile({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.notifications_off, color: Colors.white70, size: 20.sp),
      title: Text(
        AppTexts.pauseNotification,
        style: TextStyle(color: Colors.white, fontSize: 15.sp),
      ),
      trailing: Switch(
        value: value,
        onChanged: onChanged,
        activeColor: Colors.white,
        activeTrackColor: const Color(0xFF6B9FD4),
        inactiveThumbColor: Colors.white54,
        inactiveTrackColor: Colors.white24,
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 2.h),
    );
  }
}
