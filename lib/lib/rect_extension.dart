//  Import dart packages.
import 'dart:math' as math;
import 'package:flutter/material.dart';

extension RectExtension on Rect {
  /// Return a bool depending on whether offset lies within rect.
  ///
  /// Differs to [contains] method as the right and bottom tests include <=.
  bool boundsContain(Offset offset) {
    return offset.dx >= left &&
        offset.dx <= right &&
        offset.dy >= top &&
        offset.dy <= bottom;
  }

  /// Returns an Offset to the midpoint of the bottom edge.
  Offset get bottomCentre {
    return Offset((left + right) / 2.0, bottom);
  }

  /// Returns an Offset to the midpoint of the top edge.
  Offset get topCentre {
    return Offset((left + right) / 2.0, top);
  }

  /// Returns a new instance of Rect with left and right edges moved
  /// symmetrically so that the new width equates to newWidth.
  Rect inflateToWidth(double newWidth) {
    return Rect.fromCenter(center: center, width: newWidth, height: height);
  }

  /// Returns a new instance of Rect with top and bottom edges moved
  /// symmetrically so that the new height equates to newHeight.
  Rect inflateToHeight(double newHeight) {
    return Rect.fromCenter(center: center, width: width, height: newHeight);
  }

  /// Returns a new instance of Rect with the bottom left corner
  /// located at newOrigin.
  Rect moveBottomLeftTo(Offset newOrigin) {
    Offset origin = Offset(left, bottom);
    return Rect.fromLTRB(left, top, right, bottom).shift(newOrigin - origin);
  }

  /// Returns a new instance of Rect with the bottom right corner
  /// located at newOrigin.
  Rect moveBottomRightTo(Offset newOrigin) {
    Offset origin = Offset(right, bottom);
    return Rect.fromLTRB(left, top, right, bottom).shift(newOrigin - origin);
  }

  /// Returns a new instance of Rect with the top left corner
  /// located at newOrigin.
  Rect moveTopLeftTo(Offset newOrigin) {
    Offset origin = Offset(left, top);
    return Rect.fromLTRB(left, top, right, bottom).shift(newOrigin - origin);
  }

  /// Returns a new instance of Rect with the top right corner
  /// located at newOrigin.
  Rect moveTopRightTo(Offset newOrigin) {
    Offset origin = Offset(right, top);
    return Rect.fromLTRB(left, top, right, bottom).shift(newOrigin - origin);
  }

  /// Returns a new instance of Rect with top and bottom edges moved outward
  /// by the given delta.
  Rect inflateHeight(double delta) {
    return Rect.fromLTRB(left, top - delta, right, bottom + delta);
  }

  /// Returns a new instance of Rect with left and right edges moved outward
  /// by the given delta.
  Rect inflateWidth(double delta) {
    return Rect.fromLTRB(left - delta, top, right + delta, bottom);
  }

  /// Returns a new instance of Rect with left edges moved outward
  /// by the given delta.
  Rect inflateLeft(double delta) {
    return Rect.fromLTRB(left - delta, top, right, bottom);
  }

  /// Return a new instance of Rect with right edge moved outward
  /// by the given delta.
  Rect inflateRight(double delta) {
    return Rect.fromLTRB(left, top, right + delta, bottom);
  }

  /// Return a new instance of Rect with top edge moved outward
  /// by the given delta.
  Rect inflateUpwards(double delta) {
    return Rect.fromLTRB(left, top - delta, right, bottom);
  }

  /// Return a new instance of Rect with bottom edge moved outward
  /// by the given delta.
  Rect inflateDownwards(double delta) {
    return Rect.fromLTRB(left, top, right, bottom + delta);
  }

  /// Return a new instance of Rect that shrinks to the left so that it
  /// excludes [other] if it overlaps.
  Rect? excludeFromRight(Rect other) {
    if (!overlaps(other)) return this;
    if (right > other.left && left < other.left) {
      return Rect.fromLTRB(left, top, math.min(right, other.left), bottom);
    } else {
      return null;
    }
  }

  /// Return a new instance of Rect that shrinks to the right so that it
  /// excludes [other] if it overlaps.
  Rect? excludeFromLeft(Rect other) {
    if (!overlaps(other)) return this;
    if (left < other.right && right > other.right) {
      return Rect.fromLTRB(math.max(left, other.right), top, right, bottom);
    } else {
      return null;
    }
  }
}
