part of 'chat_cubit.dart';

@immutable
sealed class ChatState {}

final class ChatInitialState extends ChatState {}
final class ChatLoadingState extends ChatState {}
final class ChatSuccessState extends ChatState {
  final ChatModel chatModel;
  ChatSuccessState({required this.chatModel});
}
final class ChatErrorState extends ChatState {
  final String errorMessage;
  ChatErrorState({required this.errorMessage});
}
