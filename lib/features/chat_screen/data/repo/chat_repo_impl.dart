import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:graduation_project/core/api/end_points.dart';
import 'package:graduation_project/features/chat_screen/data/model/chat_model.dart';
import 'package:graduation_project/features/chat_screen/data/repo/chat_repo.dart';

class ChatRepoImpl implements ChatRepo {
  final Dio dio;
  ChatRepoImpl(this.dio);

  @override
  Future<Either<String, ChatModel>> getMyChats() async {
    try {
      final response = await dio.get(EndPoints.myChats);
      final chatModel = ChatModel.fromJson(response.data);
      return Right(chatModel);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, bool>> togglePin(String chatId) async {
    try {
      await dio.post(EndPoints.togglePin(chatId));
      return const Right(true);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, bool>> clearChat(String chatId) async {
    try {
      await dio.post(EndPoints.clearChat(chatId));
      return const Right(true);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
