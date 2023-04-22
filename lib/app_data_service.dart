// Import flutter packages.
import 'package:flutter/material.dart';

// Import project-specific files.
import 'package:kar_kam/lib/get_it_service.dart';
import 'package:kar_kam/app_data.dart';

/// Implements a Shared Preferences method for accessing stored app data.
class AppDataService extends AppData {
  AppDataService() {
    /// The loading of app data from file will require some async
    /// initialization, so simulate it here with a Future.delayed function.
    Future.delayed(const Duration(seconds: 1))
        .then((_) => GetItService.signalReady<AppDataService>(this));
  }

  /// Updates this using string to determine which field is set to newValue.
  @override
  void change({
    required String identifier,
    var newValue,
    bool notify = true,
  }) {
    // Define a map that can convert [string] to a class method.
    // ToDo: add functionality for other fields in [AppData] class.
    Map<String, Function> map = {
      // 'appBarHeightScaleFactor': (double newValue) =>
      // appBarHeightScaleFactor = newValue,
      // 'buttonArrayRect': (newValue) =>
      // buttonArrayRect = updateButtonArrayRect(),
      // 'buttonCoordinates': (newValue) =>
      // buttonCoordinates = updateButtonCoordinates(),
      'basePageViewRect': (Rect newValue) => basePageViewRect = newValue,
      // 'buttonAlignment': (newValue) => cycleButtonAlignment(),
      // 'buttonAxis': (newValue) => toggleButtonAxis(),
      // 'buttonRadius': (newValue) => cycleButtonRadius(),
      // 'drawLayoutBounds': (newValue) => toggleDrawLayoutBounds(),
      // 'settingsPageListTileFadeEffect': (newValue) =>
      //     toggleSettingsPageListTileFadeEffect(),
    };

    // Call the function determined from [map] and update relevant field.
    map[identifier]?.call(newValue);

    if (notify) {
      notifyListeners();
    }
  }
}