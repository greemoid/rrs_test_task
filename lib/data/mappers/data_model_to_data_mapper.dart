import '../../domain/entities/gadget_data.dart';
import '../models/gadget_data_model.dart';

extension GadgetDataModelToGadgetDataMapper on GadgetDataModel {
  GadgetData toDomain() =>
      GadgetData(color: color ?? 'Unknown', capacity: capacity ?? 'Unknown');
}
