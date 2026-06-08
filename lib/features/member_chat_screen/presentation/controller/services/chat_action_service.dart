import '../../../data/repo/message_repo.dart';
import 'chat_real_time_service.dart';

class ChatActionService {
  final MessageRepo repo;
  final ChatRealtimeService realtimeService;

  ChatActionService(this.repo, this.realtimeService);

  Future<String?> handleSendMessage({
    required String? chatId,
    required String userId,
    required String content,
  }) async {
    if (chatId != null) {
      try {
        await realtimeService.sendMessage(chatId, content);
      } catch (e) {}
      return chatId;
    }

    if (userId.isEmpty) return null;

    final result = await repo.createPrivateChat(userId, content);

    return result.fold(
      (l) => null,
      (r) async {
        try {
          await realtimeService.sendMessage(r, content);
        } catch (e) {}
        return r;
      },
    );
  }
}