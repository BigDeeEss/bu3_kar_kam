// Import flutter packages.
import 'package:flutter/material.dart';

/// Stores app data.
abstract class AppData extends ChangeNotifier {
  /// A scale factor which is applied to [appBarHeight] in order to calculate
  /// the [BottomAppBar] height in [BasePage] class.
  double appBarHeightScaleFactor = 1.0;

  /// Represents the available screen dimensions.
  ///
  /// Initially Rect.zero, it is updated on first build.
  Rect basePageViewRect = Rect.zero;

  void change({
    required String identifier,
    var newValue,
    bool notify = true,
  });
}