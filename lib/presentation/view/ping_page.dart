import 'package:dart_ping/dart_ping.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nitor_ping/core/constant.dart';
import 'package:nitor_ping/presentation/bloc/ping_bloc.dart';
import 'package:nitor_ping/presentation/bloc/ping_event.dart';
import 'package:nitor_ping/presentation/bloc/ping_state.dart';

class PingPage extends StatefulWidget {
  const PingPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<PingPage> createState() => _PingPageState();
}

class _PingPageState extends State<PingPage> {
  StringBuffer buffer = StringBuffer();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            BlocBuilder<PingBloc, PingState>(
              builder: (_, state) {
                if (state is PingingState) {
                  return StreamBuilder<PingData>(
                      stream: state.ping.stream,
                      builder: (ctx, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Text(Constant.loading);
                        } else if (snapshot.connectionState ==
                                ConnectionState.active ||
                            snapshot.connectionState == ConnectionState.done) {
                          buffer.write("${snapshot.data} \n");
                          if (snapshot.hasError) {
                            return const Text(Constant.errorMsg);
                          } else {
                            return Text(buffer.toString());
                          }
                        } else {
                          return const Text(Constant.errorMsg);
                        }
                      });
                } else {
                  return Text(
                    Constant.initMsg,
                    style: Theme.of(context).textTheme.headline5,
                  );
                }
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          buffer.clear();
          context
              .read<PingBloc>()
              .add(PingPressedEvent(Ping("google.com", count: 5)));
        },
        tooltip: 'Start Pinging',
        child: const Icon(Icons.network_ping_sharp),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
