import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nitor_ping/presentation/bloc/ping_event.dart';
import 'package:nitor_ping/presentation/bloc/ping_state.dart';

class PingBloc extends Bloc<PingEvent, PingState> {
  PingBloc() : super(PingInitState()) {
    on<PingPressedEvent>((event, emit) async {
      emit(PingingState(event.ping));
    });
  }
}
