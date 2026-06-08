class EndPoints {
  static const String login = '/Auth/login';
  static const String refreshToken = '/Auth/refresh-token';
  static const String myTeam = '/Teams/my-team';
  static const String myChats = '/chats/my-chats';
  static String chatMessages(String chatId) => '/Chats/$chatId/messages';
  static String createPrivateChat(String userId) => '/Chats/private/$userId';
  static String togglePin(String chatId) => '/Chats/toggle-pin/$chatId';
  static const String myTasks = "/personal-tasks";
  static const String createTask = "/personal-tasks";
  static String deleteTask(String id) => '/personal-tasks/$id';
  static String getTaskById(String id) => '/personal-tasks/$id';
  static const String myProfile = "/User/my-profile";
  static const String updateStudentProfile = "/User/student/profile";
}