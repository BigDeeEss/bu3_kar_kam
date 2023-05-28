// Import flutter packages.
import 'package:flutter/material.dart';

// Import project-specific files.
import 'package:kar_kam/base_page.dart';
import 'package:kar_kam/lib/get_it_service.dart';
import 'package:kar_kam/page_specs.dart';

/// KarKam is the root widget of this application.
///
/// KarKam is just a StatelessWidget wrapper for an instance of FutureBuilder.
///
/// FutureBuilder waits for the loading of saved app settings from storage.
class KarKam extends StatelessWidget {
  const KarKam({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'KarKam Application',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Material(
        child: FutureBuilder(
          future: GetItService.allReady(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              // For the 'has no data' case, where the load of app settings
              // is still in progress, present a progress indicator.
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Text(
                    'Initialising Kar Kam...',
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  CircularProgressIndicator(),
                ],
              );
            } else {
              // For the 'has data' case, when the load of app settings
              // is complete, continue with building BasePage.
              return MaterialApp(
                title: 'KarKam',
                // BasePage invokes a generic page layout so that a similar
                // UI is presented for each page.
                // home: Placeholder(),
                home: BasePage(
                  // pageSpec: homePage,
                  pageSpec: settingsPage,
                  // pageSpec: filesPage,
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
