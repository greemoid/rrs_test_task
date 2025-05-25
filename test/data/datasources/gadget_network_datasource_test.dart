import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:rrs_test_task/data/datasources/gadget_network_datasource.dart';
import 'package:rrs_test_task/data/models/gadget_model.dart';

void main() {
  late Dio dio;
  late DioAdapter dioAdapter;
  late GadgetNetworkDatasource datasource;

  const endpoint = '/objects';

  final jsonResponse = [
    {
      "id": "1",
      "name": "Google Pixel 6 Pro",
      "data": {"color": "Cloudy White", "capacity": "128 GB"},
    },
    {"id": "2", "name": "Apple iPhone 12 Mini, 256GB, Blue", "data": null},
  ];

  setUp(() {
    dio = Dio();
    dioAdapter = DioAdapter(dio: dio);
    datasource = GadgetNetworkDatasource(dio);
  });

  test('returns list of GadgetModel when API returns 200', () async {
    dioAdapter.onGet(endpoint, (server) => server.reply(200, jsonResponse));

    final result = await datasource.getGadgets();

    expect(result, isA<List<GadgetModel>>());
    expect(result.length, 2);
    expect(result[0].name, 'Google Pixel 6 Pro');
    expect(result[1].data, isNull);
  });

  test('throws DioException when API returns error', () async {
    dioAdapter.onGet(
      endpoint,
      (server) => server.throws(
        500,
        DioException(
          type: DioExceptionType.badResponse,
          requestOptions: RequestOptions(path: endpoint),
          response: Response(
            data: 'Server error',
            statusCode: 500,
            requestOptions: RequestOptions(path: endpoint),
          ),
        ),
      ),
    );

    expect(() => datasource.getGadgets(), throwsA(isA<DioException>()));
  });
}
