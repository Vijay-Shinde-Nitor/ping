import 'package:get_it/get_it.dart';
import 'package:nitor_ping/data/ping_repository.dart';
import 'package:nitor_ping/presentation/bloc/ping_bloc.dart';

var getIt = GetIt.instance;

Future<void> setUp() async {
  //Ping Bloc
  getIt.registerFactory(() => PingBloc(repository: getIt()));
  //Ping Repository
  getIt.registerLazySingleton<PingRepository>(() => PingRepoImpl());
}
