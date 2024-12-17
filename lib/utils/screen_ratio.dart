enum ScreenRatio { mobile1, mobile2, mobile3, desktop1 }

extension ScreenRatioDisplay on ScreenRatio {
  String get display {
    switch (this) {
      case ScreenRatio.mobile1:
        return '9:16';
      case ScreenRatio.mobile2:
        return '9:18';
      case ScreenRatio.mobile3:
        return '9:20';
      case ScreenRatio.desktop1:
        return '16:9';
    }
  }
}

extension ScreenRatioValue on ScreenRatio {
  double get value {
    switch (this) {
      case ScreenRatio.mobile1:
        return 9 / 16;
      case ScreenRatio.mobile2:
        return 9 / 18;
      case ScreenRatio.mobile3:
        return 9 / 20;
      case ScreenRatio.desktop1:
        return 16 / 9;
    }
  }
}
