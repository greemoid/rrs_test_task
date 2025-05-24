import '../../domain/entities/gadget.dart';
import '../models/gadget_model.dart';

extension GadgetModelToGadgetMapper on GadgetModel {
  Gadget toDomain() => Gadget(name: name, data: data ?? {});
}
