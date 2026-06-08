part of 'member_chat_cubit.dart';


@immutable
sealed class MemberChatState {}

final class MemberChatInitialState extends MemberChatState {}
final class MemberChatLoadingState extends MemberChatState {}
final class MemberChatSuccessState extends MemberChatState {
  final MessageModel messageModel;
  final String myName;
  final String? newlyCreatedChatId; // set once when a new chat is created
  MemberChatSuccessState({
    required this.messageModel,
    required this.myName,
    this.newlyCreatedChatId,
  });
}
final class MemberChatErrorState extends MemberChatState {
  final String errorMessage;
  MemberChatErrorState({required this.errorMessage});
}

