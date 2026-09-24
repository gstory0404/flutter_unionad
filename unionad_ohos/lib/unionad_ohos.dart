import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:unionad_interface/unionad_interface.dart';

import 'src/ohos_platform_view.dart';

/// 鸿蒙端广告实现：原生 [FlutterUnionadPlugin] + [OhosView]。
class UnionadOhos extends MethodChannelUnionad {
  /// 由 Flutter 引擎在加载插件时调用，注入为当前平台实现。
  static void registerWith() {
    UnionadPlatform.instance = UnionadOhos();
  }

  @override
  Future<bool> register(Map<String, dynamic> params) {
    return super.register(_ohosParams(params));
  }

  @override
  Future<bool> loadRewardVideoAd(Map<String, dynamic> params) {
    return super.loadRewardVideoAd(_ohosParams(params));
  }

  @override
  Future<bool> loadFullScreenVideoAdInteraction(Map<String, dynamic> params) {
    return super.loadFullScreenVideoAdInteraction(_ohosParams(params));
  }

  @override
  Widget buildBannerAdView({
    required Map<String, dynamic> creationParams,
    required double width,
    required double height,
    required PlatformViewCreatedCallback onPlatformViewCreated,
  }) {
    return buildOhosPlatformView(
      viewType: UnionadConstants.bannerViewType,
      creationParams: _viewParams(creationParams),
      onPlatformViewCreated: onPlatformViewCreated,
    );
  }

  @override
  Widget buildSplashAdView({
    required Map<String, dynamic> creationParams,
    required double width,
    required double height,
    required PlatformViewCreatedCallback onPlatformViewCreated,
  }) {
    return buildOhosPlatformView(
      viewType: UnionadConstants.splashViewType,
      creationParams: _viewParams(creationParams),
      onPlatformViewCreated: onPlatformViewCreated,
    );
  }

  @override
  Widget buildNativeAdView({
    required Map<String, dynamic> creationParams,
    required double width,
    required double height,
    required PlatformViewCreatedCallback onPlatformViewCreated,
  }) {
    // 鸿蒙端暂未实现信息流原生视图
    return const SizedBox.shrink();
  }

  @override
  Widget buildDrawFeedAdView({
    required Map<String, dynamic> creationParams,
    required double width,
    required double height,
    required PlatformViewCreatedCallback onPlatformViewCreated,
  }) {
    // 鸿蒙端暂未实现 Draw 信息流原生视图
    return const SizedBox.shrink();
  }

  Map<String, dynamic> _ohosParams(Map<String, dynamic> params) {
    return Map<String, dynamic>.from(params);
  }

  Map<String, dynamic> _viewParams(Map<String, dynamic> params) {
    return Map<String, dynamic>.from(params);
  }
}
