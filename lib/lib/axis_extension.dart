//  Import flutter packages.
import 'package:flutter/material.dart';

// extension AxisExtension on Axis {
  Axis? axisFromString(String? string) {
    switch (string) {
      case 'Axis.vertical':
        return Axis.vertical;
      case 'Axis.horizontal':
        return Axis.horizontal;
      default:
        return null;
    }
  }
// }