import 'package:equatable/equatable.dart';

abstract class PingEvent extends Equatable {}

class PingPressedEvent extends PingEvent {
  @override
  List<Object?> get props => [];
}
