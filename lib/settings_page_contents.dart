// Import flutter packages.
import 'package:flutter/material.dart';
import 'package:get_it_mixin/get_it_mixin.dart';

// Import project-specific files.
import 'package:kar_kam/button_array.dart';
import 'package:kar_kam/lib/data_store.dart';
import 'package:kar_kam/lib/get_it_service.dart';
import 'package:kar_kam/lib/global_key_extension.dart';
import 'package:kar_kam/app_data.dart';
import 'package:kar_kam/settings_page_list_tile.dart';

/// Provides [PageSpec] contents for [settingsPage].
///
/// [SettingsPageContents] uses the [SettingsPageListTile] class. These tiles
/// are able to scroll around (not behind) [ButtonArray].
///
/// [SettingsPageContents] defines a [scrollController] in order to access
/// the scroll position relative to the top of the page. The value is passed
/// to a [ValueNotifier] and passed down the widget tree to listeners via
/// [DataStore<ValueNotifier<double>>].
class SettingsPageContents extends StatefulWidget
    with GetItStatefulWidgetMixin {
  SettingsPageContents({Key? key}) : super(key: key);

  @override
  State<SettingsPageContents> createState() => _SettingsPageContentsState();
}

class _SettingsPageContentsState extends State<SettingsPageContents>
    with GetItStateMixin {
  // [scrollController] is added to the [ListView] instance below in [build]
  // in order to get the scroll position [Offset] value.
  final ScrollController scrollController = ScrollController();

  // [scrollPositionNotifier] will be passed to an instance of [DataStore]
  // so that the scroll position can be used within [SettingsPageListTile].
  final ValueNotifier<double> scrollPositionNotifier = ValueNotifier(0.0);

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    // Add listener to [scrollController] and use it to update
    // [scrollPositionNotifier] whenever [scrollController.offset] changes.
    scrollController.addListener(() {
      scrollPositionNotifier.value = scrollController.offset;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Watch for changes to [Settings.settingsPageListTileIconSize]
    // registered with GetIt.
    double settingsPageListTileIconSize =
        watchOnly((AppData a) => a.settingsPageListTileIconSize);

    // Get [basePageViewRect] (from [DataNotifier] in [BasePage]).
    GlobalKey basePageViewKey =
        DataStore.of<GlobalKey>(context, const ValueKey('basePageViewKey'))
            .data;
    Rect? basePageViewRect = basePageViewKey.globalPaintBounds;

    // Generate a temporary list of tiles to build.
    // ToDo: replace temporary list with final version.
    List<Widget> tileList = [
      ...List<Widget>.generate(5, (int index) {
        return SettingsPageListTile(
          basePageViewRect:
              basePageViewRect ?? Offset.zero & MediaQuery.of(context).size,
          height: 75.0,
          index: index,
          leading: Icon(
            Icons.favorite,
            size: settingsPageListTileIconSize,
          ),
          widget: Text(
            '$index. Some very, very, very, very, very, very, very, very, very, very, very, verylongtext!',
            maxLines: 1,
            softWrap: false,
          ),
        );
      }),
      SettingsPageListTile(
        basePageViewRect:
            basePageViewRect ?? Offset.zero & MediaQuery.of(context).size,
        height: 75.0,
        index: 5,
        leading: Icon(
          Icons.circle_notifications_outlined,
          size: settingsPageListTileIconSize,
        ),
        onTap: () {
          // Toggle bool variable in AppModel that controls the fade effect.
          GetItService.instance<AppData>()
              .change(identifier: 'drawLayoutBounds');
        },
        trailing: Icon(
          Icons.circle_notifications_outlined,
          size: settingsPageListTileIconSize,
        ),
        widget: const Text(
          '5. Click to switch drawLayoutBounds',
          maxLines: 1,
          softWrap: false,
        ),
      ),
      SettingsPageListTile(
        basePageViewRect:
            basePageViewRect ?? Offset.zero & MediaQuery.of(context).size,
        height: 75.0,
        index: 6,
        leading: Icon(
          Icons.circle_notifications_outlined,
          size: settingsPageListTileIconSize,
        ),
        onTap: (() {
          // Toggle bool variable in AppModel that controls the fade effect.
          GetItService.instance<AppData>()
              .change(identifier: 'settingsPageListTileFadeEffect');
        }),
        trailing: Icon(
          Icons.circle_notifications_outlined,
          size: settingsPageListTileIconSize,
        ),
        widget: const Text(
          '6. Click to toggle settingsPageListTileFadeEffect!',
          maxLines: 1,
          softWrap: false,
        ),
      ),
      SettingsPageListTile(
        basePageViewRect:
            basePageViewRect ?? Offset.zero & MediaQuery.of(context).size,
        height: 75.0,
        index: 7,
        leading: Icon(
          Icons.circle_notifications_outlined,
          size: settingsPageListTileIconSize,
        ),
        onTap: (() {
          // Toggle bool variable in AppModel that controls the fade effect.
          GetItService.instance<AppData>()
              .change(identifier: 'buttonAxis');
        }),
        trailing: Icon(
          Icons.circle_notifications_outlined,
          size: settingsPageListTileIconSize,
        ),
        widget: const Text(
          '7. Click to toggle buttonAxis!',
          maxLines: 1,
          softWrap: false,
        ),
      ),
      SettingsPageListTile(
        basePageViewRect:
            basePageViewRect ?? Offset.zero & MediaQuery.of(context).size,
        height: 75.0,
        index: 8,
        leading: Icon(
          Icons.circle_notifications_outlined,
          size: settingsPageListTileIconSize,
        ),
        onTap: (() {
          // Toggle bool variable in AppModel that controls the fade effect.
          GetItService.instance<AppData>()
              .change(identifier: 'buttonAlignment');
        }),
        trailing: Icon(
          Icons.circle_notifications_outlined,
          size: settingsPageListTileIconSize,
        ),
        widget: const Text(
          '8. Cycle ButtonAlignment!',
          maxLines: 1,
          softWrap: false,
        ),
      ),
      SettingsPageListTile(
        basePageViewRect:
        basePageViewRect ?? Offset.zero & MediaQuery.of(context).size,
        height: 75.0,
        index: 9,
        leading: Icon(
          Icons.circle_notifications_outlined,
          size: settingsPageListTileIconSize,
        ),
        onTap: (() {
          // Toggle bool variable in AppModel that controls the fade effect.
          GetItService.instance<AppData>()
              .change(identifier: 'buttonRadius');
        }),
        trailing: Icon(
          Icons.circle_notifications_outlined,
          size: settingsPageListTileIconSize,
        ),
        widget: const Text(
          '9. Cycle ButtonRadius!',
          maxLines: 1,
          softWrap: false,
        ),
      ),
      ...List<Widget>.generate(100, (int index) {
        return SettingsPageListTile(
          basePageViewRect:
              basePageViewRect ?? Offset.zero & MediaQuery.of(context).size,
          height: 75.0,
          index: index + 10,
          leading: Icon(
            Icons.favorite,
            size: settingsPageListTileIconSize,
          ),
          widget: Text(
            '$index. Some very, very, very, very, very, very, very, very, very, very, very, verylongtext!',
            maxLines: 1,
            softWrap: false,
          ),
        );
      }),
    ];

    // Encapsulate [ListViewBuilder] in an instance of [DataNotifier] in order
    // to pass [scrollPositionNotifier] down to [SettingsPageListTile].
    return DataStore<ValueNotifier<double>>(
      key: const ValueKey('scrollPosition'),
      data: scrollPositionNotifier,
      child: ListView.builder(
        controller: scrollController,
        itemCount: tileList.length,
        itemBuilder: (context, index) {
          return tileList[index];
        },
      ),
    );
  }
}
