// Import flutter packages.
import 'package:flutter/material.dart';

// Import project-specific files.
import 'package:kar_kam/kar_kam.dart';
import 'package:kar_kam/lib/get_it_service.dart';
import 'package:kar_kam/app_data.dart';
import 'package:kar_kam/app_data_service.dart';

/// App start point.
void main() {
  // Use [GetItService] as the single point of access to [GetIt] and
  // register an instance of [AppDataService].
  GetItService.register<AppData>(AppDataService());

  // Run the app.
  runApp(const KarKam());
}
