import 'package:flutter/material.dart';
import '../../../../../../core/utils/app_colors.dart';

class ChatMenuItem extends StatelessWidget {
  final String title;
  final IconData icon;

  const ChatMenuItem({
    super.key,
    required this.title,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: AppColors.whiteColor, size: 20),
        const SizedBox(width: 12),
        Text(
          title,
          style: const TextStyle(
            color: AppColors.whiteColor,
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}