import 'package:equatable/equatable.dart';

class GadgetData extends Equatable {
  final String color;
  final String capacity;

  const GadgetData({required this.color, required this.capacity});

  @override
  List<Object?> get props => [color, capacity];
}
