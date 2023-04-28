// Import flutter packages.
import 'package:flutter/material.dart';

// Import project-specific files.
import 'package:kar_kam/app_data.dart';
import 'package:kar_kam/lib/get_it_service.dart';
import 'package:kar_kam/lib/rect_extension.dart';

/// Implements a Shared Preferences method for accessing stored app data.
class AppDataService extends AppData {
  AppDataService() {
    /// The loading of app data from file will require some async
    /// initialization, so simulate it here with a Future.delayed function.
    Future.delayed(const Duration(seconds: 1))
        .then((_) => GetItService.signalReady<AppDataService>(this));

    /// Register that [init] has not yet completed.
    initComplete = false;
  }
  /// Updates [this] using [identifier] to determine which field to change and
  /// calling the appropriate change function using the unspecified [newValue].
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
      'buttonAlignment': (newValue) => cycleButtonAlignment(),
      'buttonAxis': (newValue) => toggleButtonAxis(),
      // 'buttonRadius': (newValue) => cycleButtonRadius(),
      'drawLayoutBounds': (newValue) => toggleDrawLayoutBounds(),
      'settingsPageListTileFadeEffect': (newValue) =>
          toggleSettingsPageListTileFadeEffect(),
    };

    // Call the function determined from [map] and update relevant field.
    map[identifier]?.call(newValue);

    if (notify) {
      notifyListeners();
    }
  }

  void cycleButtonAlignment() {
    // Define a map which can convert [buttonAlignment] to another
    // [Alignment] type.
    Map<Alignment, Alignment> map = {
      Alignment.topLeft: Alignment.topRight,
      Alignment.topRight: Alignment.bottomRight,
      Alignment.bottomRight: Alignment.bottomLeft,
      Alignment.bottomLeft: Alignment.topLeft,
    };

    // Do the conversion using [map].
    buttonAlignment = map[buttonAlignment]!;

    // Update [buttonArrayRect].
    buttonArrayRect = setButtonArrayRect();
  }

  /// Initiates field variables; only called once after app start.
  @override
  void init() {
    // Exit if init has already been executed.
    if (initComplete) return;

    // Calculate and upload [buttonArrayRect].
    buttonArrayRect = setButtonArrayRect();

    // Calculate and upload [buttonCoordinates].
    buttonCoordinates = setButtonCoordinates();

    // Register that init has completed.
    initComplete = true;
  }

  // Calculates the bounding box for [ButtonArray].
  Rect setButtonArrayRect() {
    double dim = 2 * (buttonRadius + buttonPaddingMainAxisAlt);
    double shortLength = 2.0 * (buttonRadius + buttonPaddingMainAxis);
    double longLength = (buttonSpecList.length - 1) * dim + shortLength;

    // Generate Rect of the correct size at screen top left.
    Rect rect = Rect.zero;
    if (buttonAxis == Axis.vertical) {
      rect = const Offset(0.0, 0.0) & Size(shortLength, longLength);
    } else {
      rect = const Offset(0.0, 0.0) & Size(longLength, shortLength);
    }

    Map<Alignment, Function> map = {
      Alignment.topLeft: (Rect rect) =>
          rect.moveTopLeftTo(basePageViewRect!.topLeft),
      Alignment.topRight: (Rect rect) =>
          rect.moveTopRightTo(basePageViewRect!.topRight),
      Alignment.bottomLeft: (Rect rect) =>
          rect.moveBottomLeftTo(basePageViewRect!.bottomLeft),
      Alignment.bottomRight: (Rect rect) =>
          rect.moveBottomRightTo(basePageViewRect!.bottomRight),
    };

    if (basePageViewRect != Rect.zero) {
      rect = map[buttonAlignment]?.call(rect);
    } else {
      assert(
      basePageViewRect != null,
      'AppData, get buttonArrayRect...error, '
          'basePageViewRect is null.');
    }

    return rect;
  }

  /// Calculates the list of coordinates for placing [Button] components
  /// in [ButtonArray].
  List<double> setButtonCoordinates() {
    // A length -- button width plus padding -- for defining [coordinateList].
    // Using two parameters allows for the bounding boxes of buttons to overlap.
    double dim = 2 * (buttonRadius + buttonPaddingMainAxisAlt);

    // Loop over items in [buttonSpecList] and convert each to its
    // corresponding position.
    List<double> coordinateList = [];
    for (int i = 0; i < buttonSpecList.length; i++) {
      coordinateList.add(dim * i);
    }
    return coordinateList;
  }

  /// Toggles [buttonAxis].
  void toggleButtonAxis() {
    buttonAxis = flipAxis(buttonAxis);
    buttonArrayRect = setButtonArrayRect();
  }

  /// Toggles [drawLayoutBounds].
  void toggleDrawLayoutBounds() => drawLayoutBounds = !drawLayoutBounds;

  /// Toggles [settingsPageListTileFadeEffect].
  void toggleSettingsPageListTileFadeEffect() =>
      settingsPageListTileFadeEffect = !settingsPageListTileFadeEffect;
}