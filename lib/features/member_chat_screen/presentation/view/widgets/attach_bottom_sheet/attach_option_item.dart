import 'package:flutter/material.dart';
import 'package:graduation_project/core/utils/app_colors.dart';

class AttachOptionItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const AttachOptionItem({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(vertical: 8),
      leading: Container(
        padding: const EdgeInsets.all(10),
        decoration: const BoxDecoration(
          color: AppColors.whiteColor,
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: AppColors.mainColor, size: 24),
      ),
      title: Text(
        title,
        style: const TextStyle(
          color: AppColors.whiteColor,
          fontWeight: FontWeight.w600,
          fontSize: 18,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: const TextStyle(
          color: AppColors.whiteColor,
          fontSize: 12,
        ),
      ),
    );
  }
}
