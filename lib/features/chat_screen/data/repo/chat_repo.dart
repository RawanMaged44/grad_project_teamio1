import 'package:dartz/dartz.dart';

import '../model/chat_model.dart';

abstract class ChatRepo {
  Future<Either<String, ChatModel>> getMyChats();
  Future<Either<String, bool>> togglePin(String chatId);
  Future<Either<String, bool>> clearChat(String chatId);
}