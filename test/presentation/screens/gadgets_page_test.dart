import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rrs_test_task/domain/entities/gadget.dart';
import 'package:rrs_test_task/presentation/cubit/gadget_cubit.dart';
import 'package:rrs_test_task/presentation/screens/gadgets_page.dart';
import 'package:rrs_test_task/presentation/widgets/gadget_error_widget.dart';
import 'package:rrs_test_task/presentation/widgets/gadgets_list_widget.dart';
import 'package:rrs_test_task/presentation/widgets/gadgets_loading_widget.dart';

class MockGadgetCubit extends MockCubit<GadgetState> implements GadgetCubit {
  @override
  Future<void> getGadgets() {
    return Future.value();
  }
}

void main() {
  late GadgetCubit mockCubit;

  setUp(() {
    mockCubit = MockGadgetCubit();
  });

  Widget buildTestWidget(Widget child) {
    return MaterialApp(
      home: BlocProvider.value(value: mockCubit, child: child),
    );
  }

  testWidgets('shows loading widget when state is GadgetLoading', (
    tester,
  ) async {
    whenListen(
      mockCubit,
      Stream.value(GadgetLoading()),
      initialState: GadgetInitial(),
    );

    await tester.pumpWidget(
      buildTestWidget(const GadgetsPage(title: 'Test Gadgets')),
    );
    await tester.pump();

    expect(find.byType(GadgetsLoadingWidget), findsOneWidget);
    expect(find.byType(GadgetsListWidget), findsNothing);
    expect(find.byType(GadgetErrorWidget), findsNothing);
  });

  testWidgets('shows error widget when state is GadgetError', (tester) async {
    const errorMessage = 'Error occurred';

    whenListen(
      mockCubit,
      Stream.value(GadgetError(errorMessage)),
      initialState: GadgetInitial(),
    );

    await tester.pumpWidget(
      buildTestWidget(const GadgetsPage(title: 'Test Gadgets')),
    );
    await tester.pump();

    expect(find.byType(GadgetErrorWidget), findsOneWidget);
    expect(find.text(errorMessage), findsOneWidget);
    expect(find.byType(GadgetsLoadingWidget), findsNothing);
    expect(find.byType(GadgetsListWidget), findsNothing);
  });

  testWidgets('shows list widget when state is GadgetLoaded', (tester) async {
    final gadgets = [
      const Gadget(name: 'Gadget1', data: {}),
      const Gadget(name: 'Gadget2', data: {}),
    ];

    whenListen(
      mockCubit,
      Stream.value(GadgetLoaded(gadgets)),
      initialState: GadgetInitial(),
    );

    await tester.pumpWidget(
      buildTestWidget(const GadgetsPage(title: 'Test Gadgets')),
    );
    await tester.pump();

    expect(find.byType(GadgetsListWidget), findsOneWidget);
    for (final gadget in gadgets) {
      expect(find.text(gadget.name), findsWidgets);
    }
    expect(find.byType(GadgetsLoadingWidget), findsNothing);
    expect(find.byType(GadgetErrorWidget), findsNothing);
  });

  testWidgets('shows default error text on unknown state (initial)', (
    tester,
  ) async {
    whenListen(
      mockCubit,
      Stream.value(GadgetInitial()),
      initialState: GadgetInitial(),
    );

    await tester.pumpWidget(
      buildTestWidget(const GadgetsPage(title: 'Test Gadgets')),
    );
    await tester.pump();

    expect(find.text('Something went wrong'), findsOneWidget);
  });

  testWidgets('transitions from loading to loaded state', (tester) async {
    final controller = StreamController<GadgetState>();

    whenListen(mockCubit, controller.stream, initialState: GadgetInitial());

    await tester.pumpWidget(
      buildTestWidget(const GadgetsPage(title: 'Test Gadgets')),
    );

    controller.add(GadgetLoading());
    await tester.pump();
    expect(find.byType(GadgetsLoadingWidget), findsOneWidget);

    final gadgets = [
      const Gadget(name: 'Gadget1', data: {}),
      const Gadget(name: 'Gadget2', data: {}),
    ];
    controller.add(GadgetLoaded(gadgets));
    await tester.pump();
    expect(find.byType(GadgetsListWidget), findsOneWidget);
    for (final gadget in gadgets) {
      expect(find.text(gadget.name), findsWidgets);
    }

    controller.close();
  });

  testWidgets('transitions from loading to error state', (tester) async {
    final controller = StreamController<GadgetState>();

    whenListen(mockCubit, controller.stream, initialState: GadgetInitial());

    await tester.pumpWidget(
      buildTestWidget(const GadgetsPage(title: 'Test Gadgets')),
    );

    controller.add(GadgetLoading());
    await tester.pump();
    expect(find.byType(GadgetsLoadingWidget), findsOneWidget);

    controller.add(GadgetError('Error occurred'));
    await tester.pump();

    expect(find.byType(GadgetErrorWidget), findsOneWidget);
    expect(find.text('Error occurred'), findsOneWidget);

    controller.close();
  });
}
