import 'dart:convert';

import 'gadget_data_model.dart';

/// id : "1"
/// name : "Google Pixel 6 Pro"
/// data : {"color":"Cloudy White","capacity":"128 GB"}

GadgetModel gadgetModelFromJson(String str) =>
    GadgetModel.fromJson(json.decode(str));

String gadgetModelToJson(GadgetModel data) => json.encode(data.toJson());

class GadgetModel {
  GadgetModel({String? id, String? name, GadgetDataModel? data}) {
    _id = id;
    _name = name;
    _data = data;
  }

  GadgetModel.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _data = json['data'] != null ? GadgetDataModel.fromJson(json['data']) : null;
  }

  String? _id;
  String? _name;
  GadgetDataModel? _data;

  GadgetModel copyWith({String? id, String? name, GadgetDataModel? data}) =>
      GadgetModel(id: id ?? _id, name: name ?? _name, data: data ?? _data);

  String? get id => _id;

  String? get name => _name;

  GadgetDataModel? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    return map;
  }
}
