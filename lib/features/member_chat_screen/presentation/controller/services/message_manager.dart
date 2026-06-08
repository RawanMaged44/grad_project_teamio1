import '../../../data/model/message_model.dart';

class MessageManager {
  List<MessageItem> allMessages = [];

  void setMessages(List<MessageItem> messages) {
    allMessages = List.from(messages);
  }

  void addMessage(MessageItem message) {
    allMessages.insert(0, message);
  }

  void appendOldMessages(List<MessageItem> messages) {
    allMessages.addAll(messages);
  }
}