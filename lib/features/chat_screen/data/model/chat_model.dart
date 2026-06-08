class ChatModel {
  ChatModel({
      this.success, 
      this.data, 
      this.errors, 
      this.statusCode,});

  ChatModel.fromJson(dynamic json) {
    success = json['success'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(ChatsData.fromJson(v));
      });
    }
    errors = json['errors'];
    statusCode = json['statusCode'];
  }
  bool? success;
  List<ChatsData>? data;
  dynamic errors;
  int? statusCode;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    map['errors'] = errors;
    map['statusCode'] = statusCode;
    return map;
  }
}

class ChatsData {
  ChatsData({
      this.chatId,
      this.name,
      this.lastMessageContent,
      this.lastMessageData,
      this.unreadCount,
      this.chatType,
      this.isPinned,});

  ChatsData.fromJson(dynamic json) {
    chatId = json['chatId'];
    name = json['name'];
    lastMessageContent = json['lastMessageContent'];
    lastMessageData = json['lastMessageData'];
    unreadCount = json['unreadCount'];
    chatType = json['chatType'];
    isPinned = json['isPinned'] ?? false;
    membersCount = json['membersCount'];
  }
  String? chatId;
  String? name;
  String? lastMessageContent;
  String? lastMessageData;
  int? unreadCount;
  int? chatType;
  bool? isPinned;
  int? membersCount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['chatId'] = chatId;
    map['name'] = name;
    map['lastMessageContent'] = lastMessageContent;
    map['lastMessageData'] = lastMessageData;
    map['unreadCount'] = unreadCount;
    map['chatType'] = chatType;
    map['isPinned'] = isPinned;
    return map;
  }
}
