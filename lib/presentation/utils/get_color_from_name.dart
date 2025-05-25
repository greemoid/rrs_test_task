import 'package:flutter/material.dart';

Color? getColorFromName(String name) {
  return namedColors[name];
}

final Map<String, Color> namedColors = {
  'Cloudy White': Color(0x00f4fafc),
  'Purple': Colors.purple,
  'Brown': Colors.brown,
  'Red': Colors.red,
};
