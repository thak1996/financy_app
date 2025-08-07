sealed class StatsState {}

class StatsInitial extends StatsState {}

class StatsLoading extends StatsState {}

class StatsSuccess extends StatsState {}

class StatsError extends StatsState {
  StatsError({required this.message});

  final String message;
}
