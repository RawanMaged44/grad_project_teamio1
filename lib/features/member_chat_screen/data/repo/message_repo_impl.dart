import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/core/api/end_points.dart';
import '../model/message_model.dart';
import 'message_repo.dart';

class MessageRepoImpl implements MessageRepo {
  final Dio dio;
  MessageRepoImpl(this.dio);

  @override
  Future<Either<String, MessageModel>> getMessages(
      String chatId, {
        int page = 1,
        int pageSize = 20,
      }) async {
    try {
      final response = await dio.get(
        EndPoints.chatMessages(chatId),
        queryParameters: {
          'PageNumber': page,
          'PageSize': pageSize,
        },
      );
      final messageModel = MessageModel.fromJson(response.data);
      return Right(messageModel);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, String>> createPrivateChat(String userId, String content) async {
    try {
      final formData = FormData.fromMap({
        'Content': content,
      });
      final response = await dio.post(
        EndPoints.createPrivateChat(userId),
        data: formData,
      );
      final data = response.data;      // Handle both possible response shapes
      String? chatId;
      if (data['data'] is Map) {
        chatId = data['data']['chatId']?.toString();
      } else if (data['data'] is String) {
        chatId = data['data'];
      } else if (data['chatId'] != null) {
        chatId = data['chatId']?.toString();
      }
      if (chatId != null && chatId.isNotEmpty) {
        return Right(chatId);
      }
      return Left('chatId not found in response: $data');
    } catch (e) {
      return Left(e.toString());
    }
  }
}