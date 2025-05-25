import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:fpdart/fpdart.dart';
import 'package:rrs_test_task/domain/repositories/gadget_repository.dart';
import 'package:rrs_test_task/domain/entities/gadget.dart';
import 'package:rrs_test_task/presentation/cubit/gadget_cubit.dart';
import 'package:rrs_test_task/core/failures/failure.dart';

class MockGadgetRepository extends Mock implements GadgetRepository {}

void main() {
  late GadgetRepository repository;

  setUp(() {
    repository = MockGadgetRepository();
  });

  final gadgets = [
    const Gadget(name: 'Pixel', data: {'color': 'black'}),
    const Gadget(name: 'iPhone', data: {}),
  ];

  group('GadgetCubit', () {
    blocTest<GadgetCubit, GadgetState>(
      'emits [Loading, Loaded] when getGadgets succeeds',
      build: () {
        when(() => repository.getGadgets())
            .thenAnswer((_) async => right(gadgets));
        return GadgetCubit(gadgetRepository: repository);
      },
      act: (cubit) => cubit.getGadgets(),
      expect: () => [
        GadgetLoading(),
        GadgetLoaded(gadgets),
      ],
    );

    blocTest<GadgetCubit, GadgetState>(
      'emits [Loading, Error] when getGadgets fails with NetworkFailure',
      build: () {
        when(() => repository.getGadgets()).thenAnswer(
              (_) async => left(const NetworkFailure(debugMessage: 'No internet')),
        );
        return GadgetCubit(gadgetRepository: repository);
      },
      act: (cubit) => cubit.getGadgets(),
      expect: () => [
        GadgetLoading(),
        isA<GadgetError>().having((e) => e.message, 'message', contains('internet')),
      ],
    );
  });
}
