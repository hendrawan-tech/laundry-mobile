import 'package:flutter/material.dart';

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}

ColorToMaterialColor(Color tmp) {
  Map<int, Color> colorCodes = {
    50: tmp.withOpacity(0.1),
    100: tmp.withOpacity(0.2),
    200: tmp.withOpacity(0.3),
    300: tmp.withOpacity(0.4),
    400: tmp.withOpacity(0.5),
    500: tmp.withOpacity(0.6),
    600: tmp.withOpacity(0.7),
    700: tmp.withOpacity(0.8),
    800: tmp.withOpacity(0.9),
    900: tmp.withOpacity(1),
  };

  return MaterialColor(
      int.parse('0x' + tmp.value.toRadixString(16).toUpperCase()), colorCodes);
}
