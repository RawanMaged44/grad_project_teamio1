import 'package:shared_preferences/shared_preferences.dart';

class StorageHelper {
  static const accessTokenKey = 'ACCESS_TOKEN';
  static const refreshTokenKey = 'REFRESH_TOKEN';
  static const userNameKey = 'USER_NAME';

  static Future<void> saveTokens({
    required String accessToken,
    required String refreshToken,
    required String userName,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(accessTokenKey, accessToken);
    await prefs.setString(refreshTokenKey, refreshToken);
    await prefs.setString(userNameKey, userName);
  }

  static Future<String?> getAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(accessTokenKey);
  }

  static Future<String?> getRefreshToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(refreshTokenKey);
  }

  static Future<String?> getUserName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(userNameKey);
  }

  static Future<void> clearTokens() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(accessTokenKey);
    await prefs.remove(refreshTokenKey);
    await prefs.remove(userNameKey);
  }

  // ─── Cleared Chats ───────────────────────────────────────────────
  // Stores the timestamp (ms) when each chat was cleared.
  // Messages sent BEFORE this timestamp are hidden; newer ones show normally.
  static const _clearedChatsKey = 'CLEARED_CHATS_TIMESTAMP';

  static Future<void> markChatAsCleared(String chatId) async {
    final prefs = await SharedPreferences.getInstance();
    final map = _decodeMap(prefs.getString(_clearedChatsKey));
    map[chatId] = DateTime.now().millisecondsSinceEpoch.toString();
    await prefs.setString(_clearedChatsKey, _encodeMap(map));
  }

  /// Returns the DateTime when the chat was cleared, or null if never cleared.
  static Future<DateTime?> getChatClearedAt(String chatId) async {
    final prefs = await SharedPreferences.getInstance();
    final map = _decodeMap(prefs.getString(_clearedChatsKey));
    final ts = map[chatId];
    if (ts == null) return null;
    return DateTime.fromMillisecondsSinceEpoch(int.parse(ts));
  }

  static Future<void> unmarkChatAsCleared(String chatId) async {
    final prefs = await SharedPreferences.getInstance();
    final map = _decodeMap(prefs.getString(_clearedChatsKey));
    map.remove(chatId);
    await prefs.setString(_clearedChatsKey, _encodeMap(map));
  }

  static Map<String, String> _decodeMap(String? raw) {
    if (raw == null || raw.isEmpty) return {};
    final map = <String, String>{};
    for (final entry in raw.split('||')) {
      final parts = entry.split('::');
      if (parts.length == 2) map[parts[0]] = parts[1];
    }
    return map;
  }

  static String _encodeMap(Map<String, String> map) =>
      map.entries.map((e) => '${e.key}::${e.value}').join('||');

  // ─── Member Chat IDs ─────────────────────────────────────────────
  // Persists chatId per member so it survives widget rebuilds
  static const _memberChatIdsKey = 'MEMBER_CHAT_IDS';

  static Future<void> saveMemberChatId({
    required String memberId,
    required String chatId,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final map = _decodeMap(prefs.getString(_memberChatIdsKey));
    map[memberId] = chatId;
    await prefs.setString(_memberChatIdsKey, _encodeMap(map));
  }

  static Future<String?> getMemberChatId(String memberId) async {
    final prefs = await SharedPreferences.getInstance();
    final map = _decodeMap(prefs.getString(_memberChatIdsKey));
    return map[memberId];
  }
}
