//  Import flutter packages.
import 'package:flutter/material.dart';

/// Converts 'Axis.vertical' or 'Axis.horizontal' to the corresponding
/// Axis enum value.
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