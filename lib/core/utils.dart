import 'dart:convert';
import 'dart:io';
import 'package:async/async.dart';

//Testing Purpose
void pingUsingProcess() async {
  try {
    Process p = await Process.start(
        'ping', ['-O', '-n', '-c 5', '-W 1', '-i 1', 'google.com']);

    StreamGroup.merge([p.stdout, p.stderr])
        .transform(utf8.decoder)
        .transform(const LineSplitter())
        // .transform(StreamTransformer.fromHandlers())
        .listen((event) {
      print("Log:"+event);
    });
  } catch (e) {
    print('error $e');
  }
}

// void iAddLookup()async{
//   try {
//     List<InternetAddress> result = await InternetAddress.lookup('google.com');
//     if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
//       print('connected');
//       print(result.first.address);
//       print(result.first.host);
//       print(result.first.isLinkLocal);
//       print(result.first.isMulticast);
//       print(result.first.isLoopback);
//     }
//   } on SocketException catch (_) {
//     print('not connected');
//   }
// }

/*abstract class PingRepository {
  Future<Stream<String>> startPing();
}

class PingRepoImpl extends PingRepository {
  @override
  Future<Stream<String>> startPing() async {
    Process p = await Process.start(
        'ping', ['-O', '-n', '-c 5', '-W 1', '-i 1', 'google.com']);

    return StreamGroup.merge([p.stdout, p.stderr])
        .transform(utf8.decoder);
    // .transform(const LineSplitter());
  }
}*/
