class EndPoints {
  static const String login = '/Auth/login';
  static const String refreshToken = '/Auth/refresh-token';
  static const String myTeam = '/Teams/my-team';
  static const String myChats = '/chats/my-chats';
  static String chatMessages(String chatId) => '/Chats/$chatId/messages';
  static String createPrivateChat(String userId) => '/Chats/private/$userId';
  static String togglePin(String chatId) => '/Chats/toggle-pin/$chatId';
  static String clearChat(String chatId) => '/Chats/clear/$chatId';
  static const String myTasks = "/PersonalTask";
  static const String createTask = "/PersonalTask";
  static String deleteTask(String id) => '/PersonalTask/$id';
  static String getTaskById(String id) => '/PersonalTask/$id';
  static String updateTask(String id) => '/PersonalTask/$id';
  static String completeTask(String id) => '/PersonalTask/compete/$id';
  static const String myProfile = "/User/my-profile";
  static const String updateStudentProfile = "/User/student/profile";

  // Notifications — base: /api/notifications (not /api/V1)
  static const String registerFcmToken = '/notifications/register-token';
  static const String getNotifications = '/notifications';
  static const String getUnreadCount = '/notifications/unread-count';
  static String markNotificationRead(String id) => '/notifications/read/$id';
}