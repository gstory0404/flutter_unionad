import 'package:flutter/services.dart';

import 'unionad_constants.dart';
import 'unionad_platform.dart';

/// 基于 MethodChannel / EventChannel 的默认实现
class MethodChannelUnionad extends UnionadPlatform {
  final MethodChannel _methodChannel =
      const MethodChannel(UnionadConstants.methodChannelName);
  final EventChannel _eventChannel =
      const EventChannel(UnionadConstants.eventChannelName);

  @override
  Future<bool> register(Map<String, dynamic> params) async {
    return await _methodChannel.invokeMethod('register', params);
  }

  @override
  Future<int> requestPermissionIfNecessary() async {
    return await _methodChannel.invokeMethod('requestPermissionIfNecessary');
  }

  @override
  Future<String> getSDKVersion() async {
    return await _methodChannel.invokeMethod('getSDKVersion');
  }

  @override
  Future<bool> loadRewardVideoAd(Map<String, dynamic> params) async {
    return await _methodChannel.invokeMethod('loadRewardVideoAd', params);
  }

  @override
  Future<bool> showRewardVideoAd() async {
    return await _methodChannel.invokeMethod('showRewardVideoAd', {});
  }

  @override
  Future<bool> loadFullScreenVideoAdInteraction(
      Map<String, dynamic> params) async {
    return await _methodChannel.invokeMethod(
        'loadFullScreenVideoAdInteraction', params);
  }

  @override
  Future<bool> showFullScreenVideoAdInteraction() async {
    return await _methodChannel.invokeMethod(
        'showFullScreenVideoAdInteraction', {});
  }

  @override
  Future<int> getThemeStatus() async {
    return await _methodChannel.invokeMethod('getThemeStatus');
  }

  @override
  Stream<dynamic> get adEventStream {
    return _eventChannel.receiveBroadcastStream();
  }
}
