class ChatArgsModel {
  final String? chatId;
  final String userId;
  final String name;
  final String? avatar;
  final int chatType; // 0 = private, 1/2 = group
  final int? membersCount;
  final bool isPinned;
  final void Function(String newChatId)? onChatCreated;

  ChatArgsModel({
    required this.chatId,
    required this.userId,
    required this.name,
    this.avatar,
    this.chatType = 0,
    this.membersCount,
    this.isPinned = false,
    this.onChatCreated,
  });

  bool get isGroup => chatType == 1 || chatType == 2;
}
