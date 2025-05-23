import 'dart:convert';

/// color : "Cloudy White"
/// capacity : "128 GB"

GadgetDataModel dataFromJson(String str) => GadgetDataModel.fromJson(json.decode(str));

String dataToJson(GadgetDataModel data) => json.encode(data.toJson());

class GadgetDataModel {
  GadgetDataModel({String? color, String? capacity}) {
    _color = color;
    _capacity = capacity;
  }

  GadgetDataModel.fromJson(dynamic json) {
    _color = json['color'];
    _capacity = json['capacity'];
  }

  String? _color;
  String? _capacity;

  GadgetDataModel copyWith({String? color, String? capacity}) =>
      GadgetDataModel(color: color ?? _color, capacity: capacity ?? _capacity);

  String? get color => _color;

  String? get capacity => _capacity;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['color'] = _color;
    map['capacity'] = _capacity;
    return map;
  }
}
