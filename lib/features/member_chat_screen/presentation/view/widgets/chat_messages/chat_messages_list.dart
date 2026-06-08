import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../ui_coordinators/chat_search_coordinator.dart';
import '../../../controller/member_chat_cubit/member_chat_cubit.dart';
import '../chat_body/message_bubble.dart';

class ChatMessagesList extends StatefulWidget {
  final String currentUserName;
  final ChatSearchCoordinator searchControllerLogic;
  final ScrollController scrollController;
  final VoidCallback? onNewMessage;
  final VoidCallback? onScrollToMatch;
  final bool isGroup;

  const ChatMessagesList({
    super.key,
    required this.currentUserName,
    required this.searchControllerLogic,
    required this.scrollController,
    this.onNewMessage,
    this.onScrollToMatch,
    this.isGroup = false,
  });

  @override
  State<ChatMessagesList> createState() => _ChatMessagesListState();
}

class _ChatMessagesListState extends State<ChatMessagesList> {
  final Map<int, GlobalKey> _itemKeys = {};
  int _lastMatchIndex = -1;

  void _scrollToMatchIfChanged(MemberChatCubit cubit) {
    final currentIdx = cubit.currentIndex;
    if (currentIdx < 0 || currentIdx == _lastMatchIndex) return;
    _lastMatchIndex = currentIdx;

    final globalIndex = cubit.getCurrentGlobalIndex();
    final key = _itemKeys[globalIndex];
    if (key?.currentContext == null) return;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (key?.currentContext != null) {
        Scrollable.ensureVisible(
          key!.currentContext!,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          alignment: 0.5,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MemberChatCubit, MemberChatState>(
      builder: (context, state) {
        if (state is MemberChatLoadingState) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is MemberChatErrorState) {
          return Center(child: Text(state.errorMessage));
        }

        if (state is MemberChatSuccessState) {
          final messages = state.messageModel.data?.items ?? [];
          final cubit = context.read<MemberChatCubit>();

          WidgetsBinding.instance.addPostFrameCallback((_) {
            widget.onNewMessage?.call();
          });

          if (messages.isEmpty) {
            return const Center(
              child: Text(
                "No messages yet",
                style: TextStyle(color: Colors.grey),
              ),
            );
          }

          return ListView.builder(
            controller: widget.scrollController,
            reverse: true,
            itemCount: messages.length,
            itemBuilder: (context, index) {
              final msg = messages[index];
              final isMe = msg.isOwner == true;

              // Assign a GlobalKey for each item
              _itemKeys[index] ??= GlobalKey();

              return MessageBubble(
                key: _itemKeys[index],
                msg: msg,
                isMe: isMe,
                showDate: false,
                searchQuery: widget.searchControllerLogic.query,
                isGroup: widget.isGroup,
              );
            },
          );
        }

        return const SizedBox();
      },
    );
  }
}
