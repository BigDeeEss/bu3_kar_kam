// Import flutter packages.
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// Import project-specific files.
import 'package:kar_kam/base_page.dart';
import 'package:kar_kam/page_specs.dart';
// import 'package:kar_kam/lib/zoom_page_transition.dart';

/// Contains the specs for an on-screen button.
class ButtonSpec {
  ButtonSpec({
    required this.icon,
    required this.onPressed,
  });

  /// Graphical indicator of the destination page and/or action.
  final Widget icon;

  /// Defines the action to be taken when the button is activated.
  final void Function(BuildContext context) onPressed;
}

/// Home page button specs.
ButtonSpec homeButton = ButtonSpec(
  icon: const FaIcon(FontAwesomeIcons.house),
  onPressed: (context) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (BuildContext context) => BasePage(
          pageSpec: homePage,
        ),
      ),
    );
    // The following is required for implementing [ZoomPageTransition].
    // Navigator.of(context).pushReplacement(ZoomPageTransition(
    //   pageSpec: homePage,
    // ));
  },
);

/// Files page button specs.
ButtonSpec filesButton = ButtonSpec(
  icon: const FaIcon(FontAwesomeIcons.fileVideo),
  onPressed: (context) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (BuildContext context) => BasePage(
          pageSpec: filesPage,
        ),
      ),
    );
    // The following is required for implementing [ZoomPageTransition].
    // Navigator.of(context).pushReplacement(ZoomPageTransition(
    //   pageSpec: filesPage,
    // ));
  },
);

//  Settings page button specs.
ButtonSpec settingsButton = ButtonSpec(
  icon: const FaIcon(FontAwesomeIcons.gear),
  onPressed: (context) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (BuildContext context) => BasePage(
          pageSpec: filesPage,
          // pageSpec: settingsPage,
        ),
      ),
    );
    // The following is required for implementing [ZoomPageTransition].
    // Navigator.of(context).pushReplacement(ZoomPageTransition(
    //   pageSpec: settingsPage,
    // ));
  },
);

