import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import './background_collecting_task.dart';
import './select_bonded_device_page.dart';
import 'bluetooth_off_screen.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  _MainPage createState() => _MainPage();
}

class _MainPage extends State<HomeView> {
  BluetoothState _bluetoothState = BluetoothState.UNKNOWN;
  BackgroundCollectingTask? _collectingTask;

  @override
  void initState() {
    super.initState();
    FlutterBluetoothSerial.instance.state.then((state) => setState(() => _bluetoothState = state));
    Future.doWhile(() async {
      if ((await FlutterBluetoothSerial.instance.isEnabled) ?? false) {
        return false;
      }
      await Future.delayed(const Duration(milliseconds: 0xDD));
      return true;
    });
    FlutterBluetoothSerial.instance.onStateChanged().listen((BluetoothState state) {
      setState(() {
        _bluetoothState = state;
      });
    });
  }

  @override
  void dispose() {
    FlutterBluetoothSerial.instance.setPairingRequestHandler(null);
    _collectingTask?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_bluetoothState.isEnabled || _bluetoothState == BluetoothState.UNKNOWN) return const BluetoothOffScreen();
    return const SelectBondedDevicePage();
  }
}
