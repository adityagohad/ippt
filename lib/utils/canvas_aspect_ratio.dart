enum CanvasAspectRatio { mobile1, mobile2, mobile3, desktop1, square }

extension CanvasAspectRatioDisplay on CanvasAspectRatio {
  String get display {
    switch (this) {
      case CanvasAspectRatio.mobile1:
        return '9:16';
      case CanvasAspectRatio.mobile2:
        return '9:18';
      case CanvasAspectRatio.mobile3:
        return '9:20';
      case CanvasAspectRatio.desktop1:
        return '16:9';
      case CanvasAspectRatio.square:
        return '1:1';
    }
  }
}

extension CanvasAspectRatioValue on CanvasAspectRatio {
  double get value {
    switch (this) {
      case CanvasAspectRatio.mobile1:
        return 9 / 16;
      case CanvasAspectRatio.mobile2:
        return 9 / 18;
      case CanvasAspectRatio.mobile3:
        return 9 / 20;
      case CanvasAspectRatio.desktop1:
        return 16 / 9;
      case CanvasAspectRatio.square:
        return 1;
    }
  }
}
