import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rrs_test_task/core/failures/failure.dart';
import 'package:rrs_test_task/data/datasources/gadget_network_datasource.dart';
import 'package:rrs_test_task/data/models/gadget_model.dart';
import 'package:rrs_test_task/data/repositories/gadget_repository_impl.dart';
import 'package:rrs_test_task/domain/entities/gadget.dart';

class MockGadgetNetworkDatasource extends Mock
    implements GadgetNetworkDatasource {}

void main() {
  late GadgetRepositoryImpl repository;
  late MockGadgetNetworkDatasource mockDatasource;

  setUp(() {
    mockDatasource = MockGadgetNetworkDatasource();
    repository = GadgetRepositoryImpl(gadgetNetworkDatasource: mockDatasource);
  });

  group('GadgetRepositoryImpl', () {
    test('should return list of gadgets when datasource succeeds', () async {
      final models = [
        const GadgetModel(id: '1', name: 'Phone', data: {'color': 'Red'}),
      ];
      when(() => mockDatasource.getGadgets()).thenAnswer((_) async => models);

      final result = await repository.getGadgets();

      expect(result.isRight(), true);
      result.match((l) => fail('Expected right, got left: $l'), (r) {
        expect(r, isA<List<Gadget>>());
        expect(r.first.name, 'Phone');
      });
    });

    test('should return Failure when datasource throws', () async {
      when(() => mockDatasource.getGadgets()).thenThrow(Exception('network'));

      final result = await repository.getGadgets();

      expect(result.isLeft(), true);
      result.match(
        (l) => expect(l, isA<Failure>()),
        (r) => fail('Expected left, got right: $r'),
      );
    });
  });
}
