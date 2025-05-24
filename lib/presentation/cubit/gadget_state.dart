part of 'gadget_cubit.dart';

@immutable
sealed class GadgetState extends Equatable {}

final class GadgetInitial extends GadgetState {
  @override
  List<Object> get props => [];
}

final class GadgetLoaded extends GadgetState {
  final List<Gadget> gadgets;

  GadgetLoaded(this.gadgets);

  @override
  List<Object> get props => [gadgets];
}

final class GadgetError extends GadgetState {
  final String message;

  GadgetError(this.message);

  @override
  List<Object> get props => [message];
}

final class GadgetLoading extends GadgetState {
  @override
  List<Object> get props => [];
}
