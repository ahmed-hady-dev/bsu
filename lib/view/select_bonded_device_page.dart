import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

import '../utils/router.dart';
import 'chat_page.dart';

class SelectBondedDevicePage extends StatefulWidget {
  final bool checkAvailability;
  const SelectBondedDevicePage({super.key, this.checkAvailability = true});

  @override
  _SelectBondedDevicePage createState() => _SelectBondedDevicePage();
}

enum _DeviceAvailability { yes }

class _DeviceWithAvailability {
  BluetoothDevice device;
  _DeviceAvailability availability;
  int? rssi;

  _DeviceWithAvailability(this.device, this.availability);
}

class _SelectBondedDevicePage extends State<SelectBondedDevicePage> {
  List<_DeviceWithAvailability> devices = List<_DeviceWithAvailability>.empty(growable: true);
  StreamSubscription<BluetoothDiscoveryResult>? _discoveryStreamSubscription;
  bool _isDiscovering = false;
  BluetoothDevice bDevice = const BluetoothDevice(address: '00:21:13:04:50:6A');
  _SelectBondedDevicePage();

  @override
  void initState() {
    super.initState();
    _isDiscovering = widget.checkAvailability;
    if (_isDiscovering) _startDiscovery();
    FlutterBluetoothSerial.instance.getBondedDevices().then((List<BluetoothDevice> bondedDevices) {
      setState(() => bDevice = bondedDevices.firstWhere((element) => element.address == '00:21:13:04:50:6A'));
      MagicRouter.navigateAndPopAll(ChatPage(server: bDevice));
    });
  }

  void _startDiscovery() {
    _discoveryStreamSubscription = FlutterBluetoothSerial.instance.startDiscovery().listen((r) {
      setState(() {
        Iterator i = devices.iterator;
        while (i.moveNext()) {
          var device = i.current;
          if (device.device == r.device) {
            device.availability = _DeviceAvailability.yes;
            device.rssi = r.rssi;
          }
        }
      });
    });

    _discoveryStreamSubscription?.onDone(() {
      setState(() => _isDiscovering = false);
    });
  }

  @override
  void dispose() {
    _discoveryStreamSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Select device', style: TextStyle(color: Colors.black))),
      body: const Center(child: CupertinoActivityIndicator(color: Colors.black)),
    );
  }
}
