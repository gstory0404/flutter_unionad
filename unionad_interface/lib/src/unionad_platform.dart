import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'method_channel_unionad.dart';

/// flutter_unionad 平台接口：各端实现广告能力，主插件统一调度。
abstract class UnionadPlatform extends PlatformInterface {
  UnionadPlatform() : super(token: _token);

  static final Object _token = Object();

  static UnionadPlatform _instance = MethodChannelUnionad();

  /// 当前平台实现（由 android/ios/ohos 的 [registerWith] 注入）
  static UnionadPlatform get instance => _instance;

  static set instance(UnionadPlatform instance) {
    PlatformInterface.verify(instance, _token);
    _instance = instance;
  }

  // ---------- MethodChannel 广告能力 ----------

  /// SDK 注册初始化
  Future<bool> register(Map<String, dynamic> params) {
    throw UnimplementedError('register() has not been implemented.');
  }

  /// 请求权限
  Future<int> requestPermissionIfNecessary() {
    throw UnimplementedError(
        'requestPermissionIfNecessary() has not been implemented.');
  }

  /// 获取 SDK 版本号
  Future<String> getSDKVersion() {
    throw UnimplementedError('getSDKVersion() has not been implemented.');
  }

  /// 预加载激励视频
  Future<bool> loadRewardVideoAd(Map<String, dynamic> params) {
    throw UnimplementedError('loadRewardVideoAd() has not been implemented.');
  }

  /// 展示激励视频
  Future<bool> showRewardVideoAd() {
    throw UnimplementedError('showRewardVideoAd() has not been implemented.');
  }

  /// 预加载新模板渲染插屏
  Future<bool> loadFullScreenVideoAdInteraction(Map<String, dynamic> params) {
    throw UnimplementedError(
        'loadFullScreenVideoAdInteraction() has not been implemented.');
  }

  /// 展示新模板渲染插屏
  Future<bool> showFullScreenVideoAdInteraction() {
    throw UnimplementedError(
        'showFullScreenVideoAdInteraction() has not been implemented.');
  }

  /// 获取主题模式 0正常 1夜间
  Future<int> getThemeStatus() {
    throw UnimplementedError('getThemeStatus() has not been implemented.');
  }

  /// 广告事件流
  Stream<dynamic> get adEventStream {
    throw UnimplementedError('adEventStream has not been implemented.');
  }

  // ---------- PlatformView 广告视图（各端各自实现） ----------

  /// Banner 广告原生视图
  Widget buildBannerAdView({
    required Map<String, dynamic> creationParams,
    required double width,
    required double height,
    required PlatformViewCreatedCallback onPlatformViewCreated,
  }) {
    throw UnimplementedError('buildBannerAdView() has not been implemented.');
  }

  /// 开屏广告原生视图
  Widget buildSplashAdView({
    required Map<String, dynamic> creationParams,
    required double width,
    required double height,
    required PlatformViewCreatedCallback onPlatformViewCreated,
  }) {
    throw UnimplementedError('buildSplashAdView() has not been implemented.');
  }

  /// 信息流广告原生视图
  Widget buildNativeAdView({
    required Map<String, dynamic> creationParams,
    required double width,
    required double height,
    required PlatformViewCreatedCallback onPlatformViewCreated,
  }) {
    throw UnimplementedError('buildNativeAdView() has not been implemented.');
  }

  /// Draw 信息流广告原生视图
  Widget buildDrawFeedAdView({
    required Map<String, dynamic> creationParams,
    required double width,
    required double height,
    required PlatformViewCreatedCallback onPlatformViewCreated,
  }) {
    throw UnimplementedError('buildDrawFeedAdView() has not been implemented.');
  }
}
