import 'dart:async';
import 'package:signalr_core/signalr_core.dart';

class ChatSignalRService {
  HubConnection? connection;
  String? _currentChatId;

  final StreamController<Map<String, String>> _messageController =
  StreamController.broadcast();

  Stream<Map<String, String>> get messagesStream =>
      _messageController.stream;

  Future<void> connect(String token) async {
    connection = HubConnectionBuilder()
        .withUrl(
      'https://teamio.runasp.net/hubs/chat',
      HttpConnectionOptions(
        accessTokenFactory: () async => token,
      ),
    )
        .withAutomaticReconnect()
        .build();

    connection!.onreconnected((_) async {
      if (_currentChatId != null) {
        await joinChat(_currentChatId!);
      }
      _registerMessageHandler();
    });

    await connection!.start();
    _registerMessageHandler();
  }

  Future<void> joinChat(String chatId) async {
    _currentChatId = chatId.toLowerCase();
    if (connection?.state == HubConnectionState.connected) {
      await connection?.invoke('JoinChat', args: [_currentChatId]);
    }
  }

  Future<void> sendMessage(String chatId, String content) async {
    if (connection?.state == HubConnectionState.connected) {
      await connection?.invoke(
        'SendMessage',
        args: [
          chatId,
          {"content": content}
        ],
      );
    } else {
      throw Exception("SignalR Connection lost!");
    }
  }

  void _registerMessageHandler() {
    connection?.off('ReceiveMessage');
    connection?.on('ReceiveMessage', (args) {
      final sender = args?[0]?.toString() ?? '';
      final message = args?[1]?.toString() ?? '';
      final chatId = args?[2]?.toString() ?? '';

      _messageController.add({
        "sender": sender,
        "message": message,
        "chatId": chatId,
      });
    });
  }

  Future<void> disconnect() async {
    _currentChatId = null;
    await connection?.stop();
    await _messageController.close();
  }
}