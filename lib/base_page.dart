// Import flutter packages.
import 'package:flutter/material.dart';
import 'package:get_it_mixin/get_it_mixin.dart';

// Import project-specific files.
// import 'package:kar_kam/base_page_view.dart';
// import 'package:kar_kam/button_array.dart';
import 'package:kar_kam/lib/global_key_extension.dart';
import 'package:kar_kam/page_specs.dart';
import 'package:kar_kam/app_data.dart';
// import 'package:kar_kam/sliding_guides.dart';

/// Implements a generic page layout design.
///
/// [BasePage] presents a similar UI for each page with:
///     1. an AppBar at the top with a title,
///     2. specific screen contents including buttons for navigation
///        and functionality, and
///     3. a bottom navigation bar.
///
///  [BasePage] is built in two parts in order to unambiguously
///  get the [AppBar] height.
class BasePage extends StatefulWidget with GetItStatefulWidgetMixin {
  BasePage({
    Key? key,
    required this.pageSpec,
  }) : super(key: key);

  /// Defines the page layout.
  final PageSpec pageSpec;

  @override
  State<BasePage> createState() => _BasePageState();
}

class _BasePageState extends State<BasePage> with GetItStateMixin {
  GlobalKey appBarKey = GlobalKey();

  /// Stores the [AppBar] height when calculated in the post frame call back.
  Rect? appBarRect;

  @override
  void initState() {
    // [_BasePageState] is built in two phases:
    //    (i) with null passed to bottomNavigationBar; and then
    //    (ii) with BottomAppBar passed using [appBarRect.height].
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Rect? rect = appBarKey.globalPaintBounds;

      // Check rect and then setState.
      assert(
        rect != null,
        '_BasePageState, initState...error, rect is null...',
      );
      setState(() {appBarRect = rect;});
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Watch for changes to [appBarHeightScaleFactor] in the instance of
    // [Settings] registered with GetIt.
    double appBarHeightScaleFactor =
        watchOnly((AppData a) => a.appBarHeightScaleFactor);

    return Scaffold(
      appBar: AppBar(
        key: appBarKey,
        title: Text(widget.pageSpec.title),
      ),
      bottomNavigationBar: (appBarRect != null)
          ? BottomAppBar(
              color: Colors.blue,
              height: appBarRect!.height * appBarHeightScaleFactor,
            )
          : null,
      body: const Placeholder(),
      // body: BasePageView(
      //   pageContents: <Widget>[
      //     widget.pageSpec.contents,
      //     SlidingGuides(),
      //     ButtonArray(),
      //   ],
      // ),
    );
  }
}
