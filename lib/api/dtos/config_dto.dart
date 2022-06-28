import 'package:piano_app/api/models/rgb_mode.dart';

class ConfigDto {
  RgbMode rgbMode;
  int colorRangeStart;
  int fixedHue;

  ConfigDto(this.rgbMode, this.colorRangeStart, this.fixedHue);

  ConfigDto.fromJson(Map<String, dynamic> json)
      : rgbMode = RgbMode.values
            .firstWhere((i) => i.toString().split('.').last == json['rgbMode']),
        colorRangeStart = json['colorRangeStart'],
        fixedHue = json['fixedHue'];

  Map<String, dynamic> toJson() => {
        'rgbMode': rgbMode.name,
        'colorRangeStart': colorRangeStart,
        'fixedHue': fixedHue,
      };
}
