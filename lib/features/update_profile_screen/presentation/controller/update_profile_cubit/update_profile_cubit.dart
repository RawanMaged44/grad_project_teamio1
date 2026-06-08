import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../../data/repo/update_profile_repo.dart';
part 'update_profile_state.dart';

class UpdateProfileCubit extends Cubit<UpdateProfileState> {
  final UpdateProfileRepo updateProfileRepo;

  UpdateProfileCubit(this.updateProfileRepo) : super(UpdateProfileInitial());

  Future<void> updateStudentProfile({
    required String desiredRole,
    required String email,
    required String phoneNumber,
    File? avatar,
    String? currentAvatarUrl,
  }) async {
    emit(UpdateProfileLoading());
    final result = await updateProfileRepo.updateStudentProfile(
      desiredRole: desiredRole,
      email: email,
      phoneNumber: phoneNumber,
      avatar: avatar,
      currentAvatarUrl: currentAvatarUrl,
    );
    result.fold(
      (error) => emit(UpdateProfileError(error)),
      (message) => emit(UpdateProfileSuccess(message)),
    );
  }
}
