//  Import flutter packages.
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

/// Provides a single interface between GetIt and app.
class GetItService {
  /// Signal that all GetIt instances are ready for use.
  static Future<void> allReady() {
    return GetIt.instance.allReady();
  }

  /// Avoid memory leaks by properly disposing of the listenable attached
  /// to the instance of [T] registered with GetIt.
  static void dispose<T extends ChangeNotifier>(VoidCallback callBack) {
    GetIt.instance<T>().removeListener(callBack);
  }

  /// Add listener to the instance of [T], an extension of [ChangeNotifier],
  /// registered with GetIt.
  static void addListener<T extends ChangeNotifier>(VoidCallback callBack) {
    GetIt.instance
        .isReady<T>()
        .then((_) => GetIt.instance<T>().addListener(callBack));
  }

  /// Returns the instance of [T] registered with GetIt so that the
  /// associated fields and methods can be accessed.
  static T instance<T extends ChangeNotifier>() {
    return GetIt.instance<T>();
  }

  /// Register an instance of [T] with Getit.
  static void register<T extends ChangeNotifier>(T instance) {
    GetIt.instance.registerSingleton<T>(instance, signalsReady: true);
  }

  /// Signal that the registered singleton is ready for use.
  static void signalReady<T extends ChangeNotifier>(T instance) {
    GetIt.instance.signalReady(instance);
  }
}
