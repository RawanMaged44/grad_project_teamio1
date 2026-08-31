import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/functions/list_filter.dart';
import '../../../../../core/functions/storage_helper.dart';
import '../../../../member_chat_screen/data/model/chat_args_model.dart';
import '../../../../member_chat_screen/presentation/view/screens/member_chat_screen.dart';
import '../../../data/model/chat_model.dart';
import '../../controller/chat_cbit/chat_cubit.dart';
import 'chat_title.dart';

class ChatListView extends StatelessWidget {
  final String searchQuery;

  const ChatListView({super.key, required this.searchQuery});

  /// Resolves the members count to display in the chat app bar.
  /// - chatType 1 (team only): use count from backend, default to 10 if missing
  /// - chatType 2 (team + doctor): use count + 1, default to 11 if missing
  int? _resolveMembersCount(int? chatType, int? membersCount) {
    if (chatType == 1) {
      final count = (membersCount == null || membersCount == 0) ? 10 : membersCount;
      return count;
    }
    if (chatType == 2) {
      final base = (membersCount == null || membersCount == 0) ? 10 : membersCount;
      return base + 1;
    }
    return membersCount; // private chat — not shown anyway
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatCubit, ChatState>(
      builder: (context, state) {
        if (state is ChatLoadingState) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is ChatErrorState) {
          return Center(child: Text(state.errorMessage));
        }
        if (state is ChatSuccessState) {
          final chats = ListFilter.filter<ChatsData>(
            items: state.chatModel.data ?? [],
            query: searchQuery,
            getField: (chat) => chat.name ?? '',
          );

          if (chats.isEmpty) {
            return const Center(
              child: Text("No chats found", style: TextStyle(color: Colors.white)),
            );
          }

          return ListView.builder(
            itemCount: chats.length,
            itemBuilder: (context, index) {
              final chat = chats[index];
              return FutureBuilder<DateTime?>(
                future: StorageHelper.getChatClearedAt(chat.chatId ?? ''),
                builder: (context, snapshot) {
                  final clearedAt = snapshot.data;
                  // Hide last message if it was sent before the clear timestamp
                  String lastMsg = chat.lastMessageContent ?? '';
                  int? unread = chat.unreadCount;
                  if (clearedAt != null && chat.lastMessageData != null) {
                    try {
                      final msgTime = DateTime.parse(chat.lastMessageData!);
                      if (!msgTime.isAfter(clearedAt)) {
                        lastMsg = '';
                        unread = 0;
                      }
                    } catch (_) {}
                  }
                  return ChatTile(
                    name: chat.name ?? "",
                    lastMessage: lastMsg,
                    unreadCount: unread,
                    isPinned: chat.isPinned ?? false,
                    isGroup: chat.chatType == 1 || chat.chatType == 2,
                    onTap: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => MemberChatScreen(
                            args: ChatArgsModel(
                              chatId: chat.chatId,
                              userId: "",
                              name: chat.name ?? "",
                              avatar: null,
                              chatType: chat.chatType ?? 0,
                              membersCount: _resolveMembersCount(chat.chatType, chat.membersCount),
                              isPinned: chat.isPinned ?? false,
                            ),
                          ),
                        ),
                      );
                      if (context.mounted) {
                        context.read<ChatCubit>().getMyChats();
                      }
                    },
                  );
                },
              );
            },
          );
        }
        return const SizedBox();
      },
    );
  }
}
