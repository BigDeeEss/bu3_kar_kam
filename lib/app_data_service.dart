// Import flutter packages.
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Import project-specific files.
import 'package:kar_kam/app_data.dart';
import 'package:kar_kam/lib/get_it_service.dart';
import 'package:kar_kam/lib/rect_extension.dart';
import 'package:kar_kam/lib/map_extension.dart';

/// Implements a Shared Preferences method for accessing stored app data.
class AppDataService extends AppData {
  AppDataService() {
    initialiseAppData();
    // userPreferences = await SharedPreferences.getInstance();
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
      'buttonRadius': (newValue) => cycleButtonRadius(),
      'drawLayoutBounds': (newValue) => toggleDrawLayoutBounds(),
      'settingsPageListTileFadeEffect': (newValue) =>
          toggleSettingsPageListTileFadeEffect(),
    };

    // Call the function determined from [map] and update relevant field.
    map[identifier]?.call(newValue);

    // Notify listeners only if instructed to do so. Default is to notify.
    if (notify) {
      notifyListeners();
    }
  }

  /// Cycle and upload a new [buttonAlignment]; update dependencies.
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

    // Update dependencies: [buttonArrayRect].
    buttonArrayRect = setButtonArrayRect();
  }

  /// Cycle and upload a new [buttonRadius]; update dependencies.
  void cycleButtonRadius() {
    // Define a map which can convert an integer to a double that represents
    // a value for [buttonRadius].
    Map<int, double> map = {
      0: 28.0,
      1: 32.0,
      2: 36.0,
      3: 24.0,
    };

    // Use [map], its inverse and the modulus operator to cycle [buttonRadius].
    int buttonRadiusIntRepresentation = map.inverse()[buttonRadius]!;
    buttonRadius = map[(buttonRadiusIntRepresentation + 1) % map.length]!;

    // Update dependencies: [buttonArrayRect] and [buttonCoordinates].
    buttonArrayRect = setButtonArrayRect();
    buttonCoordinates = setButtonCoordinates();

    setUserPreferences('buttonRadius', buttonRadius);
  }

  Future<void> initialiseAppData() async {
    final userPreferences = await SharedPreferences.getInstance();

    buttonRadius = userPreferences.getDouble('buttonRadius');
    buttonRadius = buttonRadius ?? 28.0;
    setUserPreferences('buttonRadius', buttonRadius);
    // Future<void> (() {
    //   userPreferences.setDouble('buttonRadius', buttonRadius!);
    // });
  }

  /// Initiates field variables; only called once after app start.
  @override
  void initialise() {
    // Exit if init has already been executed.
    if (initComplete) return;

    // Calculate and upload [buttonArrayRect] and [buttonCoordinates].
    buttonArrayRect = setButtonArrayRect();
    buttonCoordinates = setButtonCoordinates();

    // Register that init has completed.
    initComplete = true;
  }

  /// Calculates the bounding box for [ButtonArray].
  Rect setButtonArrayRect() {
    double dim = 2 * (buttonRadius! + buttonPaddingMainAxisAlt);
    double shortLength = 2.0 * (buttonRadius! + buttonPaddingMainAxis);
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
    double dim = 2 * (buttonRadius! + buttonPaddingMainAxisAlt);

    // Loop over items in [buttonSpecList] and convert each to its
    // corresponding position.
    List<double> coordinateList = [];
    for (int i = 0; i < buttonSpecList.length; i++) {
      coordinateList.add(dim * i);
    }
    return coordinateList;
  }

  Future<void> setUserPreferences(String key, var value) async {
    final userPreferences = await SharedPreferences.getInstance();

    // ToDo: Remove this wait function.
    await Future.delayed(const Duration(seconds: 10));

    if (value is double) {
      userPreferences.setDouble(key, value);
    }
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