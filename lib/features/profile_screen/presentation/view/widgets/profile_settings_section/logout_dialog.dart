import 'package:flutter/material.dart';
import 'package:graduation_project/core/functions/storage_helper.dart';
import 'package:graduation_project/core/utils/app_colors.dart';
import 'package:graduation_project/core/utils/app_routes.dart';
import 'package:graduation_project/core/utils/app_texts.dart';

void showLogoutDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (_) => AlertDialog(
      backgroundColor: AppColors.grayColor,
      title: const Text(AppTexts.logout, style: TextStyle(color: Colors.white)),
      content: const Text(
        AppTexts.sureLogOut,
        style: TextStyle(color: AppColors.whiteColor),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text(AppTexts.cancel, style: TextStyle(color: AppColors.whiteColor)),
        ),
        TextButton(
          onPressed: () async {
            Navigator.pop(context);
            await StorageHelper.clearTokens();
            if (context.mounted) {
              Navigator.pushNamedAndRemoveUntil(
                context,
                AppRoute.loginRoute,
                (route) => false,
              );
            }
          },
          child: const Text(AppTexts.logout, style: TextStyle(color: AppColors.redColor)),
        ),
      ],
    ),
  );
}
