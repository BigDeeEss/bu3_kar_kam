// Import flutter packages.
import 'package:flutter/material.dart';
import 'package:get_it_mixin/get_it_mixin.dart';
import 'package:kar_kam/button_array.dart';
import 'package:kar_kam/app_data.dart';
import 'package:kar_kam/settings_page_list_tile.dart';

/// Implements sliding guides - guide circles which indicate the path followed
/// by [SettingsPageListTile] corners as they slide past [ButtonArray].
class SlidingGuides extends StatelessWidget with GetItMixin {
  SlidingGuides({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Get [AppData] registered with [GetIt].
    // AppData appData = GetItService.instance<AppData>();

    // Watch for changes to [AppData.buttonAxis] registered with GetIt.
    Axis buttonAxis = watchOnly((AppData a) => a.buttonAxis!);

    // Watch for changes to [AppData.buttonAlignment] registered with GetIt.
    Alignment buttonAlignment = watchOnly((AppData a) => a.buttonAlignment!);

    // Watch for changes to [AppData.buttonRadius] registered with GetIt.
    double buttonRadius = watchOnly((AppData a) => a.buttonRadius!);

    // Watch for changes to [AppData.buttonRadius] registered with GetIt.
    double buttonPaddingMainAxis = watchOnly((AppData a) => a.buttonPaddingMainAxis);

    return Stack(
      children: [
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
          child: CustomPaint(
            painter: OpenPainter(
              alignment: buttonAlignment,
              axis: buttonAxis,
              radius: buttonRadius + buttonPaddingMainAxis,
              shiftVal: ButtonArray.rect!.shortestSide *
                  SettingsPageListTile.sf,
            ),
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
          child: CustomPaint(
            painter: OpenPainter(
              alignment: buttonAlignment,
              axis: buttonAxis,
              radius: buttonRadius + buttonPaddingMainAxis,
              shiftVal: ButtonArray.rect!.shortestSide *
                  SettingsPageListTile.sf
            ),
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
          child: CustomPaint(
            painter: OpenPainter(
              alignment: buttonAlignment,
              axis: buttonAxis,
              radius: buttonRadius + buttonPaddingMainAxis,
              shiftVal: 0.0,
            ),
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
          child: CustomPaint(
            painter: OpenPainter(
              alignment: buttonAlignment,
              axis: buttonAxis,
              radius: buttonRadius + buttonPaddingMainAxis,
              shiftVal: 0.0,
            ),
          ),
        ),
      ]
    );
  }
}

/// A custom painter for producing the guidance circles.
class OpenPainter extends CustomPainter{
  OpenPainter({
    required this.alignment,
    required this.axis,
    required this.radius,
    required this.shiftVal,
  });

  final Alignment alignment;

  final Axis axis;

  final double shiftVal;

  final double radius;

  @override
  void paint(Canvas canvas, Size size) {
    var paint1 = Paint()
      ..color = const Color.fromRGBO(66, 165, 245, 0.5)
      ..style = PaintingStyle.fill;
    if (axis == Axis.horizontal) {
      if (alignment.y < 0 && alignment.x > 0) {
        canvas.drawCircle(Offset(-radius, radius + shiftVal), radius, paint1);
      }
      if (alignment.y < 0 && alignment.x < 0) {
        canvas.drawCircle(Offset(radius, radius + shiftVal), radius, paint1);
      }
      if (alignment.y > 0 && alignment.x > 0) {
        canvas.drawCircle(Offset(-radius, -radius - shiftVal), radius, paint1);
      }
      if (alignment.y > 0 && alignment.x < 0) {
        canvas.drawCircle(Offset(radius, -radius - shiftVal), radius, paint1);
      }
    }
    if (axis == Axis.vertical) {
      if (alignment.y < 0 && alignment.x > 0) {
        canvas.drawCircle(Offset(-radius, radius + shiftVal), radius, paint1);
      }
      if (alignment.y < 0 && alignment.x < 0) {
        canvas.drawCircle(Offset(radius, radius + shiftVal), radius, paint1);
      }
      if (alignment.y > 0 && alignment.x > 0) {
        canvas.drawCircle(Offset(-radius, -radius - shiftVal), radius, paint1);
      }
      if (alignment.y > 0 && alignment.x < 0) {
        canvas.drawCircle(Offset(radius, -radius - shiftVal), radius, paint1);
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
