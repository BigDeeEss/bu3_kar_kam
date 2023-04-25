// Import flutter packages.
import 'package:flutter/material.dart';
import 'package:get_it_mixin/get_it_mixin.dart';

// Import project-specific files.
import 'package:kar_kam/app_data.dart';

/// Implements a [Container] and draws its bounding box.
///
/// [BoxedContainer] essentially calls an instance of [Container] with
/// a default decoration if one is not specifically given. [BoxedContainer]
/// defaults to [Container] if [AppData.drawLayoutBounds] is false.
class BoxedContainer extends StatelessWidget with GetItMixin {
  BoxedContainer({
    Key? key,
    this.alignment,
    this.child,
    this.clipBehavior = Clip.none,
    this.color,
    this.constraints,
    this.decoration,
    this.foregroundDecoration,
    this.height,
    this.margin,
    this.padding,
    this.transform,
    this.transformAlignment,
    this.width,
    this.borderColor,
    this.borderRadius,
  }) : super(key: key);

  // [Container]-specific variables.
  final AlignmentGeometry? alignment;
  final Widget? child;
  final Clip clipBehavior;
  final Color? color;
  final BoxConstraints? constraints;
  final Decoration? decoration;
  final Decoration? foregroundDecoration;
  final double? height;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final Matrix4? transform;
  final AlignmentGeometry? transformAlignment;
  final double? width;

  // [BoxedContainer]-specific variables.
  final Color? borderColor;
  final double? borderRadius;

  @override
  Widget build(BuildContext context) {
    // Watch for changes to [Settings.drawLayoutBounds] registered with GetIt.
    bool drawLayoutBounds = watchOnly((AppData a) => a.drawLayoutBounds);

    return Container(
      alignment: alignment,
      clipBehavior: clipBehavior,
      constraints: constraints,
      decoration: decoration ??
          BoxDecoration(
            border: drawLayoutBounds
                ? Border.all(
                    width: 0.1,
                    color: borderColor ?? Colors.black,
                  )
                : null,
            borderRadius: BorderRadius.all(
              Radius.circular(borderRadius ?? 0.0),
            ),
            color: color,
          ),
      foregroundDecoration: foregroundDecoration,
      height: height,
      margin: margin,
      padding: padding,
      transform: transform,
      transformAlignment: transformAlignment,
      width: width,
      child: child,
    );
  }
}
