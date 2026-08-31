import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import '../../../../../core/functions/storage_helper.dart';
import '../../../../../core/functions/chat_signalr_service.dart';
import '../../../data/model/message_model.dart';
import '../../../data/repo/message_repo.dart';
import '../services/message_manager.dart';
import '../services/chat_pagination_services.dart';
import '../services/chat_real_time_service.dart';
import '../services/chat_action_service.dart';
import '../services/chat_search_service.dart';
import '../services/chat_message_sync_service.dart';
part 'member_chat_state.dart';

class MemberChatCubit extends Cubit<MemberChatState> {
  final MessageRepo messageRepo;
  String? chatId;

  final MessageManager manager = MessageManager();
  final ChatSearchService searchService = ChatSearchService();
  final ChatPaginationService pagination = ChatPaginationService();

  MessageModel? currentModel;
  String? myName;
  bool _isInitialized = false;

  late final ChatRealtimeService realtimeService;
  late final ChatActionService actionService;
  late final ChatMessageSyncService syncService;

  MemberChatCubit({required this.messageRepo}) : super(MemberChatInitialState()) {
    realtimeService = ChatRealtimeService(ChatSignalRService());
    actionService = ChatActionService(messageRepo, realtimeService);
    syncService = ChatMessageSyncService(
      manager: manager,
      searchService: searchService,
      getMyName: () => myName ?? '',
    );
  }

  void _emitSuccess({String? newlyCreatedChatId}) {
    if (!isClosed && currentModel != null) {
      emit(MemberChatSuccessState(
        messageModel: currentModel!,
        myName: myName ?? '',
        newlyCreatedChatId: newlyCreatedChatId,
      ));
    }
  }

  void Function(String)? onChatCreated;

  Future<void> initializeChat({String? initialChatId, required String userId, void Function(String)? onChatCreated}) async {
    this.onChatCreated = onChatCreated;
    if (_isInitialized) return _emitSuccess();

    emit(MemberChatLoadingState());
    myName = await StorageHelper.getUserName();
    chatId = initialChatId;

    if (chatId == null) {
      _initEmptyChat();
    } else {
      await _loadMessagesAndConnect();
    }
    _isInitialized = true;
  }

  void _initEmptyChat() {
    currentModel = MessageModel(success: true, data: MessageData(items: [], totalCount: 0, pageNumber: 1, pageSize: 20));
    manager.setMessages([]);
    searchService.setMessages([]);
    _emitSuccess();
  }

  Future<void> _loadMessagesAndConnect() async {
    final clearedAt = await StorageHelper.getChatClearedAt(chatId!);

    final result = await messageRepo.getMessages(chatId!);
    result.fold(
      (l) => emit(MemberChatErrorState(errorMessage: l)),
      (r) async {
        // Filter out messages sent before (or at) the clear timestamp — server-side
        // ClearedAt may not be enforced yet, so we do it client-side too.
        if (clearedAt != null && r.data?.items != null) {
          r.data!.items = r.data!.items!.where((msg) {
            if (msg.createAt == null) return true;
            try {
              final msgTime = DateTime.parse(msg.createAt!).toUtc();
              return msgTime.isAfter(clearedAt.toUtc());
            } catch (_) {
              return true;
            }
          }).toList();
        }

        _setupInitialChatData(r);
        final token = await StorageHelper.getAccessToken();
        if (token != null) {
          await realtimeService.connectAndListen(
            token: token,
            chatId: chatId!,
            onMessage: (data) => syncService.handleIncomingMessage(
              data: data,
              chatId: chatId,
              currentModel: currentModel!,
              updateUI: (_) => _emitSuccess(),
            ),
          );
        }
        _emitSuccess();
      },
    );
  }

  void _setupInitialChatData(MessageModel model) {
    currentModel = model;
    final items = model.data?.items ?? [];
    manager.setMessages(items);
    searchService.setMessages(items);
    pagination.reset();
    pagination.hasMore = items.length >= 20;
  }

  Future<void> loadMoreMessages() async {
    if (!pagination.canLoadMore(chatId)) return;
    pagination.startLoading();
    final result = await messageRepo.getMessages(chatId!, page: pagination.nextPage());

    result.fold((l) => pagination.isLoading = false, (r) {
      final newItems = r.data?.items ?? [];
      if (newItems.isEmpty) {
        pagination.onEmpty();
      } else {
        manager.appendOldMessages(newItems);
        searchService.setMessages(manager.allMessages);
        currentModel!.data?.items = List.from(manager.allMessages);
        pagination.onSuccess(pagination.nextPage(), newItems.length);
        _emitSuccess();
      }
    });
  }

  Future<void> sendMessage(String content, String userId, {bool isFile = false}) async {
    if (content.trim().isEmpty) return;

    final displayContent = isFile ? '📎 $content' : content;
    _updateUILocally(displayContent);

    final newChatId = await actionService.handleSendMessage(
      chatId: chatId,
      userId: userId,
      content: displayContent,
    );

    if (chatId == null && newChatId != null) {
      chatId = newChatId;
      onChatCreated?.call(newChatId);
      final optimisticMessages = List<MessageItem>.from(manager.allMessages);
      _isInitialized = false;
      // Remove clear filter so new messages after clear are visible
      await StorageHelper.unmarkChatAsCleared(newChatId);
      await _loadMessagesAndConnect();
      _mergeOptimisticMessages(optimisticMessages);
      _emitSuccess(newlyCreatedChatId: newChatId);
    } else if (chatId != null) {
      // Remove clear filter on first message sent after a clear
      await StorageHelper.unmarkChatAsCleared(chatId!);
    }
  }

  void _mergeOptimisticMessages(List<MessageItem> optimistic) {
    for (final msg in optimistic) {
      final exists = manager.allMessages.any(
        (m) => m.content == msg.content && m.senderName == msg.senderName,
      );
      if (!exists) manager.addMessage(msg);
    }
    currentModel?.data?.items = List.from(manager.allMessages);
    searchService.setMessages(manager.allMessages);
  }

  void _updateUILocally(String content) {
    manager.addMessage(MessageItem(senderName: myName ?? '', content: content, createAt: DateTime.now().toString(), isOwner: true));
    searchService.setMessages(manager.allMessages);
    currentModel?.data?.items = List.from(manager.allMessages);
    _emitSuccess();
  }

  Future<void> sendFile({required String filePath, required String fileName, required String userId}) async {
    await sendMessage(fileName, userId, isFile: true);
  }

  void searchMessages(String query) { searchService.search(query); _emitSuccess(); }
  void nextMatch() { searchService.next(); _emitSuccess(); }
  void previousMatch() { searchService.previous(); _emitSuccess(); }

  void clearChat() {
    manager.setMessages([]);
    searchService.setMessages([]);
    currentModel?.data?.items = [];
    if (chatId != null) {
      StorageHelper.markChatAsCleared(chatId!);
    }
    _emitSuccess();
  }

  int getCurrentGlobalIndex() => searchService.getCurrentGlobalIndex();
  int get currentIndex => searchService.currentIndex;

  @override
  Future<void> close() async { await realtimeService.disconnect(); return super.close(); }
}