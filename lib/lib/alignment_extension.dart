//  Import flutter packages.
import 'package:flutter/painting.dart';

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
}