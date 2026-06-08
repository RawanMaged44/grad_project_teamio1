import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/api/dio_helper.dart';
import '../../../../../core/const Widgets/app_background.dart';
import '../../../../../core/functions/storage_helper.dart';
import '../../../data/model/chat_args_model.dart';
import '../../../data/repo/message_repo_impl.dart';
import '../../controller/member_chat_cubit/member_chat_cubit.dart';
import '../ui_coordinators/chat_send_coordinator.dart';
import '../ui_coordinators/chat_search_coordinator.dart';
import '../ui_coordinators/chat_scroll_coordinator.dart';
import '../ui_coordinators/chat_file_coordinator.dart';
import '../widgets/chat_app_bar/chat_member_app_bar_builder.dart';
import '../widgets/chat_body/chat_member_body.dart';
import '../widgets/chat_search/chat_search_result_bar.dart';

class MemberChatScreen extends StatefulWidget {
  static String routeName = '/member-chat';
  final ChatArgsModel args;

  const MemberChatScreen({super.key, required this.args});

  @override
  State<MemberChatScreen> createState() => _MemberChatScreenState();
}

class _MemberChatScreenState extends State<MemberChatScreen> {
  late final MemberChatCubit cubit;
  late final ChatSendController sendController;
  late final ChatSearchCoordinator searchCoordinator;
  late final ChatScrollCoordinator scrollCoordinator;
  late final ChatFileCoordinator fileCoordinator;

  final TextEditingController textController = TextEditingController();
  final TextEditingController searchController = TextEditingController();
  final ScrollController scrollController = ScrollController();

  String currentUserName = '';

  @override
  void initState() {
    super.initState();

    cubit = MemberChatCubit(messageRepo: MessageRepoImpl(DioHelper.dio));
    cubit.initializeChat(
      initialChatId: widget.args.chatId,
      userId: widget.args.userId,
      onChatCreated: widget.args.onChatCreated,
    );

    StorageHelper.getUserName().then((name) {
      if (mounted) setState(() => currentUserName = name ?? '');
    });

    scrollCoordinator = ChatScrollCoordinator(
      scrollController: scrollController,
      onLoadMore: () => cubit.loadMoreMessages(),
    );

    searchCoordinator = ChatSearchCoordinator(
      cubit: cubit,
      searchController: searchController,
      onStateChanged: () => setState(() {}),
    );

    sendController = ChatSendController(
      cubit: cubit,
      userId: widget.args.userId,
      textController: textController,
    );

    fileCoordinator = ChatFileCoordinator(
      cubit: cubit,
      userId: widget.args.userId,
      scrollCoordinator: scrollCoordinator,
    );
  }

  @override
  void dispose() {
    textController.dispose();
    searchController.dispose();
    scrollController.dispose();
    searchCoordinator.dispose();
    scrollCoordinator.dispose();
    cubit.close();
    super.dispose();
  }

  void _scrollToCurrentMatch() {
    final globalIndex = cubit.getCurrentGlobalIndex();
    if (globalIndex < 0) return;
    scrollCoordinator.scrollToMatch(globalIndex);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: cubit,
      child: AppBackground(
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: Colors.transparent,
          appBar: ChatMemberAppBarBuilder(
            isSearchMode: searchCoordinator.isSearchMode,
            searchController: searchController,
            onSearchChanged: searchCoordinator.onSearchChanged,
            onCloseSearch: () => searchCoordinator.toggleSearchMode(false),
            onOpenSearch: () => searchCoordinator.toggleSearchMode(true),
            name: widget.args.name,
            avatar: widget.args.avatar ?? '',
            isGroup: widget.args.isGroup,
            membersCount: widget.args.membersCount,
            chatId: widget.args.chatId,
            isPinned: widget.args.isPinned,
          ),
          body: BlocListener<MemberChatCubit, MemberChatState>(
            listenWhen: (_, state) =>
                state is MemberChatSuccessState &&
                state.newlyCreatedChatId != null,
            listener: (context, state) {
              if (state is MemberChatSuccessState &&
                  state.newlyCreatedChatId != null) {
                final newChatId = state.newlyCreatedChatId!;
                widget.args.onChatCreated?.call(newChatId);
                StorageHelper.saveMemberChatId(
                  memberId: widget.args.userId,
                  chatId: newChatId,
                );
              }
            },
            child: ChatMemberBody(
              currentUserName: currentUserName,
              searchControllerLogic: searchCoordinator,
              scrollController: scrollController,
              onNewMessage: scrollCoordinator.scrollToBottom,
              textController: textController,
              isGroup: widget.args.isGroup,
              onSend: () {
                sendController.sendMessage();
                scrollCoordinator.scrollToBottom();
              },
              onFilePicked: fileCoordinator.handleFilePicked,
            ),
          ),
          bottomSheet: BlocBuilder<MemberChatCubit, MemberChatState>(
            builder: (context, state) => ChatSearchResultBar(
              resultCount: cubit.searchService.filteredCount,
              currentIndex: cubit.currentIndex,
              hasQuery: searchCoordinator.searchQuery.isNotEmpty,
              onNext: () async {
                cubit.nextMatch();
                await Future.delayed(const Duration(milliseconds: 50));
                _scrollToCurrentMatch();
              },
              onPrev: () async {
                cubit.previousMatch();
                await Future.delayed(const Duration(milliseconds: 50));
                _scrollToCurrentMatch();
              },
            ),
          ),
        ),
      ),
    );
  }
}
