part of 'profile_cubit.dart';

@immutable
sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileSuccess extends ProfileState {
  final Data profile;
  ProfileSuccess(this.profile);
}

class ProfileError extends ProfileState {
  final String message;
  ProfileError(this.message);
}
