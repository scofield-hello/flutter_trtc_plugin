import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_trtc_plugin/flutter_trtc_plugin.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final pluginReference = FlutterTrtcPlugin();
  @override
  void initState() {
    super.initState();
    pluginReference.onError.listen((Map<String, dynamic> error) async {
      print("------------------------FLUTTER-TRTC-PLUGIN: onError:$error");
    });
    pluginReference.onEnterRoom.listen((int delay) async {
      print("------------------------FLUTTER-TRTC-PLUGIN: onEnterRoom:$delay");
    });
    pluginReference.onExitRoom.listen((int reason) async {
      print("------------------------FLUTTER-TRTC-PLUGIN: onExitRoom:$reason");
    });
    pluginReference.onUserEnter.listen((String userId) async {
      print("------------------------FLUTTER-TRTC-PLUGIN: onUserEnter($userId)");
    });
    pluginReference.onUserExit.listen((Map<String, dynamic> result) async {
      print("------------------------FLUTTER-TRTC-PLUGIN: onUserExit($result)");
    });
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      await pluginReference
          .joinRoom(roomId: 1000001, appId: 0000000, userId: "11123", userSig: '''''');
    } on PlatformException {
      print("------------出错啦.");
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: FlatButton.icon(
              onPressed: initPlatformState, icon: Icon(Icons.call), label: Text("进入/创建房间")),
        ),
      ),
    );
  }
}