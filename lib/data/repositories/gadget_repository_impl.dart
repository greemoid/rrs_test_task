import 'package:fpdart/src/either.dart';
import 'package:rrs_test_task/core/failures/failure.dart';
import 'package:rrs_test_task/data/mappers/gadget_model_to_gadget_mapper.dart';
import 'package:rrs_test_task/domain/entities/gadget.dart';

import '../../domain/repositories/gadget_repository.dart';
import '../datasources/gadget_network_datasource.dart';

class GadgetRepositoryImpl implements GadgetRepository {
  final GadgetNetworkDatasource _gadgetNetworkDatasource;

  GadgetRepositoryImpl({
    required GadgetNetworkDatasource gadgetNetworkDatasource,
  }) : _gadgetNetworkDatasource = gadgetNetworkDatasource;

  @override
  Future<Either<Failure, List<Gadget>>> getGadgets() async {
    try {
      final gadgets = await _gadgetNetworkDatasource.getGadgets();
      return right(gadgets.map((e) => e.toDomain()).toList());
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
