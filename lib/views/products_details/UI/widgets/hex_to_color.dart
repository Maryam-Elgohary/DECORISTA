// Convert HEX string (e.g. "#C4A484") to Color
import 'package:flutter/material.dart';

Color hexToColor(String hex) {
  hex = hex.replaceAll("#", "");
  return Color(int.parse("0xFF$hex"));
}
