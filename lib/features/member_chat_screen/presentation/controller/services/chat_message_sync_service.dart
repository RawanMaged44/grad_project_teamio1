import '../../../data/model/message_model.dart';
import 'chat_search_service.dart';
import 'message_manager.dart';

class ChatMessageSyncService {
  final MessageManager manager;
  final ChatSearchService searchService;
  final String Function() getMyName;

  ChatMessageSyncService({
    required this.manager,
    required this.searchService,
    required this.getMyName,
  });

  void handleIncomingMessage({
    required Map<String, dynamic> data,
    required String? chatId,
    required Function(MessageModel) updateUI,
    required MessageModel currentModel,
  }) {
    final sender = data["sender"] ?? '';
    final message = data["message"] ?? '';
    final incomingChatId = data["chatId"] ?? '';

    if (incomingChatId.isNotEmpty && incomingChatId != chatId) return;

    final normalizedSender = sender.trim().toLowerCase();
    final normalizedMe = getMyName().trim().toLowerCase();

    if (normalizedSender == normalizedMe) return;

    final exists = manager.allMessages.any((m) =>
    (m.content ?? '') == message &&
        (m.senderName ?? '') == sender);

    if (exists) return;

    final newMessage = MessageItem(
      senderName: sender,
      content: message,
      createAt: DateTime.now().toString(),
    );

    manager.addMessage(newMessage);
    searchService.setMessages(manager.allMessages);

    currentModel.data?.items = List.from(manager.allMessages);

    updateUI(currentModel);
  }
}