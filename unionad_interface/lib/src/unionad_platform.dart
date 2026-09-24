import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'method_channel_unionad.dart';

/// flutter_unionad 平台接口
abstract class UnionadPlatform extends PlatformInterface {
  UnionadPlatform() : super(token: _token);

  static final Object _token = Object();

  static UnionadPlatform _instance = MethodChannelUnionad();

  /// 当前平台实现，默认为 [MethodChannelUnionad]
  static UnionadPlatform get instance => _instance;

  static set instance(UnionadPlatform instance) {
    PlatformInterface.verify(instance, _token);
    _instance = instance;
  }

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
}
