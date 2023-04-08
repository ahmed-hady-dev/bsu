import 'package:bsu/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:flutter_svg/svg.dart';

class BluetoothOffScreen extends StatelessWidget {
  const BluetoothOffScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
              width: width * 0.97,
              height: height * 0.45,
              child: SvgPicture.asset('assets/images/undraw_mobile_search_p2ka.svg')),
          SizedBox(height: height * 0.04),
          const Center(
            child: Text(
              'Please turn on bluetooth and connect to stick,\n you will find it under name "HC-05".\ntry 0000 or 1234 if password required',
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: height * 0.03),
          ElevatedButton(
            child: const Text('Open Bluetooth settings'),
            onPressed: () => FlutterBluetoothSerial.instance.openSettings(),
          ),
        ],
      ),
    );
  }
}
