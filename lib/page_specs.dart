// Import flutter packages.
import 'package:flutter/material.dart';

// Import project-specific files.
import 'package:kar_kam/settings_page_contents.dart';

/// Allows for the easy referencing of page content.
class PageSpec {
  const PageSpec({
    required this.title,
    required this.contents,
  });

  /// A [title] for each page/route.
  final String title;

  /// The [contents] associated with each page/route.
  final Widget contents;
}

/// Home page specs.
PageSpec homePage = PageSpec(
  title: 'Home',
  contents: Container(),
);

/// Files page specs.
PageSpec filesPage = PageSpec(
  title: 'Files',
  contents: Container(),
);

/// Settings page specs.
PageSpec settingsPage = PageSpec(
  title: 'Settings',
  contents: SettingsPageContents(),
  // contents: Container(),
);