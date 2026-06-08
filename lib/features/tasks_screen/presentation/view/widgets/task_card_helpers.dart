import 'package:flutter/material.dart';

import '../../../../../core/utils/app_colors.dart';

class TaskCardHelpers {
  static String formatDeadline(String? raw) {
    if (raw == null || raw.isEmpty) return '';
    try {
      final dt = DateTime.parse(raw);
      const months = [
        'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
        'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
      ];
      final hour = dt.hour > 12 ? dt.hour - 12 : (dt.hour == 0 ? 12 : dt.hour);
      final minute = dt.minute.toString().padLeft(2, '0');
      final period = dt.hour >= 12 ? 'PM' : 'AM';
      return '${dt.day} ${months[dt.month - 1]} • $hour:$minute $period';
    } catch (_) {
      return raw;
    }
  }

  static Widget buildStatusIcon(int? status) {
    if (status == 2) {
      return Container(
        width: 32,
        height: 32,
        decoration:  BoxDecoration(
          shape: BoxShape.circle,
          color:AppColors.grayColor.withOpacity(0.62),
        ),
        child: const Icon(Icons.access_time_filled_outlined, color: Colors.white, size: 18),
      );
    }
    // Not done: clock icon only (no container)
    return const Icon(Icons.watch_later_outlined, color: Colors.white38, size: 28);
  }
}
