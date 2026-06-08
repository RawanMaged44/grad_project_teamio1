import 'package:flutter/material.dart';
import '../../controller/member_chat_cubit/member_chat_cubit.dart';

class ChatSendController {
  final MemberChatCubit cubit;
  final String userId;
  final TextEditingController textController;

  ChatSendController({
    required this.cubit,
    required this.userId,
    required this.textController,
  });

  void sendMessage() {
    final text = textController.text.trim();
    if (text.isEmpty) return;
    cubit.sendMessage(text, userId);
    textController.clear();
  }

  void sendFile({required String filePath, required String fileName}) {
    cubit.sendFile(
      filePath: filePath,
      fileName: fileName,
      userId: userId,
    );
  }
}