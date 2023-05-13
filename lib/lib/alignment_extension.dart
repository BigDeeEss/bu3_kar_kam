//  Import flutter packages.
import 'package:flutter/material.dart';

extension AlignmentExtension on Alignment {
  bool get isBottom {
    if (y > 0.0) {
      return true;
    } else {
      return false;
    }
  }

  bool get isCentreAny {
    if (x == 0 || y == 0) {
      return true;
    } else {
      return false;
    }
  }

  bool get isCentreHorizontal {
    if (x == 0.0) {
      return true;
    } else {
      return false;
    }
  }

  bool get isCentreVertical {
    if (y == 0.0) {
      return true;
    } else {
      return false;
    }
  }

  bool get isLeft {
    if (x < 0.0) {
      return true;
    } else {
      return false;
    }
  }

  bool get isRight {
    if (x > 0.0) {
      return true;
    } else {
      return false;
    }
  }

  bool get isTop {
    if (y < 0.0) {
      return true;
    } else {
      return false;
    }
  }

  // Converts this to List<String> of length 2.
  List<String> toStringList() => <String>[x.toString(), y.toString()];
}

Alignment? alignmentFromStringList(List<String>? stringList) {
  if (stringList is List<String>) {
    // Make sure [stringList] contains two entries.
    assert(stringList.length == 2);

    // Convert [stringList] to [double] and then to [Alignment] type.
    return Alignment(double.parse(stringList[0]), double.parse(stringList[1]));
  } else {
    return null;
  }
}