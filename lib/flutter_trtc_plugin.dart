import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class TRTCCloudDef {
  static const int TRTC_APP_SCENE_VIDEOCALL = 0;
  static const int TRTC_APP_SCENE_LIVE = 1;
  static const int TRTCRoleAnchor = 20;
  static const int TRTCRoleAudience = 21;
}

const _kChannel = 'flutter_trtc_plugin';

class FlutterTrtcPlugin {
  static FlutterTrtcPlugin _instance;
  final _channel = const MethodChannel(_kChannel);
  factory FlutterTrtcPlugin() => _instance ??= FlutterTrtcPlugin._();

  FlutterTrtcPlugin._() {
    _channel.setMethodCallHandler(_handleMessages);
  }

  final _onError = StreamController<Map<String, dynamic>>.broadcast();
  final _onWarning = StreamController<Map<String, dynamic>>.broadcast();
  final _onEnterRoom = StreamController<int>.broadcast();
  final _onExitRoom = StreamController<int>.broadcast();
  final _onSwitchRole = StreamController<Map<String, dynamic>>.broadcast();
  final _onConnectOtherRoom = StreamController<Map<String, dynamic>>.broadcast();
  final _onDisConnectOtherRoom = StreamController<Map<String, dynamic>>.broadcast();
  final _onUserEnter = StreamController<String>.broadcast();
  final _onUserExit = StreamController<Map<String, dynamic>>.broadcast();
  final _onUserVideoAvailable = StreamController<Map<String, dynamic>>.broadcast();
  final _onUserSubStreamAvailable = StreamController<Map<String, dynamic>>.broadcast();
  final _onUserAudioAvailable = StreamController<Map<String, dynamic>>.broadcast();
  final _onFirstVideoFrame = StreamController<Map<String, dynamic>>.broadcast();
  final _onFirstAudioFrame = StreamController<String>.broadcast();
  final _onSendFirstLocalVideoFrame = StreamController<int>.broadcast();
  final _onSendFirstLocalAudioFrame = StreamController<Null>.broadcast();
  final _onNetworkQuality = StreamController<Map<String, dynamic>>.broadcast();
  final _onStatistics = StreamController<Map<String, dynamic>>.broadcast();
  final _onConnectionLost = StreamController<Null>.broadcast();
  final _onTryToReconnect = StreamController<Null>.broadcast();
  final _onConnectionRecovery = StreamController<Null>.broadcast();
  final _onSpeedTest = StreamController<Map<String, dynamic>>.broadcast();
  final _onCameraDidReady = StreamController<Null>.broadcast();
  final _onMicDidReady = StreamController<Null>.broadcast();
  final _onAudioRouteChanged = StreamController<Map<String, dynamic>>.broadcast();
  final _onUserVoiceVolume = StreamController<Map<String, dynamic>>.broadcast();
  final _onRecvCustomCmdMsg = StreamController<Map<String, dynamic>>.broadcast();
  final _onMissCustomCmdMsg = StreamController<Map<String, dynamic>>.broadcast();
  final _onRecvSEIMsg = StreamController<Map<String, dynamic>>.broadcast();
  final _onStartPublishCDNStream = StreamController<Map<String, dynamic>>.broadcast();
  final _onStopPublishCDNStream = StreamController<Map<String, dynamic>>.broadcast();
  final _onSetMixTranscodingConfig = StreamController<Map<String, dynamic>>.broadcast();
  final _onAudioEffectFinished = StreamController<Map<String, dynamic>>.broadcast();

  Future<Null> _handleMessages(MethodCall call) async {
    switch (call.method) {
      case 'onError':
        _onError.add(call.arguments);
        break;
      case 'onWarning':
        _onWarning.add(call.arguments);
        break;
      case 'onEnterRoom':
        _onEnterRoom.add(call.arguments['elapsed']);
        break;
      case 'onExitRoom':
        _onExitRoom.add(call.arguments['reason']);
        break;
      case 'onSwitchRole':
        _onSwitchRole.add(call.arguments);
        break;
      case 'onConnectOtherRoom':
        _onConnectOtherRoom.add(call.arguments);
        break;
      case 'onDisConnectOtherRoom':
        _onDisConnectOtherRoom.add(call.arguments);
        break;
      case 'onUserEnter':
        _onUserEnter.add(call.arguments['userId']);
        break;
      case 'onUserExit':
        _onUserExit.add(call.arguments);
        break;
      case 'onUserVideoAvailable':
        _onUserVideoAvailable.add(call.arguments);
        break;
      case 'onUserSubStreamAvailable':
        _onUserSubStreamAvailable.add(call.arguments);
        break;
      case 'onUserAudioAvailable':
        _onUserAudioAvailable.add(call.arguments);
        break;
      case 'onFirstVideoFrame':
        _onFirstVideoFrame.add(call.arguments);
        break;
      case 'onFirstAudioFrame':
        _onFirstAudioFrame.add(call.arguments['userId']);
        break;
      case 'onSendFirstLocalVideoFrame':
        _onSendFirstLocalVideoFrame.add(call.arguments['streamType']);
        break;
      case 'onSendFirstLocalAudioFrame':
        _onSendFirstLocalAudioFrame.add(null);
        break;
      case 'onNetworkQuality':
        _onNetworkQuality.add(call.arguments);
        break;
      case 'onStatistics':
        _onStatistics.add(call.arguments);
        break;
      case 'onConnectionLost':
        _onConnectionLost.add(null);
        break;
      case 'onTryToReconnect':
        _onTryToReconnect.add(null);
        break;
      case 'onConnectionRecovery':
        _onConnectionRecovery.add(null);
        break;
      case 'onSpeedTest':
        _onSpeedTest.add(call.arguments);
        break;
      case 'onCameraDidReady':
        _onCameraDidReady.add(null);
        break;
      case 'onMicDidReady':
        _onMicDidReady.add(null);
        break;
      case 'onAudioRouteChanged':
        _onAudioRouteChanged.add(call.arguments);
        break;
      case 'onUserVoiceVolume':
        _onUserVoiceVolume.add(call.arguments);
        break;
      case 'onRecvCustomCmdMsg':
        _onRecvCustomCmdMsg.add(call.arguments);
        break;
      case 'onMissCustomCmdMsg':
        _onMissCustomCmdMsg.add(call.arguments);
        break;
      case 'onRecvSEIMsg':
        _onRecvSEIMsg.add(call.arguments);
        break;
      case 'onStartPublishCDNStream':
        _onStartPublishCDNStream.add(call.arguments);
        break;
      case 'onStopPublishCDNStream':
        _onStopPublishCDNStream.add(call.arguments);
        break;
      case 'onSetMixTranscodingConfig':
        _onSetMixTranscodingConfig.add(call.arguments);
        break;
      case 'onAudioEffectFinished':
        _onAudioEffectFinished.add(call.arguments);
        break;
      default:
        break;
    }
  }

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

  ///关闭Stream.
  void dispose() {
    _onError.close();
    _onWarning.close();
    _onEnterRoom.close();
    _onExitRoom.close();
    _onSwitchRole.close();
    _onConnectOtherRoom.close();
    _onDisConnectOtherRoom.close();
    _onUserEnter.close();
    _onUserExit.close();
    _onUserVideoAvailable.close();
    _onUserSubStreamAvailable.close();
    _onUserAudioAvailable.close();
    _onFirstVideoFrame.close();
    _onFirstAudioFrame.close();
    _onSendFirstLocalVideoFrame.close();
    _onSendFirstLocalAudioFrame.close();
    _onNetworkQuality.close();
    _onStatistics.close();
    _onConnectionLost.close();
    _onTryToReconnect.close();
    _onConnectionRecovery.close();
    _onSpeedTest.close();
    _onCameraDidReady.close();
    _onMicDidReady.close();
    _onAudioRouteChanged.close();
    _onUserVoiceVolume.close();
    _onRecvCustomCmdMsg.close();
    _onMissCustomCmdMsg.close();
    _onRecvSEIMsg.close();
    _onStartPublishCDNStream.close();
    _onStopPublishCDNStream.close();
    _onSetMixTranscodingConfig.close();
    _onAudioEffectFinished.close();
  }

  ///加入或创建房间.
  Future<void> joinRoom(
      {@required int appId,
      @required int roomId,
      @required String userId,
      @required String userSig,
      int scene = TRTCCloudDef.TRTC_APP_SCENE_VIDEOCALL,
      int userRole = TRTCCloudDef.TRTCRoleAnchor,
      bool isCustomVideoCapture = false,
      String customVideoUri,
      bool devMode = false}) async {
    assert(roomId != null && roomId > 0);
    assert(appId != null && appId > 0);
    assert(userId != null && userId.isNotEmpty);
    assert(userSig != null && userSig.isNotEmpty);
    assert(scene == TRTCCloudDef.TRTC_APP_SCENE_VIDEOCALL ||
        scene == TRTCCloudDef.TRTC_APP_SCENE_LIVE);
    assert(userRole == TRTCCloudDef.TRTCRoleAnchor || userRole == TRTCCloudDef.TRTCRoleAudience);
    final args = <String, dynamic>{
      'app_id': appId,
      'room_id': roomId,
      'user_id': userId,
      'user_sig': userSig,
      'scene_type': scene,
      'user_role': userRole,
      'is_custom_video_capture': isCustomVideoCapture,
      'custom_video_uri': customVideoUri,
      'dev_mode': devMode
    };
    await _channel.invokeMethod('joinRoom', args);
  }
}
