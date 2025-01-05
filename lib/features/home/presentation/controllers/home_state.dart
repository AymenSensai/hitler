sealed class HomeState<T> {}

class HomeInitial<T> extends HomeState<T> {}

class GetDashboardDataLoading<T> extends HomeState<T> {}

class GetDashboardDataSuccess<T> extends HomeState<T> {
  final T dashboard;

  GetDashboardDataSuccess({required this.dashboard});
}

class GetDashboardDataError<T> extends HomeState<T> {
  final String? error;

  GetDashboardDataError({required this.error});
}
