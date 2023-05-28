// Import flutter packages.
import 'package:flutter/material.dart';
import 'package:get_it_mixin/get_it_mixin.dart';

// Import project-specific files.
import 'package:kar_kam/app_data.dart';
import 'package:kar_kam/boxed_container.dart';
import 'package:kar_kam/button_specs.dart';

/// Implements a copy of [FloatingActionButton].
class Button extends StatelessWidget with GetItMixin {
  Button({
    Key? key,
    required this.buttonSpec,
  }) : super(key: key);

  /// Defines visual characteristics and activation rules.
  final ButtonSpec buttonSpec;

  @override
  Widget build(BuildContext context) {
    // Watch for changes to [AppData.buttonPadding] registered with [GetIt].
    EdgeInsetsDirectional buttonPadding =
        watchOnly((AppData a) => a.buttonPadding);

    // Watch for changes to [AppData.buttonRadius] registered with [GetIt].
    double buttonRadius = watchOnly((AppData a) => a.buttonRadius);

    // An IconButton with a circular background.
    //
    // Insert an instance of [BoxedContainer] in order to offer layout bounds.
    return BoxedContainer(
      borderColor: Colors.redAccent,
      child: Padding(
        padding: buttonPadding,
        child: BoxedContainer(
          borderColor: Colors.greenAccent,
          child: CircleAvatar(
            radius: buttonRadius,
            backgroundColor: Colors.lightBlue,
            child: IconButton(
              icon: buttonSpec.icon,
              color: Colors.white,
              onPressed: () => buttonSpec.onPressed(context),
            ),
          ),
        ),
      ),
    );
  }
}
