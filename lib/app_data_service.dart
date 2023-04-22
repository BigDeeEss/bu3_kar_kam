// Import project-specific files.
import 'package:kar_kam/lib/get_it_service.dart';
import 'package:kar_kam/app_data.dart';

/// Implements a Shared Preferences method for accessing stored app data.
class AppDataService extends AppData {
  AppDataService() {
    /// The loading of app data from file will require some async
    /// initialization, so simulate it here with a Future.delayed function.
    Future.delayed(const Duration(seconds: 1))
        .then((_) => GetItService.signalReady<AppDataService>(this));
  }
}