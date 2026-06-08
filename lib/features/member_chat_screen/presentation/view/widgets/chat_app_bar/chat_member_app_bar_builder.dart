import 'package:flutter/material.dart';
import 'package:graduation_project/core/api/dio_helper.dart';
import 'package:graduation_project/features/chat_screen/data/repo/chat_repo_impl.dart';
import 'package:graduation_project/features/chat_screen/presentation/controller/chat_cbit/chat_cubit.dart';
import '../../ui_coordinators/chat_app_bar_coordinator.dart';
import '../chat_menu/chat_menu_button.dart';
import '../chat_menu/chat_menu_options.dart';
import '../chat_search/chat_search_bar.dart';
import 'chat_app_bar.dart';

class ChatMemberAppBarBuilder extends StatefulWidget implements PreferredSizeWidget {
  final bool isSearchMode;
  final TextEditingController searchController;
  final Function(String) onSearchChanged;
  final VoidCallback onCloseSearch;
  final VoidCallback onOpenSearch;
  final String name;
  final String avatar;
  final bool isGroup;
  final int? membersCount;
  final String? chatId;
  final bool isPinned;

  const ChatMemberAppBarBuilder({
    super.key,
    required this.isSearchMode,
    required this.searchController,
    required this.onSearchChanged,
    required this.onCloseSearch,
    required this.onOpenSearch,
    required this.name,
    required this.avatar,
    required this.isGroup,
    this.membersCount,
    this.chatId,
    this.isPinned = false,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  State<ChatMemberAppBarBuilder> createState() => _ChatMemberAppBarBuilderState();
}

class _ChatMemberAppBarBuilderState extends State<ChatMemberAppBarBuilder> {
  late bool _isPinned;

  @override
  void initState() {
    super.initState();
    _isPinned = widget.isPinned;
  }

  Future<void> _handlePin() async {
    if (widget.chatId == null) return;
    final repo = ChatRepoImpl(DioHelper.dio);
    final cubit = ChatCubit(chatRepo: repo);
    await cubit.togglePin(widget.chatId!);
    if (mounted) {
      setState(() => _isPinned = !_isPinned);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isSearchMode) {
      return ChatMemberSearchBar(
        controller: widget.searchController,
        onChanged: widget.onSearchChanged,
        onClose: widget.onCloseSearch,
      );
    }

    return ChatAppBar(
      name: widget.name,
      avatar: widget.avatar,
      chatType: widget.isGroup ? 1 : 0,
      membersCount: widget.isGroup ? (widget.membersCount ?? 0) : null,
      actionWidget: ChatMenuButton(
        items: ChatMenuOptions.getItems(isPinned: _isPinned),
        onSelected: (value) {
          if (value == 'clear') {
            ChatAppBarCoordinator.handleClearChat(context);
          } else if (value == 'search') {
            widget.onOpenSearch();
          } else if (value == 'pin') {
            _handlePin();
          }
        },
      ),
    );
  }
}
