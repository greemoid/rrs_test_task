import 'package:freezed_annotation/freezed_annotation.dart';

part 'gadget_model.freezed.dart';
part 'gadget_model.g.dart';

@freezed
abstract class GadgetModel with _$GadgetModel {
  const factory GadgetModel({
    required String id,
    required String name,
    Map<String, dynamic>? data,
  }) = _GadgetModel;

  factory GadgetModel.fromJson(Map<String, dynamic> json) =>
      _$GadgetModelFromJson(json);
}
