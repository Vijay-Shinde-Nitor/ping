import 'package:dart_ping/dart_ping.dart';

abstract class PingRepository {
  Future<Stream<PingData>> startPingProcess(
      {required String host, required int count});
}

class PingRepoImpl extends PingRepository {
  Ping? ping;

  @override
  Future<Stream<PingData>> startPingProcess(
      {required String host, required int count}) async {
    ping?.stop();
    ping = Ping(host, count: count);
    return ping!.stream;
  }
}
