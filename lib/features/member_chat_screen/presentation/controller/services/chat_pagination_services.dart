class ChatPaginationService {
  int currentPage = 1;
  bool hasMore = true;
  bool isLoading = false;

  bool canLoadMore(String? chatId) {
    return chatId != null && hasMore && !isLoading;
  }

  int nextPage() {
    return currentPage + 1;
  }

  void onSuccess(int page, int newItemsCount) {
    currentPage = page;
    hasMore = newItemsCount >= 20;
    isLoading = false;
  }

  void onEmpty() {
    hasMore = false;
    isLoading = false;
  }

  void startLoading() {
    isLoading = true;
  }

  void reset() {
    currentPage = 1;
    hasMore = true;
    isLoading = false;
  }
}
