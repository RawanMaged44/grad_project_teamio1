import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/core/utils/app_colors.dart';
import 'package:graduation_project/core/utils/app_texts.dart';
import '../../controller/member_chat_cubit/member_chat_cubit.dart';

class ChatAppBarCoordinator {
  /// Shows a confirmation dialog and clears chat messages locally on confirm.
  static Future<void> handleClearChat(BuildContext context) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.grayColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text(
          AppTexts.clearChat,
          style: TextStyle(color: Colors.white),
        ),
        content: const Text(
          AppTexts.clearChatConfirm,
          style: TextStyle(color: Colors.grey),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text(AppTexts.cancel,
                style: TextStyle(color: Colors.white70)),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text(AppTexts.clear,
                style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (confirm == true && context.mounted) {
      context.read<MemberChatCubit>().clearChat();
    }
  }
}
