// Import dart and flutter packages.
import 'package:flutter/material.dart';
import 'package:get_it_mixin/get_it_mixin.dart';

// Import project-specific files.
import 'package:kar_kam/button.dart';
import 'package:kar_kam/button_specs.dart';
import 'package:kar_kam/lib/get_it_service.dart';
import 'package:kar_kam/app_data.dart';

/// Implements a linear horizontal or vertical array of Buttons.
class ButtonArray extends StatelessWidget with GetItMixin {
  ButtonArray({Key? key}) : super(key: key);

  /// Generates a list of coordinates relative to any corner.
  static List<double>? get buttonCoordinates =>
      GetItService.instance<AppData>().buttonCoordinates;

  /// Calculates the [Rect] data associated with [buttonArray].
  static Rect? get rect => GetItService.instance<AppData>().buttonArrayRect;

  @override
  Widget build(BuildContext context) {
    // Watch for changes to [AppData.buttonAlignment] registered with [GetIt].
    Alignment buttonAlignment = watchOnly((AppData a) => a.buttonAlignment);

    // Watch for changes to [AppData.buttonAxis] registered with [GetIt].
    Axis buttonAxis = watchOnly((AppData a) => a.buttonAxis);

    // Watch for changes to [AppData.buttonAlignment] registered with [GetIt].
    List<double> buttonCoordinates = watchOnly((AppData a) => a.buttonCoordinates)!;

    // Get [buttonSpecList] within the instance of [AppData]
    // registered with [GetIt].
    List<ButtonSpec> buttonSpecList =
        GetItService.instance<AppData>().buttonSpecList;

    // Loop over items in [buttonSpecList], convert each to its
    // corresponding [button] and store result in [buttonList].
    List<Widget> buttonList = [];
    for (int i = 0; i < buttonSpecList.length; i++) {
      //  Defines the [button] to be added to [buttonList] in this iteration.
      Button button = Button(
        buttonSpec: buttonSpecList[i],
      );

      // Treat horizontal and vertical axes differently.
      if (buttonAxis == Axis.horizontal) {
        // The top and bottom inputs to [Positioned] must be 0.0 or null,
        // depending on whether the selected alignment is top or bottom.
        //
        // The left and right inputs to [Positioned] must be non-zero
        // coordinates or null, depending on whether the selected alignment
        // is left or right.
        buttonList.add(Positioned(
          top: (buttonAlignment.y < 0) ? 0 : null,
          bottom: (buttonAlignment.y > 0) ? 0 : null,
          left: (buttonAlignment.x < 0) ? buttonCoordinates[i] : null,
          right: (buttonAlignment.x > 0) ? buttonCoordinates[i] : null,
          child: button,
        ));
      }

      // Treat horizontal and vertical axes differently.
      if (buttonAxis == Axis.vertical) {
        // The left and right inputs to [Positioned] must be 0.0 or null,
        // depending on whether the selected alignment is left or right.
        //
        // The top and bottom inputs to [Positioned] must be non-zero
        // coordinates or null, depending on whether the selected alignment
        // is top or bottom.
        buttonList.add(Positioned(
          top: (buttonAlignment.y < 0) ? buttonCoordinates[i] : null,
          bottom: (buttonAlignment.y > 0) ? buttonCoordinates[i] : null,
          left: (buttonAlignment.x < 0) ? 0.0 : null,
          right: (buttonAlignment.x > 0) ? 0.0 : null,
          child: button,
        ));
      }
    }

    // Need to return a single Widget and so return an instance of [Stack]
    // with its children defined to be a list of buttons.
    return Stack(
      children: buttonList,
    );
  }
}
