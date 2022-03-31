
import 'package:dart_ping/dart_ping.dart';
import 'package:equatable/equatable.dart';

abstract class PingState extends Equatable {}

class PingInitState extends PingState {
  @override
  List<Object?> get props => [];
}

class PingingState extends PingState {
  final Ping ping;
  PingingState(this.ping);

  @override
  List<Object?> get props => [ping];
}
