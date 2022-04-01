import 'package:dart_ping/dart_ping.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nitor_ping/data/ping_repository.dart';
import 'package:nitor_ping/presentation/bloc/ping_event.dart';
import 'package:nitor_ping/presentation/bloc/ping_state.dart';

class PingBloc extends Bloc<PingEvent, PingState> {
  final PingRepository repository;

  PingBloc({required this.repository}) : super(PingInitState()) {
    on<PingPressedEvent>((event, emit) async {
      Stream<PingData> ping =
          await repository.startPingProcess(host: 'google.com', count: 5);
      emit(PingingState(ping));
    });
  }
}
