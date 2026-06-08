import '../../../data/model/message_model.dart';

class ChatSearchService {
  List<MessageItem> _allMessages = [];
  List<MessageItem> filteredMessages = [];

  String _lastQuery = '';
  int currentIndex = -1;

  void setMessages(List<MessageItem> messages) {
    _allMessages = List.from(messages);
    // Re-apply active search if there is one
    if (_lastQuery.isNotEmpty) {
      _applyFilter(_lastQuery);
    } else {
      filteredMessages = [];
      currentIndex = -1;
    }
  }

  void search(String query) {
    _lastQuery = query.trim().toLowerCase();
    _applyFilter(_lastQuery);
  }

  void _applyFilter(String q) {
    if (q.isEmpty) {
      filteredMessages = [];
      currentIndex = -1;
      return;
    }

    filteredMessages = _allMessages
        .where((m) => (m.content ?? '').toLowerCase().contains(q))
        .toList();

    currentIndex = filteredMessages.isNotEmpty ? 0 : -1;
  }

  void next() {
    if (filteredMessages.isEmpty) return;
    currentIndex = (currentIndex + 1) % filteredMessages.length;
  }

  void previous() {
    if (filteredMessages.isEmpty) return;
    currentIndex = (currentIndex - 1 + filteredMessages.length) % filteredMessages.length;
  }

  int getCurrentGlobalIndex() {
    if (currentIndex < 0 || filteredMessages.isEmpty) return -1;
    final current = filteredMessages[currentIndex];
    return _allMessages.indexOf(current);
  }

  int get filteredCount => filteredMessages.length;
}
