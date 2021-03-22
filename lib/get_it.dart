import 'package:get_it/get_it.dart';
import 'package:squadup/bloc/rosters/bloc.dart';
import 'package:squadup/repository/rosters/rosters.dart';
import 'package:squadup/repository/rosters/rosters_repository_hive.dart';

GetIt getIt = GetIt.instance;

void getServices() {
  getIt.registerLazySingleton<RostersRepository>(() => RostersRepositoryHive());
  getIt.registerLazySingleton<RostersBloc>(() => RostersBloc());
}