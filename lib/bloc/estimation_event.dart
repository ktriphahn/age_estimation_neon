part of 'estimation_bloc.dart';

@immutable
sealed class EstimationEvent {}

class GetUserData extends EstimationEvent {
  final String name;

  GetUserData(this.name);
}

class Reset extends EstimationEvent {}
