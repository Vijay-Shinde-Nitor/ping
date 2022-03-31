import 'package:dart_ping/dart_ping.dart';

abstract class PingRepository {
  Future<Stream<PingData>> startPingProcess();
}

class PingRepoImpl extends PingRepository {
  Ping? ping;

  @override
  Future<Stream<PingData>> startPingProcess() async {
    ping?.stop();
    ping = Ping('google.com', count: 5);
    return ping!.stream;
  }
}
