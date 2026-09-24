import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:unionad_interface/unionad_interface.dart';

/// iOS 端广告实现：原生 [FlutterUnionadPlugin] + [UiKitView]。
class UnionadIOS extends MethodChannelUnionad {
  /// 由 Flutter 引擎在加载插件时调用，注入为当前平台实现。
  static void registerWith() {
    UnionadPlatform.instance = UnionadIOS();
  }

  @override
  Future<bool> register(Map<String, dynamic> params) {
    return super.register(_iosParams(params));
  }

  @override
  Future<bool> loadRewardVideoAd(Map<String, dynamic> params) {
    return super.loadRewardVideoAd(_iosParams(params));
  }

  @override
  Future<bool> loadFullScreenVideoAdInteraction(Map<String, dynamic> params) {
    return super.loadFullScreenVideoAdInteraction(_iosParams(params));
  }

  @override
  Widget buildBannerAdView({
    required Map<String, dynamic> creationParams,
    required double width,
    required double height,
    required PlatformViewCreatedCallback onPlatformViewCreated,
  }) {
    return UiKitView(
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
    return UiKitView(
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
    return UiKitView(
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
    return UiKitView(
      viewType: UnionadConstants.drawFeedViewType,
      creationParams: _viewParams(creationParams),
      onPlatformViewCreated: onPlatformViewCreated,
      creationParamsCodec: const StandardMessageCodec(),
    );
  }

  Map<String, dynamic> _iosParams(Map<String, dynamic> params) {
    return Map<String, dynamic>.from(params);
  }

  /// 原生 iOS 视图只关心 ios 相关字段
  Map<String, dynamic> _viewParams(Map<String, dynamic> params) {
    final result = Map<String, dynamic>.from(params);
    result.remove('androidCodeId');
    result.remove('ohosCodeId');
    return result;
  }
}
