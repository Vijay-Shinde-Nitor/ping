import 'package:bloc_test/bloc_test.dart';
import 'package:dart_ping/dart_ping.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:nitor_ping/data/ping_repository.dart';
import 'package:nitor_ping/presentation/bloc/ping_bloc.dart';
import 'package:nitor_ping/presentation/bloc/ping_event.dart';
import 'package:nitor_ping/presentation/bloc/ping_state.dart';

import 'ping_bloc_test.mocks.dart';

class FakePingBloc extends MockBloc<PingEvent, PingState> implements PingBloc {}

@GenerateMocks([PingRepoImpl])
void main() {
  final FakePingBloc mockPingBloc = FakePingBloc();
  final Ping mockPing = Ping('google.com', count: 1);
  final states = [PingInitState(), PingingState(mockPing.stream)];
  final MockPingRepoImpl mockPingRepoImpl = MockPingRepoImpl();
  setUp(() {
    when(mockPingRepoImpl.startPingProcess(host: 'google.com', count: 5))
        .thenAnswer((realInvocation) async {
      return mockPing.stream;
    });
  });

  group('Ping Class Tests', () {
    test('ping emits stream of PingData', () {
      expect(Ping('google.com', count: 1).stream, emits(isA<PingData>()));
    });

    test('ping emits PingData 5 times', () {
      expect(
          Ping('google.com', count: 5).stream,
          emitsInOrder([
            isA<PingData>(),
            isA<PingData>(),
            isA<PingData>(),
            isA<PingData>(),
            isA<PingData>()
          ]));
    });
  });

  group('Bloc Tests', () {
    test('check bloc emits states in order', () {
      whenListen(mockPingBloc, Stream.fromIterable(states));
      expectLater(mockPingBloc.stream, emitsInOrder(states));
    });

    blocTest<PingBloc, PingState>(
        'When no event is added then no state is emitted',
        build: () => PingBloc(repository: mockPingRepoImpl),
        expect: () => <PingState>[]);

    blocTest<PingBloc, PingState>(
        'When button pressed and ping event is added then verify repository method is called',
        build: () => PingBloc(repository: mockPingRepoImpl),
        act: (bloc) => bloc.add(PingPressedEvent()),
        verify: (bloc) => mockPingRepoImpl.startPingProcess);

    blocTest<PingBloc, PingState>(
      'When button pressed and ping event is added then Pinging State is emitted',
      build: () => PingBloc(repository: mockPingRepoImpl),
      act: (bloc) => bloc.add(PingPressedEvent()),
      expect: () => <PingState>[PingingState(mockPing.stream)],
    );
  });
}
