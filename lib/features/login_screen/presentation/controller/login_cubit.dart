import 'package:bloc/bloc.dart';
import '../../data/repo/login_repo.dart';
import '../../../../core/functions/storage_helper.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginRepo loginRepo;

  LoginCubit(this.loginRepo) : super(LoginInitialState());

  Future<void> loginUser({
    required String nationalId,
    required String password,
  }) async {
    emit(LoginLoadingState());
    final result =
    await loginRepo.login(nationalId: nationalId, password: password);
    result.fold(
          (error) => emit(LoginErrorState(error)),
          (response) async {
        final success = response['success'] ?? false;
        final data = response['data'];
        final errors = response['errors'] as List<dynamic>?;

        if (success && data != null) {
          await saveTokensAndEmit(data);
        } else {
          final errorMessage = (errors != null && errors.isNotEmpty)
              ? errors[0]
              : 'Login failed';
          emit(LoginErrorState(errorMessage));
        }
      },
    );
  }

  Future<void> refreshToken() async {
    final currentRefreshToken = await StorageHelper.getRefreshToken();
    if (currentRefreshToken == null) {
      emit(LoginErrorState('No refresh token found'));
      return;
    }

    final result =
    await loginRepo.refreshToken(refreshToken: currentRefreshToken);
    result.fold(
          (error) => emit(LoginErrorState(error)),
          (response) async {
        final success = response['success'] ?? false;
        final data = response['data'];

        if (success && data != null) {
          await saveTokensAndEmit(data);
        } else {
          emit(LoginErrorState('Failed to refresh token'));
        }
      },
    );
  }

  Future<void> saveTokensAndEmit(Map<String, dynamic> data) async {
    final token = data['token'] ?? '';
    final refreshToken = data['refreshToken'] ?? '';
    final userName = data['userName'] ?? '';
    await StorageHelper.saveTokens(
      accessToken: token,
      refreshToken: refreshToken,
      userName: userName,
    );
    emit(LoginSuccessState(token, refreshToken, userName));
  }
}