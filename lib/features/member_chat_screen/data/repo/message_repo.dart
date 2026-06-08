import 'package:dartz/dartz.dart';
import '../model/message_model.dart';

abstract class MessageRepo {
  Future<Either<String, MessageModel>> getMessages(String chatId,
      {int page = 1, int pageSize = 20});

  Future<Either<String, String>> createPrivateChat(String userId, String content);
}