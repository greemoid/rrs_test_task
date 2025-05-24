import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:rrs_test_task/core/sl/init_dependencies.dart';
import 'package:rrs_test_task/presentation/cubit/gadget_cubit.dart';
import 'package:rrs_test_task/presentation/screens/gadgets_page.dart';

void main() {
  initDependencies();
  runZonedGuarded(() => runApp(const MyApp()), (e, s) {
    if (kDebugMode) {
      print(e);
      print(s);
    }
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gadgets',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: BlocProvider(
        create: (_) => GetIt.I.get<GadgetCubit>(),
        child: const GadgetsPage(title: 'Gadgets'),
      ),
    );
  }
}
