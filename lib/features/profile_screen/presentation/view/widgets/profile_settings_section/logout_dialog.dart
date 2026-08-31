import 'package:flutter/material.dart';
import 'package:graduation_project/core/const%20Widgets/app_confirm_dialog.dart';
import 'package:graduation_project/core/functions/storage_helper.dart';
import 'package:graduation_project/core/utils/app_colors.dart';
import 'package:graduation_project/core/utils/app_routes.dart';
import 'package:graduation_project/core/utils/app_texts.dart';

void showLogoutDialog(BuildContext context) async {
  final confirmed = await AppConfirmDialog.show(
    context: context,
    title: AppTexts.logout,
    message: AppTexts.sureLogOut,
    confirmLabel: AppTexts.logout,
    confirmColor: AppColors.redColor,
    cancelLabel: AppTexts.cancel,
  );

  if (confirmed && context.mounted) {
    await StorageHelper.clearTokens();
    if (context.mounted) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        AppRoute.loginRoute,
        (route) => false,
      );
    }
  }
}
