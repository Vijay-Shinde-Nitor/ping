import 'package:bloc_test/bloc_test.dart';
import 'package:dart_ping/dart_ping.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:nitor_ping/presentation/bloc/ping_bloc.dart';
import 'package:nitor_ping/presentation/bloc/ping_event.dart';
import 'package:nitor_ping/presentation/bloc/ping_state.dart';

import 'ping_bloc_test.mocks.dart';

class FakePingBloc extends MockBloc<PingEvent, PingState> implements PingBloc {}

@GenerateMocks([Ping, PingBloc])
void main() {
  final FakePingBloc mockPingBloc = FakePingBloc();
  final MockPing mockPing = MockPing();
  final states = [PingInitState(), PingingState(mockPing)];

  test('check block emits states in order', () {
    whenListen(mockPingBloc, Stream.fromIterable(states));
    expectLater(mockPingBloc.stream, emitsInOrder(states));
  });

  blocTest<PingBloc, PingState>(
      'When no event is added then no state is emitted',
      build: () => PingBloc(),
      expect: () => const <PingState>[]);

  blocTest<PingBloc, PingState>(
      'When button pressed and ping event is added then Pinging State is emitted',
      build: () => PingBloc(),
      act: (bloc) => bloc.add(PingPressedEvent(mockPing)),
      expect: () => <PingState>[PingingState(mockPing)]);
}