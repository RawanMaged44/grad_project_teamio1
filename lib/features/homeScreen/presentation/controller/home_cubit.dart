import 'package:bloc/bloc.dart';
import 'package:graduation_project/features/homeScreen/data/model/team_model.dart';
import 'package:meta/meta.dart';
import '../../data/repo/home_rebo.dart';
part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeRepo homeRepo;
  String? teamId;

  HomeCubit({required this.homeRepo}) : super(HomeInitialState());

  void getMyTeam({bool silent = false}) async {
    if (!silent) emit(HomeLoadingState());
    final result = await homeRepo.getMyTeam();
    result.fold(
      (error) => emit(HomeErrorState(errorMessage: error)),
      (team) {
        teamId = team.data?.teamId;
        emit(HomeSuccessState(team: team));
      },
    );
  }
}