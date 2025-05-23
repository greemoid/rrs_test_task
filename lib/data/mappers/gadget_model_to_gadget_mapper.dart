import 'package:rrs_test_task/data/mappers/data_model_to_data_mapper.dart';

import '../../domain/entities/gadget.dart';
import '../models/gadget_model.dart';

extension GadgetModelToGadgetMapper on GadgetModel {
  Gadget toDomain() => Gadget(name: name ?? 'Unknown', data: data?.toDomain());
}
