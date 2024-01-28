

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:ret_training/busnisses_logic/cubit/my_cubit.dart';
import 'package:ret_training/repository/my_repository.dart';
import 'package:ret_training/webService/web_service.dart';

final getIt = GetIt.instance;

void setup() {
  getIt.registerLazySingleton<MyCubit>(() => MyCubit(getIt()));
  getIt.registerLazySingleton<MyRepository>(() => MyRepository(getIt()));
  getIt.registerLazySingleton<WebsService>(() => WebsService(Dio()));

}


