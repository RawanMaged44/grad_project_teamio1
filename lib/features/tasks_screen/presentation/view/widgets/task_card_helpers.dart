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
    if (status == 1) {
      // Completed — filled blue circle with check (Figma)
      return Container(
        width: 30,
        height: 30,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Color(0xFFB3D4F5),
        ),
        child: const Icon(Icons.check, color: Color(0xFF1A1A2E), size: 16),
      );
    }
    // Pending — single outlined circle with clock inside (Figma)
    return Container(
      width: 30,
      height: 30,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white30, width: 1.5),
      ),
      child: const Icon(Icons.access_time, color: Colors.white38, size: 16),
    );
  }
}
