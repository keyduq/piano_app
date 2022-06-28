import 'package:piano_app/api/models/rgb_mode.dart';

class Utils {
  static String getModeName(RgbMode mode) {
    switch (mode) {
      case RgbMode.spectrum:
        return 'Spectrum';
      case RgbMode.colorRange:
        return 'Color range';
      case RgbMode.fixedColor:
        return 'Fixed color';
    }
  }
}
