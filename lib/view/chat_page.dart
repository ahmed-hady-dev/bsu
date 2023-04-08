import 'dart:developer';
import 'dart:typed_data';

import 'package:bsu/constants/constants.dart';
import 'package:bsu/utils/router.dart';
import 'package:bsu/view/home/home_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:glassmorphism_ui/glassmorphism_ui.dart';
import 'package:simple_ripple_animation/simple_ripple_animation.dart';
import 'package:vibration/vibration.dart';
import 'package:audioplayers/audioplayers.dart';

class ChatPage extends StatefulWidget {
  final BluetoothDevice server;

  const ChatPage({super.key, required this.server});

  @override
  _ChatPage createState() => _ChatPage();
}

class _ChatPage extends State<ChatPage> with SingleTickerProviderStateMixin {
  BluetoothConnection? connection;
  bool isConnecting = true;
  String _messageBuffer = '';
  bool isDisconnecting = false;
  List<String> messages = <String>['0'];
  bool get isConnected => (connection?.isConnected ?? false);
  final ScrollController listScrollController = ScrollController();
  final audioPlayer = AudioPlayer();
  BluetoothState _bluetoothState = BluetoothState.UNKNOWN;

  @override
  void initState() {
    super.initState();
    FlutterBluetoothSerial.instance.state.then((state) => setState(() => _bluetoothState = state));
    FlutterBluetoothSerial.instance.onStateChanged().listen((BluetoothState state) {
      setState(() {
        _bluetoothState = state;
      });
    });
    BluetoothConnection.toAddress(widget.server.address).then((connection) {
      log('Connected to the device');
      connection = connection;
      setState(() {
        isConnecting = false;
        isDisconnecting = false;
      });

      try {
        connection.input!.listen(_onDataReceived).onDone(() {
          if (isDisconnecting) {
            log('Disconnecting locally!');
          } else {
            log('Disconnected remotely!');
          }
          if (mounted) {
            setState(() {});
          }
        });
      } catch (e, s) {
        log('!=!=!=' * 22);
        log(e.toString());
        log(s.toString());
        log('!=!=!=' * 22);
      }
    }).catchError((e, s) {
      log('-----' * 22);
      log('Cannot connect, exception occurred');
      log(e);
      log(s);
      log('-----' * 22);
    });
  }

  @override
  void dispose() {
    if (isConnected) {
      isDisconnecting = true;
      connection?.dispose();
      connection = null;
    }

    super.dispose();
  }

  void _onDataReceived(Uint8List data) {
    // Allocate buffer for parsed data
    int backspacesCounter = 0;
    for (var byte in data) {
      if (byte == 8 || byte == 127) {
        backspacesCounter++;
      }
    }
    Uint8List buffer = Uint8List(data.length - backspacesCounter);
    int bufferIndex = buffer.length;

    // Apply backspace control character
    backspacesCounter = 0;
    for (int i = data.length - 1; i >= 0; i--) {
      if (data[i] == 8 || data[i] == 127) {
        backspacesCounter++;
      } else {
        if (backspacesCounter > 0) {
          backspacesCounter--;
        } else {
          buffer[--bufferIndex] = data[i];
        }
      }
    }

    // Create message if there is new line character
    String dataString = String.fromCharCodes(buffer);
    int index = buffer.indexOf(13);
    if (~index != 0) {
      setState(() {
        messages.add(
          backspacesCounter > 0
              ? _messageBuffer.substring(0, _messageBuffer.length - backspacesCounter)
              : _messageBuffer + dataString.substring(0, index),
        );

        Vibration.hasVibrator().then((value) {
          if (value!) {
            if (int.parse(messages.last) <= 20 || int.parse(messages.last) >= 1190) {
              Vibration.vibrate(pattern: [500, 1000, 500]);
              audioPlayer.play(AssetSource('images/warning-sound-6686.mp3'));
            } else if (int.parse(messages.last) <= 50) {
              Vibration.vibrate(pattern: [1000, 200, 1000]);
              audioPlayer.pause();
            } else {
              audioPlayer.pause();
            }
          }
        });
        _messageBuffer = dataString.substring(index);
      });
    } else {
      _messageBuffer = (backspacesCounter > 0
          ? _messageBuffer.substring(0, _messageBuffer.length - backspacesCounter)
          : _messageBuffer + dataString);
    }
  }

  Color getScaffoldColor({required int distance}) {
    Color scaffoldColor = AppColors.scaffoldColor;
    if (distance <= 20 || distance >= 1190) {
      scaffoldColor = AppColors.redScaffoldColor;
    } else if (distance <= 50) {
      scaffoldColor = AppColors.yellowScaffoldColor;
    }
    return scaffoldColor;
  }

  Color getRippleColor({required int distance}) {
    Color rippleColor = AppColors.indigo;
    if (distance <= 20 || distance >= 1190) {
      rippleColor = Colors.red;
    } else if (distance <= 50) {
      rippleColor = Colors.yellow.shade600;
    }
    return rippleColor;
  }

  @override
  Widget build(BuildContext context) {
    final List list = messages.map((message) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            (text) {
              return text == '/shrug' ? '¯\\_(ツ)_/¯' : text;
            }(message.trim()),
            style: Theme.of(context).textTheme.titleLarge!.copyWith(color: Colors.white),
          ),
          Text(
            'CM',
            style: Theme.of(context).textTheme.titleSmall!.copyWith(color: Colors.white),
          ),
        ],
      );
    }).toList();
    if (messages.last == '0') {
      return const Scaffold(body: Center(child: CupertinoActivityIndicator()));
    }
    var distance = int.parse(messages.last);
    if (!_bluetoothState.isEnabled || _bluetoothState == BluetoothState.UNKNOWN) {
      MagicRouter.navigateAndPopAll(const HomeView());
    }
    return Scaffold(
      backgroundColor: getScaffoldColor(distance: distance),
      body: SafeArea(
        child: list.isEmpty
            ? const Center(child: CupertinoActivityIndicator(color: Colors.black))
            : Stack(
                children: [
                  Center(
                    child: RippleAnimation(
                      color: getRippleColor(distance: distance),
                      delay: const Duration(milliseconds: 12),
                      repeat: true,
                      minRadius: widget.width * 0.4,
                      ripplesCount: 4,
                      duration: const Duration(milliseconds: 1200),
                      child: Container(
                          padding: EdgeInsets.all(widget.width * 0.1),
                          decoration: BoxDecoration(color: getRippleColor(distance: distance), shape: BoxShape.circle),
                          child: list.last),
                    ),
                  ),
                  Positioned(
                    top: 20,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: GlassContainer(
                        blur: 5,
                        color: Colors.white.withOpacity(0.5),
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            getRippleColor(distance: distance).withOpacity(0.4),
                            getRippleColor(distance: distance).withOpacity(0.8),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(12),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 24),
                          child: Text(
                            isConnecting ? 'Connecting ...' : 'Blind Stick App',
                            style: Theme.of(context).textTheme.titleLarge!.copyWith(color: Colors.black54),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
