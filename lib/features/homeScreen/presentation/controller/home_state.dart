part of 'home_cubit.dart';

@immutable
sealed class HomeState {}

final class HomeInitialState extends HomeState {}

final class HomeLoadingState extends HomeState {}

final class HomeSuccessState extends HomeState {
  final TeamModel team;
  HomeSuccessState({required this.team});
}

final class HomeErrorState extends HomeState {
  final String errorMessage;
  HomeErrorState({required this.errorMessage});
}




