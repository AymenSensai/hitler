import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stocks_app/features/home/domain/repo/home_repo.dart';

import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this._homeRepo) : super(HomeInitial());

  final HomeRepo _homeRepo;

  Future<void> getDashboardData() async {
    emit(GetDashboardDataLoading());
    final response = await _homeRepo.getDashboardData();
    response.when(
      success: (response) {
        emit(GetDashboardDataSuccess(dashboard: response));
      },
      failure: (error) {
        emit(GetDashboardDataError(error: error));
      },
    );
  }
}
