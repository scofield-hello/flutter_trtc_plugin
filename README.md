# flutter_trtc_plugin

腾讯视频电话/直播SDK Flutter插件.

## Getting Started

[腾讯云实时音视频](https://cloud.tencent.com/document/product/647)

1.在pubspec.yaml中添加插件依赖项

```yaml
  dependencies:
    flutter_trtc_plugin:
      git: git://github.com/scofield-hello/flutter_trtc_plugin.git
```

2.创建/加入房间

```dart
import 'package:flutter/services.dart';
import 'package:flutter_trtc_plugin/flutter_trtc_plugin.dart';

final pluginReference = FlutterTrtcPlugin();

Future<void> join() async {
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      await pluginReference.joinRoom(
          devMode: false,//是否开发模式
          roomId: 1000001,//房间号
          appId: 1,//APP ID
          userId: "用户ID",
          userSig: '签名数据从后台获取');
    } on PlatformException {
      print("------------出错啦.");
    }
  }
```

3.事件监听
```dart
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
```
...还有更多事件请查看 flutter_trtc_plugin.dart
```dart
Stream<Map<String, dynamic>> get onError => _onError.stream;
  Stream<Map<String, dynamic>> get onWarning => _onWarning.stream;
  Stream<int> get onEnterRoom => _onEnterRoom.stream;
  Stream<int> get onExitRoom => _onExitRoom.stream;
  Stream<Map<String, dynamic>> get onSwitchRole => _onSwitchRole.stream;
  Stream<Map<String, dynamic>> get onConnectOtherRoom => _onConnectOtherRoom.stream;
  Stream<Map<String, dynamic>> get onDisConnectOtherRoom => _onDisConnectOtherRoom.stream;
  Stream<String> get onUserEnter => _onUserEnter.stream;
  Stream<Map<String, dynamic>> get onUserExit => _onUserExit.stream;
  Stream<Map<String, dynamic>> get onUserVideoAvailable => _onUserVideoAvailable.stream;
  Stream<Map<String, dynamic>> get onUserSubStreamAvailable => _onUserSubStreamAvailable.stream;
  Stream<Map<String, dynamic>> get onUserAudioAvailable => _onUserAudioAvailable.stream;
  Stream<Map<String, dynamic>> get onFirstVideoFrame => _onFirstVideoFrame.stream;
  Stream<String> get onFirstAudioFrame => _onFirstAudioFrame.stream;
  Stream<int> get onSendFirstLocalVideoFrame => _onSendFirstLocalVideoFrame.stream;
  Stream<Null> get onSendFirstLocalAudioFrame => _onSendFirstLocalAudioFrame.stream;
  Stream<Map<String, dynamic>> get onNetworkQuality => _onNetworkQuality.stream;
  Stream<Map<String, dynamic>> get onStatistics => _onStatistics.stream;
  Stream<Null> get onConnectionLost => _onConnectionLost.stream;
  Stream<Null> get onTryToReconnect => _onTryToReconnect.stream;
  Stream<Null> get onConnectionRecovery => _onConnectionRecovery.stream;
  Stream<Map<String, dynamic>> get onSpeedTest => _onSpeedTest.stream;
  Stream<Null> get onCameraDidReady => _onCameraDidReady.stream;
  Stream<Null> get onMicDidReady => _onMicDidReady.stream;
  Stream<Map<String, dynamic>> get onAudioRouteChanged => _onAudioRouteChanged.stream;
  Stream<Map<String, dynamic>> get onUserVoiceVolume => _onUserVoiceVolume.stream;
  Stream<Map<String, dynamic>> get onRecvCustomCmdMsg => _onRecvCustomCmdMsg.stream;
  Stream<Map<String, dynamic>> get onMissCustomCmdMsg => _onMissCustomCmdMsg.stream;
  Stream<Map<String, dynamic>> get onRecvSEIMsg => _onRecvSEIMsg.stream;
  Stream<Map<String, dynamic>> get onStartPublishCDNStream => _onStartPublishCDNStream.stream;
  Stream<Map<String, dynamic>> get onStopPublishCDNStream => _onStopPublishCDNStream.stream;
  Stream<Map<String, dynamic>> get onSetMixTranscodingConfig => _onSetMixTranscodingConfig.stream;
  Stream<Map<String, dynamic>> get onAudioEffectFinished => _onAudioEffectFinished.stream;
```


This project is a starting point for a Flutter
[plug-in package](https://flutter.dev/developing-packages/),
a specialized package that includes platform-specific implementation code for
Android and/or iOS.

For help getting started with Flutter, view our 
[online documentation](https://flutter.dev/docs), which offers tutorials, 
samples, guidance on mobile development, and a full API reference.
