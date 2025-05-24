import 'package:equatable/equatable.dart';

class Gadget extends Equatable {
  final String name;
  final Map<String, dynamic> data;

  const Gadget({required this.name, required this.data});

  @override
  List<Object> get props => [name, data];
}
