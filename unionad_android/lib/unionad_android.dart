import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:unionad_interface/unionad_interface.dart';

/// Android 端广告实现：原生 [FlutterUnionadPlugin] + [AndroidView]。
class UnionadAndroid extends MethodChannelUnionad {
  /// 由 Flutter 引擎在加载插件时调用，注入为当前平台实现。
  static void registerWith() {
    UnionadPlatform.instance = UnionadAndroid();
  }

  @override
  Future<bool> register(Map<String, dynamic> params) {
    return super.register(_androidParams(params));
  }

  @override
  Future<bool> loadRewardVideoAd(Map<String, dynamic> params) {
    return super.loadRewardVideoAd(_androidParams(params));
  }

  @override
  Future<bool> loadFullScreenVideoAdInteraction(Map<String, dynamic> params) {
    return super.loadFullScreenVideoAdInteraction(_androidParams(params));
  }

  @override
  Widget buildBannerAdView({
    required Map<String, dynamic> creationParams,
    required double width,
    required double height,
    required PlatformViewCreatedCallback onPlatformViewCreated,
  }) {
    return AndroidView(
      viewType: UnionadConstants.bannerViewType,
      creationParams: _viewParams(creationParams),
      onPlatformViewCreated: onPlatformViewCreated,
      creationParamsCodec: const StandardMessageCodec(),
    );
  }

  @override
  Widget buildSplashAdView({
    required Map<String, dynamic> creationParams,
    required double width,
    required double height,
    required PlatformViewCreatedCallback onPlatformViewCreated,
  }) {
    return AndroidView(
      viewType: UnionadConstants.splashViewType,
      creationParams: _viewParams(creationParams),
      onPlatformViewCreated: onPlatformViewCreated,
      creationParamsCodec: const StandardMessageCodec(),
    );
  }

  @override
  Widget buildNativeAdView({
    required Map<String, dynamic> creationParams,
    required double width,
    required double height,
    required PlatformViewCreatedCallback onPlatformViewCreated,
  }) {
    return AndroidView(
      viewType: UnionadConstants.nativeViewType,
      creationParams: _viewParams(creationParams),
      onPlatformViewCreated: onPlatformViewCreated,
      creationParamsCodec: const StandardMessageCodec(),
    );
  }

  @override
  Widget buildDrawFeedAdView({
    required Map<String, dynamic> creationParams,
    required double width,
    required double height,
    required PlatformViewCreatedCallback onPlatformViewCreated,
  }) {
    return AndroidView(
      viewType: UnionadConstants.drawFeedViewType,
      creationParams: _viewParams(creationParams),
      onPlatformViewCreated: onPlatformViewCreated,
      creationParamsCodec: const StandardMessageCodec(),
    );
  }

  Map<String, dynamic> _androidParams(Map<String, dynamic> params) {
    return Map<String, dynamic>.from(params);
  }

  Map<String, dynamic> _viewParams(Map<String, dynamic> params) {
    return Map<String, dynamic>.from(params);
  }
}
