
import 'package:dart_ping/dart_ping.dart';

abstract class PingEvent {}

class PingPressedEvent extends PingEvent {
  Ping ping;
  PingPressedEvent(this.ping);
}
