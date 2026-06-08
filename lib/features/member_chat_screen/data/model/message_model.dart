class MessageModel {
  MessageModel({
    this.success,
    this.data,
    this.errors,
    this.statusCode,
  });

  MessageModel.fromJson(dynamic json) {
    success = json['success'];
    data = json['data'] != null ? MessageData.fromJson(json['data']) : null;
    errors = json['errors'];
    statusCode = json['statusCode'];
  }

  bool? success;
  MessageData? data;
  dynamic errors;
  int? statusCode;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    map['errors'] = errors;
    map['statusCode'] = statusCode;
    return map;
  }
}

class MessageData {
  MessageData({
    this.items,
    this.totalCount,
    this.pageNumber,
    this.pageSize,
  });

  MessageData.fromJson(dynamic json) {
    if (json['items'] != null) {
      items = [];
      json['items'].forEach((v) {
        items?.add(MessageItem.fromJson(v));
      });
    }
    totalCount = json['totalCount'];
    pageNumber = json['pageNumber'];
    pageSize = json['pageSize'];
  }

  List<MessageItem>? items;
  int? totalCount;
  int? pageNumber;
  int? pageSize;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (items != null) {
      map['items'] = items?.map((v) => v.toJson()).toList();
    }
    map['totalCount'] = totalCount;
    map['pageNumber'] = pageNumber;
    map['pageSize'] = pageSize;
    return map;
  }
}

class MessageItem {
  MessageItem({
    this.senderName,
    this.content,
    this.createAt,
    this.avatarUrl,
    this.fileUrl,
    this.isOwner,
  });

  MessageItem.fromJson(dynamic json) {
    senderName = json['senderName'];
    content = json['content'];
    createAt = json['createAt'];
    avatarUrl = json['avaterUrl'];
    fileUrl = json['fileUrl'];
    isOwner = json['isOwener'];
  }

  String? senderName;
  String? content;
  String? createAt;
  dynamic avatarUrl;
  dynamic fileUrl;
  bool? isOwner;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['senderName'] = senderName;
    map['content'] = content;
    map['createAt'] = createAt;
    map['avaterUrl'] = avatarUrl;
    map['fileUrl'] = fileUrl;
    map['isOwener'] = isOwner;
    return map;
  }
}

extension MessageModelExtension on MessageModel {
  List<MessageItem> get messages => data?.items ?? [];
}