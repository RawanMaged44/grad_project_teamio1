import 'dart:async';
import '../../../../../core/functions/chat_signalr_service.dart';

class ChatRealtimeService {
  final ChatSignalRService signalR;
  StreamSubscription? _subscription;

  ChatRealtimeService(this.signalR);

  Future<void> connectAndListen({
    required String token,
    required String chatId,
    required Function(Map<String, dynamic>) onMessage,
  }) async {
    await _subscription?.cancel();

    await signalR.connect(token);
    await signalR.joinChat(chatId);

    _subscription = signalR.messagesStream.listen((data) {
      onMessage(data);
    });
  }

  Future<void> sendMessage(String chatId, String message) async {
    await signalR.sendMessage(chatId, message);
  }

  Future<void> disconnect() async {
    await _subscription?.cancel();
    await signalR.disconnect();
  }
}