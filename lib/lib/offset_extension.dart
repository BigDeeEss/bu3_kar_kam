//  Import dart packages.
import 'dart:ui';

extension OffsetExtension on Offset {
  Size get toSize {
    return Size(dx, dy);
  }
}