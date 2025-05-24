import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:rrs_test_task/data/datasources/gadget_network_datasource.dart';
import 'package:rrs_test_task/domain/repositories/gadget_repository.dart';

import '../../data/repositories/gadget_repository_impl.dart';
import '../../presentation/cubit/gadget_cubit.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  final dio = Dio();
  await _initDatasources(dio);
  await _initRepositories();
  await _initCubits();
}

Future<void> _initDatasources(Dio dio) async {
  serviceLocator.registerLazySingleton<GadgetNetworkDatasource>(
    () => GadgetNetworkDatasource(dio),
  );
}

Future<void> _initRepositories() async {
  serviceLocator.registerLazySingleton<GadgetRepository>(
    () => GadgetRepositoryImpl(gadgetNetworkDatasource: serviceLocator()),
  );
}

Future<void> _initCubits() async {
  serviceLocator.registerFactory<GadgetCubit>(
    () => GadgetCubit(gadgetRepository: serviceLocator()),
  );
}
