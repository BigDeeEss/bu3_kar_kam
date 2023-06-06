// Import flutter packages.
import 'package:flutter/material.dart';

// Import project-specific files.
import 'package:kar_kam/button_specs.dart';

/// Stores app data.
abstract class AppData extends ChangeNotifier {
  /// A scale factor which is applied to [appBarHeight] in order to calculate
  /// the [BottomAppBar] height in [BasePage] class.
  double? appBarHeightScaleFactor;
  // double appBarHeightScaleFactor = 1.0;

  /// The anchor point for determining [Button] placement in [ButtonArray].
  Alignment? buttonAlignment;

  /// Represents the layout bounds for [ButtonArray].
  Rect? buttonArrayRect;

  /// The axis for [ButtonArray].
  Axis? buttonAxis;

  /// Coordinates for [ButtonArray].
  List<double>? buttonCoordinates;

  /// Main axis padding between buttons in [ButtonArray].
  double? buttonPaddingMainAxis;

  /// An alternative padding between buttons in [ButtonArray].
  double? buttonPaddingMainAxisAlt;

  /// Defines the padding surrounding each button.
  // EdgeInsetsDirectional get buttonPadding =>
  //     EdgeInsetsDirectional.all(buttonPaddingMainAxis);

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
  bool? drawSlidingGuides;

  /// Represents whether [initialise] has completed or not.
  bool initialiseComplete = false;

  /// The border width for [SettingsPageListTile].
  double? settingsPageListTileBorderWidth;

  /// The sum of [settingsPageListTilePadding] and [settingsPageListTileRadius].
  double? settingsPageListTileCornerRadius;

  /// Whether fade effect in [SettingsPageListTile] is active or not.
  bool? settingsPageListTileFadeEffect;

  /// Defines [SettingsPageListTile] icon radius (used in [Button]).
  double? settingsPageListTileIconSize;

  /// Defines the padding between adjacent instances of [SettingsPageListTile].
  double? settingsPageListTilePadding;

  /// Defines [SettingsPageListTile] corner radius.
  double? settingsPageListTileRadius;

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
