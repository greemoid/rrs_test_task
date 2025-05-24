import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/gadget.dart';
import '../../domain/repositories/gadget_repository.dart';

part 'gadget_state.dart';

class GadgetCubit extends Cubit<GadgetState> {
  final GadgetRepository _gadgetRepository;

  GadgetCubit({required GadgetRepository gadgetRepository})
    : _gadgetRepository = gadgetRepository,
      super(GadgetInitial());

  Future<void> getGadgets() async {
    emit(GadgetLoading());
    final result = await _gadgetRepository.getGadgets();
    result.fold(
      (failure) => emit(GadgetError(failure.message)),
      (gadgets) => emit(GadgetLoaded(gadgets)),
    );
  }
}
