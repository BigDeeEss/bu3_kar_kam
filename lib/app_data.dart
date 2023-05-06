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
  Axis? buttonAxis = Axis.horizontal;

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
  double? buttonRadius;

  /// List of [ButtonSpec] for [ButtonArray].
  List<ButtonSpec> buttonSpecList = [
    settingsButton,
    filesButton,
    homeButton,
  ];

  /// Whether [BoxedContainer] draws bounding boxes or not.
  bool? drawLayoutBounds;

  /// Whether [ButtonArray] includes [SlidingGuides] or not.
  bool drawSlidingGuides = true;

  /// Represents whether init has completed or not.
  bool initComplete = false;

  /// Whether fade effect in SettingsPageListTile is active or not.
  bool settingsPageListTileFadeEffect = true;

  /// Defines the icon radius in Button.
  double settingsPageListTileIconSize = 25.0;

  /// Defines the padding between tiles.
  double settingsPageListTilePadding = 0.0;

  /// Defines the tile corner radius.
  double settingsPageListTileRadius = 15.0;

  /// Updates [this] using [identifier] to determine which field to change and
  /// calling the appropriate change function using the unspecified [newValue].
  void change({
    required String identifier,
    var newValue,
    bool notify = true,
  });

  /// Initiates field variables; only called once after app start.
  void initialise();
}