import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nitor_ping/injection_container.dart';
import 'package:nitor_ping/presentation/bloc/ping_bloc.dart';

import 'presentation/view/ping_page.dart';

void main() async {
  await setUp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ping',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider(
          create: (_) => getIt<PingBloc>(),
          child: const PingPage(title: 'Ping')),
    );
  }
}
