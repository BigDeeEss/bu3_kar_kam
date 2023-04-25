// Import flutter packages.
import 'package:flutter/material.dart';

// Import project-specific files.
import 'package:kar_kam/button_specs.dart';

/// Stores app data.
abstract class AppData extends ChangeNotifier {
  /// A scale factor which is applied to [appBarHeight] in order to calculate
  /// the [BottomAppBar] height in [BasePage] class.
  double appBarHeightScaleFactor = 1.0;

  /// The anchor point for determining [Button] placement in [ButtonArray].
  Alignment buttonAlignment = Alignment.topLeft;

  /// Represents the layout bounds for [ButtonArray].
  Rect? buttonArrayRect;

  /// The axis for [ButtonArray].
  Axis buttonAxis = Axis.horizontal;

  /// Coordinates for [ButtonArray].
  List<double>? buttonCoordinates;

  /// Main axis padding for in between buttons in [ButtonArray].
  double buttonPaddingMainAxis = 15.0;

  /// An alternative padding for in between buttons in [ButtonArray].
  double buttonPaddingMainAxisAlt = 12.5;

  /// Defines the padding surrounding each button.
  EdgeInsetsDirectional get buttonPadding =>
      EdgeInsetsDirectional.all(buttonPaddingMainAxis);

  /// The available screen dimensions.
  Rect? basePageViewRect;

  /// Button radius for [Button] class.
  double buttonRadius = 28.0;

  /// List of [ButtonSpec] for [ButtonArray].
  List<ButtonSpec> buttonSpecList = [
    settingsButton,
    filesButton,
    homeButton,
  ];

  /// Whether [BoxedContainer] draws bounding boxes or not.
  bool drawLayoutBounds = true;

  /// Represents whether init has completed or not.
  bool initComplete = false;

  // ToDo: write doc comment for change.
  void change({
    required String identifier,
    var newValue,
    bool notify = true,
  });

  /// Initiates field variables; only called once after app start.
  void init();

  // Calculates the bounding box for [ButtonArray].
  Rect setButtonArrayRect();

  /// Calculates the list of coordinates for placing [Button] components
  /// in [ButtonArray].
  List<double> setButtonCoordinates();
}