//  Import flutter packages.
import 'package:flutter/material.dart';

/// Stores data and makes it available to all of its descendants.
class DataStore<T> extends StatelessWidget {
  const DataStore({
    required Key key,
    required this.child,
    required this.data,
  }) : super(key: key);

  /// The immediate descendant of [DataStore].
  final Widget child;

  /// Is passed to [DataStoreService] and made available to all descendants.
  final T data;

  /// Allow all descendant widgets of [DataStore] to access [data].
  static DataStoreService<T> of<T>(BuildContext context, Key key) {
    // Get instance of [DataStoreService<T>] immediately above the location
    // in the widget tree where [of] is called.
    DataStoreService<T>? result =
        context.dependOnInheritedWidgetOfExactType<DataStoreService<T>>();

    // Using 'is' in what follows promotes result to type [DataStoreService<T>]
    // so that the comparison 'key != result.key' makes sense and can be made.
    //
    // Without 'is' [result.key] is not specific.
    if (result is DataStoreService<T>) {
      if (key != result.key) {
        // If keys do not match then continue search up the widget tree.
        result = DataStore.of<T>(result.context, key);
      }
    } else {
      // Assert a contradiction so that [of] fails with error message.
      assert(
          result != null,
          'DataStore, [of]...no DataStoreService of type <$T> found '
          'in context. Try wrapping the call to [of] in a builder or '
          'specifying the type, for example DataStoreService<int>(...).');
    }
    return result!;
  }

  @override
  Widget build(BuildContext context) {
    // Insert an instance of [DataStoreService] before [child] so that
    // descendant widgets can access data via [of].
    return DataStoreService<T>(
      key: key,
      context: context,
      data: data,
      child: child,
    );
  }
}

/// Allows descendant widgets to access [data].
class DataStoreService<T> extends InheritedWidget {
  const DataStoreService({
    Key? key,
    required Widget child,
    required this.context,
    required this.data,
  }) : super(key: key, child: child);

  /// Required for extending the the search for further instances of
  /// [DataStoreService] up the widget tree.
  final BuildContext context;

  /// Is made accessible to descendant widgets via [DataStore.of<T>].
  final T data;

  /// Notifies listenable objects of updates to [data].
  @override
  bool updateShouldNotify(DataStoreService<T> old) => data != old.data;
}
