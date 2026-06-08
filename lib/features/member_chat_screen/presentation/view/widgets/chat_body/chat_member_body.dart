import 'package:flutter/material.dart';
import '../../ui_coordinators/chat_search_coordinator.dart';
import '../chat_input/chat_input.dart';
import '../chat_messages/chat_messages_list.dart';

class ChatMemberBody extends StatelessWidget {
  final String currentUserName;
  final ChatSearchCoordinator searchControllerLogic;
  final ScrollController scrollController;
  final VoidCallback onNewMessage;
  final TextEditingController textController;
  final VoidCallback onSend;
  final void Function(Object? file)? onFilePicked;
  final bool isGroup;

  const ChatMemberBody({
    super.key,
    required this.currentUserName,
    required this.searchControllerLogic,
    required this.scrollController,
    required this.onNewMessage,
    required this.textController,
    required this.onSend,
    this.onFilePicked,
    this.isGroup = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ChatMessagesList(
            currentUserName: currentUserName,
            searchControllerLogic: searchControllerLogic,
            scrollController: scrollController,
            onNewMessage: onNewMessage,
            isGroup: isGroup,
          ),
        ),
        ChatInput(
          controller: textController,
          onAttach: () {},
          onSend: onSend,
          onFilePicked: onFilePicked,
        ),
      ],
    );
  }
}