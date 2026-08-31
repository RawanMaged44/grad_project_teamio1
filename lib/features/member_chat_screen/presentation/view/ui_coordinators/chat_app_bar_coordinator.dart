import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/core/api/dio_helper.dart';
import 'package:graduation_project/core/const%20Widgets/app_confirm_dialog.dart';
import 'package:graduation_project/core/utils/app_colors.dart';
import 'package:graduation_project/core/utils/app_texts.dart';
import 'package:graduation_project/features/chat_screen/data/repo/chat_repo_impl.dart';
import '../../controller/member_chat_cubit/member_chat_cubit.dart';

class ChatAppBarCoordinator {
  static Future<void> handleClearChat(BuildContext context) async {
    final confirm = await AppConfirmDialog.show(
      context: context,
      title: AppTexts.clearChat,
      message: AppTexts.clearChatConfirm,
      confirmLabel: AppTexts.clear,
      confirmColor: AppColors.redColor,
      cancelLabel: AppTexts.cancel,
    );

    if (!confirm || !context.mounted) return;

    final cubit = context.read<MemberChatCubit>();
    final chatId = cubit.chatId;

    if (chatId != null && chatId.isNotEmpty) {
      final chatRepo = ChatRepoImpl(DioHelper.dio);
      final result = await chatRepo.clearChat(chatId);

      if (!context.mounted) return;

      result.fold(
        (error) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Failed to clear chat: $error'),
              backgroundColor: Colors.red,
            ),
          );
        },
        (_) {
          cubit.clearChat();
        },
      );
    } else {
      cubit.clearChat();
    }
  }
}
