// Import flutter packages.
import 'package:flutter/material.dart';
import 'package:get_it_mixin/get_it_mixin.dart';
import 'package:kar_kam/boxed_container.dart';
import 'package:kar_kam/button_array.dart';
import 'package:kar_kam/app_data.dart';
import 'package:kar_kam/button_array.dart';
import 'package:kar_kam/settings_page_list_tile.dart';

/// Implements sliding guides - guide circles which indicate the path followed
/// by [SettingsPageListTile] corners as they slide past [ButtonArray].
class SlidingGuides extends StatelessWidget with GetItMixin {
  SlidingGuides({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Watch for changes to [AppData.buttonAxis] registered with GetIt.
    Axis buttonAxis = watchOnly((AppData a) => a.buttonAxis)!;

    // Watch for changes to [AppData.buttonAlignment] registered with GetIt.
    Alignment buttonAlignment = watchOnly((AppData a) => a.buttonAlignment)!;

    // Use a combination of [BoxedContainer], [Container] and [BoxShape] to
    // draw a circle.
    BoxedContainer boxedContainer = BoxedContainer(
        borderColor: Colors.redAccent,
        // borderColor: Colors.white,
        child: Container(
          height: ButtonArray.rect!.shortestSide,
          width: ButtonArray.rect!.shortestSide,
          decoration: const BoxDecoration(
            color: Color.fromRGBO(66, 165, 245, 0.5),
            shape: BoxShape.circle,
          ),
        ));

    // An [Offset] for placing the 'out of [ButtonArray]; guiding circle.
    Offset offset = Offset(
        0.0, ButtonArray.rect!.shortestSide * SettingsPageListTile.sf);

    return Stack(children: [
      // Add two additional guidance circles for checking the sliding
      // motion of [SettingsPageListTile].
      // ToDo: delete these unnecessary guidance circles at some point.
      (buttonAxis == Axis.horizontal) ? Positioned(
        top: (buttonAlignment.y < 0) ? 0 : null,
        bottom: (buttonAlignment.y > 0) ? 0 : null,
        left: (buttonAlignment.x < 0)
            ? ButtonArray.buttonCoordinates!.first
            : null,
        right: (buttonAlignment.x > 0)
            ? ButtonArray.buttonCoordinates!.first
            : null,
        child: Transform.translate(
          offset: (buttonAlignment.y < 0) ? offset : -offset,
          child: boxedContainer,
        ),
      ) : Positioned(
        top: (buttonAlignment.y < 0)
            ? ButtonArray.buttonCoordinates!.last
            : null,
        bottom: (buttonAlignment.y > 0)
            ? ButtonArray.buttonCoordinates!.last
            : null,
        left: (buttonAlignment.x < 0) ? 0.0 : null,
        right: (buttonAlignment.x > 0) ? 0.0 : null,
        child: Transform.translate(
          offset: (buttonAlignment.y < 0) ? offset : -offset,
          child: boxedContainer,
        ),
      ),
      (buttonAxis == Axis.horizontal) ? Positioned(
        top: (buttonAlignment.y < 0) ? 0 : null,
        bottom: (buttonAlignment.y > 0) ? 0 : null,
        left: (buttonAlignment.x < 0)
            ? ButtonArray.buttonCoordinates!.last
            : null,
        right: (buttonAlignment.x > 0)
            ? ButtonArray.buttonCoordinates!.last
            : null,
        child: boxedContainer,
      ) : Positioned(
        top: (buttonAlignment.y < 0)
            ? ButtonArray.buttonCoordinates!.last
            : null,
        bottom: (buttonAlignment.y > 0)
            ? ButtonArray.buttonCoordinates!.last
            : null,
        left: (buttonAlignment.x < 0) ? 0.0 : null,
        right: (buttonAlignment.x > 0) ? 0.0 : null,
        child: boxedContainer,
      ),
    ]);
  }
}
