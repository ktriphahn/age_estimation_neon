import 'package:age_estimation_neon/repositories/estimation_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../model/user.dart';

part 'estimation_event.dart';
part 'estimation_state.dart';

class EstimationBloc extends Bloc<EstimationEvent, EstimationState> {
  final EstimationRepository estimationRepository;

  EstimationBloc({required this.estimationRepository})
      : super(EstimationInitial()) {
    on<GetUserData>(
      (event, emit) async {
        emit(EstimationFetching());
        await Future.delayed(const Duration(milliseconds: 200));
        try {
          print('Event Name ist : $event.name');
          User userData =
              await estimationRepository.getEstimationForUser(name: event.name);
          emit(EstimationFetched(userData));
        } catch (e) {
          print(e);
          emit(EstimationError(e.toString()));
        }
      },
    );
    on<Reset>(
      (event, emit) {
        emit(EstimationInitial());
      },
    );
  }
}
