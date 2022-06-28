import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart' hide PickerItem;
import 'package:flutter_picker/Picker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:piano_app/api/api_proxy.dart';
import 'package:piano_app/api/models/rgb_mode.dart';
import 'package:piano_app/utils/utils.dart';

import '../api/dtos/config_dto.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ConfigDto? _currentConfig;
  late List<PickerItem<RgbMode>> modes;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    modes = RgbMode.values
        .map((e) => PickerItem(
            text: Text(
              e.name,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            value: e))
        .toList();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Piano RGB'),
        elevation: 0,
      ),
      body: Container(
        margin: const EdgeInsets.all(16),
        child: FutureBuilder(
          future: ApiProxy.getConfig(),
          builder: (context, AsyncSnapshot<ConfigDto> snapshot) {
            if (snapshot.hasData) {
              _currentConfig ??= snapshot.data!;
              return _buildView(context);
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  Widget _buildView(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: const BorderRadius.all(Radius.circular(16))),
          child: Column(
            children: [
              ListTile(
                onTap: () => _pickMode(context),
                title: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const FaIcon(FontAwesomeIcons.codeCommit),
                    const SizedBox(
                      width: 6,
                    ),
                    Expanded(
                      child: Text(
                        'Mode',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                    Text(Utils.getModeName(_currentConfig!.rgbMode)),
                  ],
                ),
              ),
              Visibility(
                visible: _currentConfig!.rgbMode == RgbMode.colorRange,
                child: ListTile(
                  title: SizedBox(
                    height: 40,
                    child: ColorPickerSlider(
                      TrackType.hue,
                      HSVColor.fromAHSV(
                        1,
                        _currentConfig!.colorRangeStart.toDouble(),
                        0.5,
                        0.5,
                      ),
                      (color) async {
                        setState(() {
                          _currentConfig!.colorRangeStart = color.hue.toInt();
                        });
                      },
                    ),
                  ),
                  trailing: OutlinedButton(
                    child: const Text('Pick color'),
                    onPressed: () async {
                      await ApiProxy.setConfig(_currentConfig!);
                    },
                  ),
                ),
              ),
              Visibility(
                visible: _currentConfig!.rgbMode == RgbMode.fixedColor,
                child: ListTile(
                  title: SizedBox(
                    height: 40,
                    child: ColorPickerSlider(
                      TrackType.hue,
                      HSVColor.fromAHSV(
                        1,
                        _currentConfig!.fixedHue.toDouble(),
                        0.5,
                        0.5,
                      ),
                      (color) async {
                        setState(() {
                          _currentConfig!.fixedHue = color.hue.toInt();
                        });
                      },
                    ),
                  ),
                  trailing: OutlinedButton(
                    child: const Text('Pick color'),
                    onPressed: () async {
                      await ApiProxy.setConfig(_currentConfig!);
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  _pickMode(BuildContext context) {
    Picker(
      adapter: PickerDataAdapter<RgbMode>(data: modes),
      title: Text(
        'Pick a mode',
        style: Theme.of(context).textTheme.titleMedium,
      ),
      backgroundColor: Theme.of(context).canvasColor,
      textStyle: Theme.of(context).textTheme.button,
      headerColor: Theme.of(context).canvasColor,
      headerDecoration: const BoxDecoration(),
      confirmTextStyle: Theme.of(context).textTheme.button!,
      selecteds: [RgbMode.values.indexOf(_currentConfig!.rgbMode)],
      cancelTextStyle: Theme.of(context).textTheme.button!,
      onConfirm: (Picker picker, List value) async {
        _currentConfig!.rgbMode = picker.getSelectedValues()[0];
        await ApiProxy.setConfig(_currentConfig!);
        setState(() {});
      },
    ).showModal(context);
  }
}
