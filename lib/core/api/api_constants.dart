class ApiConstants {
  static const String baseUrl = 'https://teamio.runasp.net/api/V1';
  static const String baseUrlV2 = 'https://teamio.runasp.net/api';
  static const String imageBaseUrl = 'https://teamio.runasp.net';

  /// Converts a relative avatar path like /avatars/file.png to a full URL
  static String? buildImageUrl(String? path) {
    if (path == null || path.isEmpty) return null;
    if (path.startsWith('http')) return path; // already full URL
    return '$imageBaseUrl$path';
  }
}
