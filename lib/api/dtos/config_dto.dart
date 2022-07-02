import 'package:piano_app/api/models/rgb_mode.dart';

class ConfigDto {
  RgbMode rgbMode;
  int colorRangeStart;
  int colorRangeEnd;
  int fixedHue;

  ConfigDto(
    this.rgbMode,
    this.colorRangeStart,
    this.colorRangeEnd,
    this.fixedHue,
  );

  ConfigDto.fromJson(Map<String, dynamic> json)
      : rgbMode = RgbMode.values
            .firstWhere((i) => i.toString().split('.').last == json['rgbMode']),
        colorRangeStart = json['colorRangeStart'],
        colorRangeEnd = json['colorRangeEnd'],
        fixedHue = json['fixedHue'];

  Map<String, dynamic> toJson() => {
        'rgbMode': rgbMode.name,
        'colorRangeStart': colorRangeStart,
        'colorRangeEnd': colorRangeEnd,
        'fixedHue': fixedHue,
      };
}
