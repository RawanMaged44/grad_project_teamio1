import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../features/login_screen/data/repo/login_repo.dart';
import '../functions/storage_helper.dart';
import '../utils/app_routes.dart';
import 'api_constants.dart';

class DioHelper {
  static final Dio dio = Dio(
    BaseOptions(
      baseUrl: ApiConstants.baseUrl,
      receiveDataWhenStatusError: true,
      connectTimeout: const Duration(seconds: 20),
      receiveTimeout: const Duration(seconds: 20),
      // Accept all status codes < 500 so 404 is handled in code, not thrown as exception
      validateStatus: (status) => status != null && status < 500,
    ),
  );

  static void _navigateToLogin(GlobalKey<NavigatorState>? key) {
    key?.currentState?.pushNamedAndRemoveUntil(
      AppRoute.loginRoute,
      (route) => false,
    );
  }

  static void init(LoginRepo loginRepo, {GlobalKey<NavigatorState>? navigatorKey}) {
    dio.interceptors.clear();
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await StorageHelper.getAccessToken();
          if (token != null && token.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          return handler.next(options);
        },
        onResponse: (response, handler) async {
          // Handle 401 at response level (since validateStatus accepts it now)
          if (response.statusCode == 401) {
            debugPrint('DioHelper: Got 401 response, trying refresh token...');
            final refreshToken = await StorageHelper.getRefreshToken();
            if (refreshToken != null && refreshToken.isNotEmpty) {
              final responseEither = await loginRepo.refreshToken(refreshToken: refreshToken);
              bool handled = false;
              await responseEither.fold(
                (error) async {
                  debugPrint('DioHelper: Refresh token failed: $error');
                  await StorageHelper.clearTokens();
                  _navigateToLogin(navigatorKey);
                  handler.next(response);
                  handled = true;
                },
                (refreshResponse) async {
                  final newToken = refreshResponse['data']?['token'];
                  final newRefreshToken = refreshResponse['data']?['refreshToken'];
                  if (newToken != null && newRefreshToken != null) {
                    final oldUserName = await StorageHelper.getUserName();
                    await StorageHelper.saveTokens(
                      accessToken: newToken,
                      refreshToken: newRefreshToken,
                      userName: oldUserName ?? '',
                    );
                    final requestOptions = response.requestOptions;
                    requestOptions.headers['Authorization'] = 'Bearer $newToken';
                    final retryResponse = await dio.fetch(requestOptions);
                    handler.resolve(retryResponse);
                    handled = true;
                  } else {
                    await StorageHelper.clearTokens();
                    _navigateToLogin(navigatorKey);
                    handler.next(response);
                    handled = true;
                  }
                },
              );
              if (handled) return;
            } else {
              await StorageHelper.clearTokens();
              _navigateToLogin(navigatorKey);
            }
          }
          return handler.next(response);
        },
        onError: (e, handler) async {
          debugPrint('DioHelper ERROR: ${e.response?.statusCode} - ${e.requestOptions.path}');

          if (e.requestOptions.path.contains('/Auth/refresh-token')) {
            debugPrint('DioHelper: Refresh token endpoint failed, clearing tokens');
            await StorageHelper.clearTokens();
            _navigateToLogin(navigatorKey);
            return handler.next(e);
          }

          if (e.response?.statusCode == 401) {
            debugPrint('DioHelper: Got 401, trying refresh token...');
            final refreshToken = await StorageHelper.getRefreshToken();
            if (refreshToken != null && refreshToken.isNotEmpty) {
              final responseEither = await loginRepo.refreshToken(refreshToken: refreshToken);
              bool handled = false;
              await responseEither.fold(
                (error) async {
                  debugPrint('DioHelper: Refresh token failed: $error');
                  await StorageHelper.clearTokens();
                  _navigateToLogin(navigatorKey);
                  handler.next(e);
                  handled = true;
                },
                (response) async {
                  final newToken = response['data']?['token'];
                  final newRefreshToken = response['data']?['refreshToken'];
                  debugPrint('DioHelper: New token received: ${newToken != null}');
                  if (newToken != null && newRefreshToken != null) {
                    final oldUserName = await StorageHelper.getUserName();
                    await StorageHelper.saveTokens(
                      accessToken: newToken,
                      refreshToken: newRefreshToken,
                      userName: oldUserName ?? '',
                    );
                    final requestOptions = e.requestOptions;
                    requestOptions.headers['Authorization'] = 'Bearer $newToken';
                    final retryResponse = await dio.fetch(requestOptions);
                    handler.resolve(retryResponse);
                    handled = true;
                  } else {
                    debugPrint('DioHelper: Token fields missing in response: $response');
                    await StorageHelper.clearTokens();
                    _navigateToLogin(navigatorKey);
                    handler.next(e);
                    handled = true;
                  }
                },
              );
              if (handled) return;
            } else {
              debugPrint('DioHelper: No refresh token stored');
              await StorageHelper.clearTokens();
              _navigateToLogin(navigatorKey);
              return handler.next(e);
            }
          }
          return handler.next(e);
        },
      ),
    );
  }
}
