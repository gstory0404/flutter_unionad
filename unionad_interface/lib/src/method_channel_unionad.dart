import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'unionad_constants.dart';
import 'unionad_platform.dart';

/// 基于 MethodChannel / EventChannel 的默认实现基类。
/// 各平台包可继承后覆写 [build*AdView] 与参数裁剪逻辑。
class MethodChannelUnionad extends UnionadPlatform {
  @protected
  MethodChannel get methodChannel =>
      const MethodChannel(UnionadConstants.methodChannelName);

  @protected
  EventChannel get eventChannel =>
      const EventChannel(UnionadConstants.eventChannelName);

  @override
  Future<bool> register(Map<String, dynamic> params) async {
    return await methodChannel.invokeMethod('register', params);
  }

  @override
  Future<int> requestPermissionIfNecessary() async {
    return await methodChannel.invokeMethod('requestPermissionIfNecessary');
  }

  @override
  Future<String> getSDKVersion() async {
    return await methodChannel.invokeMethod('getSDKVersion');
  }

  @override
  Future<bool> loadRewardVideoAd(Map<String, dynamic> params) async {
    return await methodChannel.invokeMethod('loadRewardVideoAd', params);
  }

  @override
  Future<bool> showRewardVideoAd() async {
    return await methodChannel.invokeMethod('showRewardVideoAd', {});
  }

  @override
  Future<bool> loadFullScreenVideoAdInteraction(
      Map<String, dynamic> params) async {
    return await methodChannel.invokeMethod(
        'loadFullScreenVideoAdInteraction', params);
  }

  @override
  Future<bool> showFullScreenVideoAdInteraction() async {
    return await methodChannel.invokeMethod(
        'showFullScreenVideoAdInteraction', {});
  }

  @override
  Future<int> getThemeStatus() async {
    return await methodChannel.invokeMethod('getThemeStatus');
  }

  @override
  Stream<dynamic> get adEventStream {
    return eventChannel.receiveBroadcastStream();
  }

  @override
  Widget buildBannerAdView({
    required Map<String, dynamic> creationParams,
    required double width,
    required double height,
    required PlatformViewCreatedCallback onPlatformViewCreated,
  }) {
    return const SizedBox.shrink();
  }

  @override
  Widget buildSplashAdView({
    required Map<String, dynamic> creationParams,
    required double width,
    required double height,
    required PlatformViewCreatedCallback onPlatformViewCreated,
  }) {
    return const SizedBox.shrink();
  }

  @override
  Widget buildNativeAdView({
    required Map<String, dynamic> creationParams,
    required double width,
    required double height,
    required PlatformViewCreatedCallback onPlatformViewCreated,
  }) {
    return const SizedBox.shrink();
  }

  @override
  Widget buildDrawFeedAdView({
    required Map<String, dynamic> creationParams,
    required double width,
    required double height,
    required PlatformViewCreatedCallback onPlatformViewCreated,
  }) {
    return const SizedBox.shrink();
  }
}
