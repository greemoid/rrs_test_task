import 'package:retrofit/retrofit.dart';
import 'package:rrs_test_task/data/models/gadget_model.dart';
import 'package:dio/dio.dart';

part 'gadget_network_datasource.g.dart';

@RestApi(baseUrl: 'https://api.restful-api.dev')
abstract class GadgetNetworkDatasource {
  factory GadgetNetworkDatasource(Dio dio, {String? baseUrl}) =
      _GadgetNetworkDatasource;

  @GET('/objects')
  Future<List<GadgetModel>> getGadgets();
}
