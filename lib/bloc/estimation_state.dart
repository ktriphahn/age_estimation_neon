part of 'estimation_bloc.dart';

@immutable
sealed class EstimationState {}

final class EstimationInitial extends EstimationState {}

final class EstimationFetching extends EstimationState {}

final class EstimationFetched extends EstimationState {
  final User user;

  EstimationFetched(this.user);
}

final class EstimationError extends EstimationState {
  final String error;

  EstimationError(this.error);
}
