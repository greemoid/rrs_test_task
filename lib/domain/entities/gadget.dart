import 'package:equatable/equatable.dart';

import 'gadget_data.dart';

class Gadget extends Equatable {
  final String name;
  final GadgetData? data;

  const Gadget({required this.name, required this.data});

  @override
  List<Object> get props => [name, ?data];
}
