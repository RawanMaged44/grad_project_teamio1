import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../../data/model/profile_model.dart';
import '../../../data/repo/profile_repo.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileRepo profileRepo;

  ProfileCubit(this.profileRepo) : super(ProfileInitial());

  Future<void> getMyProfile() async {
    emit(ProfileLoading());
    final result = await profileRepo.getMyProfile();
    result.fold(
      (error) => emit(ProfileError(error)),
      (data) => emit(ProfileSuccess(data)),
    );
  }
}
