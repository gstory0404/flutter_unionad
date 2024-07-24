export 'package:flutter_unionad/flutter_unionad_code.dart';
export 'package:flutter_unionad/flutter_unionad_stream.dart';

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'bannerad/BannerAdView.dart';
import 'drawfeedad/DrawFeedAdView.dart';
import 'flutter_unionad_code.dart';
import 'nativead/NativeAdView.dart';
// import 'splashad/SplashAdView.dart';

part 'package:flutter_unionad/flutter_unionad_callback.dart';

part 'package:flutter_unionad/flutter_unionad_privacy.dart';

part 'package:flutter_unionad/splashad/SplashAdView.dart';

/// 描述：字节跳动 穿山甲广告flutter版
/// @author guozi
/// @e-mail gstory0404@gmail.com
/// @time   2020/3/11

class FlutterUnionad {
  static const MethodChannel _channel = const MethodChannel('flutter_unionad');

  /// # SDK注册初始化
  ///
  ///[androidAppId] 穿山甲广告 Android appid 必填
  ///
  ///[androidAppId] 穿山甲广告 ios appid 必填
  ///
  ///[appname] app名称 选填
  ///
  ///[useMediation] 使用聚合功能一定要打开此开关，否则不会请求聚合广告，默认这个值为false
  ///    true使用GroMore下的广告位
  //     false使用广告变现下的广告位
  ///
  ///[paid] 是否为计费用户 选填
  ///
  ///[keywords] 用户画像的关键词列表 选填
  ///
  ///[allowShowNotify] 是否允许sdk展示通知栏提示 选填
  ///
  ///[debug] 是否显示debug日志
  ///
  ///[supportMultiProcess] 是否支持多进程，true支持 选填
  ///
  ///[themeStatus] 主题模式  [FlutterUnionAdTheme] 选填
  ///
  ///[directDownloadNetworkType] 允许直接下载的网络状态集合 选填
  ///
  /// [androidPrivacy] Android隐私信息控制配置
  ///
  /// [iosPrivacy] ios隐私信息控制配置
  static Future<bool> register({
    required String iosAppId,
    required String androidAppId,
    String? appName,
    bool? useMediation,
    bool? paid,
    String? keywords,
    bool? useTextureView,
    bool? allowShowNotify,
    bool? debug,
    bool? supportMultiProcess,
    int? themeStatus,
    List<int>? directDownloadNetworkType,
    AndroidPrivacy? androidPrivacy,
    IOSPrivacy? iosPrivacy,
  }) async {
    return await _channel.invokeMethod("register", {
      "iosAppId": iosAppId,
      "androidAppId": androidAppId,
      "appName": appName ?? "",
      "paid": paid ?? false,
      "useMediation": useMediation ?? false,
      "keywords": keywords ?? "",
      "allowShowNotify": allowShowNotify ?? true,
      "debug": debug ?? false,
      "supportMultiProcess": supportMultiProcess ?? false,
      "themeStatus": themeStatus ?? FlutterUnionAdTheme.DAY,
      "directDownloadNetworkType": directDownloadNetworkType != null
          ? directDownloadNetworkType
          : [
              FlutterUnionadNetCode.NETWORK_STATE_MOBILE,
              FlutterUnionadNetCode.NETWORK_STATE_2G,
              FlutterUnionadNetCode.NETWORK_STATE_3G,
              FlutterUnionadNetCode.NETWORK_STATE_4G,
              FlutterUnionadNetCode.NETWORK_STATE_WIFI
            ],
      "androidPrivacy": androidPrivacy == null
          ? AndroidPrivacy().toMap()
          : androidPrivacy.toMap(),
      "iosPrivacy":
          iosPrivacy == null ? IOSPrivacy().toMap() : iosPrivacy.toMap()
    });
  }

  ///
  /// # 请求权限
  ///
  /// [FlutterUnionadPermissionCallBack] 权限申请回调
  ///
  static Future<void> requestPermissionIfNecessary(
      {FlutterUnionadPermissionCallBack? callBack}) async {
    switch (await _channel.invokeMethod("requestPermissionIfNecessary")) {
      //未确定
      case FlutterUnionadPermissionCode.notDetermined:
        callBack?.notDetermined!();
        break;
      //限制
      case FlutterUnionadPermissionCode.restricted:
        callBack?.restricted!();
        break;
      //拒绝
      case FlutterUnionadPermissionCode.denied:
        callBack?.denied!();
        break;
      //同意
      case FlutterUnionadPermissionCode.authorized:
        callBack?.authorized!();
        break;
    }
  }

  /// # 获取SDK版本号
  static Future<String> getSDKVersion() async {
    return await _channel.invokeMethod("getSDKVersion");
  }

  /// # banner广告
  ///
  /// [androidCodeId] andrrid banner广告id 必填
  ///
  /// [iosCodeId] ios banner广告id 必填
  ///
  /// [express] 是否使用个性化模版
  ///
  /// [supportDeepLink] 是否支持 DeepLink 选填
  ///
  /// [expressAdNum] 一次请求广告数量 大于1小于3 必填
  ///
  /// [expressTime] 轮播间隔事件 30-120秒  选填
  ///
  /// [expressViewWidth] 期望view宽度 dp 必填
  ///
  /// [expressViewHeight] 期望view高度 dp 必填
  ///
  /// [adLoadType]用于标注此次的广告请求用途为预加载（当做缓存）还是实时加载，[FlutterUnionadLoadType]
  ///
  /// [FlutterUnionAdBannerCallBack]  banner广告回调
  ///
  /// @Deprecated("推荐使用[FlutterUnionadBannerView],后续版本可能会移除改api")
  static Widget bannerAdView(
      {bool? mIsExpress,
      required String androidCodeId,
      required String iosCodeId,
      bool? supportDeepLink,
      int? expressAdNum,
      int? expressTime,
      required double? expressViewWidth,
      required double? expressViewHeight,
      int? downloadType,
      bool? isUserInteractionEnabled,
      int? adLoadType,
      FlutterUnionadBannerCallBack? callBack}) {
    return FlutterUnionadBannerView(
      androidCodeId: androidCodeId,
      iosCodeId: iosCodeId,
      width: expressViewWidth ?? 0,
      height: expressViewHeight ?? 0,
      callBack: callBack,
    );
  }

  /// # 开屏广告
  ///
  /// [mIsExpress] 是否使用个性化模版  设定widget宽高
  ///
  /// [androidCodeId] android 开屏广告广告id 必填
  ///
  /// [iosCodeId] ios 开屏广告广告id 必填
  ///
  /// [supportDeepLink] 是否支持 DeepLink 选填
  ///
  /// [expressViewWidth] 期望view 宽度 dp 选填 mIsExpress=true必填
  ///
  /// [expressViewHeight] 期望view高度 dp 选填 mIsExpress=true必填
  ///
  /// [FlutterUnionAdSplashCallBack] 开屏广告回调
  ///
  /// [adLoadType]用于标注此次的广告请求用途为预加载（当做缓存）还是实时加载，[FlutterUnionadLoadType]
  ///
  /// [timeout] 开屏广告加载超时时间,建议大于3000,这里为了冷启动第一次加载到广告并且展示,示例设置了3000ms
  ///
  /// [hideSkip] 是否影藏跳过按钮(当影藏的时候显示自定义跳过按钮) 默认显示
  ///
  static Widget splashAdView(
      {bool? mIsExpress,
      required String androidCodeId,
      required String iosCodeId,
      bool? supportDeepLink,
      double? expressViewWidth,
      double? expressViewHeight,
      int? downloadType,
      int? adLoadType,
      int? timeout,
      bool? hideSkip,
      FlutterUnionadSplashCallBack? callBack}) {
    return FlutterUnionadSplashAdView(
      androidCodeId: androidCodeId,
      iosCodeId: iosCodeId,
      supportDeepLink: supportDeepLink ?? true,
      width: expressViewWidth ?? 0.0,
      height: expressViewHeight ?? 0.0,
      timeout: timeout ?? 3000,
      hideSkip: hideSkip ?? false,
      callBack: callBack,
    );
  }

  /// # 信息流广告
  ///
  /// [mIsExpress] 是否使用个性化模版  设定widget宽高
  ///
  /// [androidCodeId] android 信息流广告id 必填
  ///
  /// [iosCodeId] ios 信息流广告id 必填
  ///
  /// [supportDeepLink] 是否支持 DeepLink 选填
  ///
  /// [expressViewWidth] 期望view 宽度 dp 必填
  ///
  /// [expressViewHeight] 期望view高度 dp 必填
  ///
  /// [adLoadType]用于标注此次的广告请求用途为预加载（当做缓存）还是实时加载，[FlutterUnionadLoadType]
  ///
  /// [FlutterUnionAdNativeCallBack] 信息流广告回调
  ///
  static Widget nativeAdView(
      {bool? mIsExpress,
      required String androidCodeId,
      required String iosCodeId,
      bool? supportDeepLink,
      required double expressViewWidth,
      required double expressViewHeight,
      int? downloadType,
      int? adLoadType,
      FlutterUnionadNativeCallBack? callBack}) {
    return FlutterUnionadNativeAdView(
      androidCodeId: androidCodeId,
      iosCodeId: iosCodeId,
      supportDeepLink: supportDeepLink ?? true,
      width: expressViewWidth,
      height: expressViewHeight,
      callBack: callBack,
    );
  }

  /// # 激励视频广告预加载 （模版渲染）
  ///
  /// [androidCodeId] android 激励视频广告id 必填
  ///
  /// [iosCodeId] ios 激励视频广告id 必填
  ///
  /// [supportDeepLink] 是否支持 DeepLink 选填
  ///
  /// [adLoadType]用于标注此次的广告请求用途为预加载（当做缓存）还是实时加载，[FlutterUnionadLoadType]
  ///
  static Future<bool> loadRewardVideoAd({
    required String androidCodeId,
    required String iosCodeId,
    required String rewardName,
    required int rewardAmount,
    required String userID,
    int? orientation,
    String? mediaExtra,
  }) async {
    return await _channel.invokeMethod("loadRewardVideoAd", {
      "androidCodeId": androidCodeId,
      "iosCodeId": iosCodeId,
      "rewardName": rewardName,
      "rewardAmount": rewardAmount,
      "userID": userID,
      "orientation": orientation ?? 0,
      "mediaExtra": mediaExtra ?? "",
    });
  }

  /// # 显示激励广告
  static Future<bool> showRewardVideoAd() async {
    return await _channel.invokeMethod("showRewardVideoAd", {});
  }

  /// # draw视频广告
  ///
  /// [mIsExpress] 是否使用个性化模版
  ///
  /// [androidCodeId] android draw视频广告id 必填
  ///
  /// [iosCodeId] ios draw视频广告 必填
  ///
  /// [supportDeepLink] 是否支持 DeepLink 选填
  ///
  /// [expressViewWidth] 期望view 宽度 dp 必填
  ///
  /// [expressViewHeight] 期望view高度 dp 必填
  ///
  /// [adLoadType]用于标注此次的广告请求用途为预加载（当做缓存）还是实时加载，[FlutterUnionadLoadType]
  ///
  /// [FlutterUnionAdDrawFeedCallBack] draw视频广告回调
  ///
  static Widget drawFeedAdView({
    bool? mIsExpress,
    required String androidCodeId,
    required String iosCodeId,
    bool? supportDeepLink,
    required double expressViewWidth,
    required double expressViewHeight,
    int? downloadType,
    int? adLoadType,
    FlutterUnionadDrawFeedCallBack? callBack,
  }) {
    return FlutterUnionadDrawFeedAdView(
      androidCodeId: androidCodeId,
      iosCodeId: iosCodeId,
      width: expressViewWidth,
      height: expressViewHeight,
      callBack: callBack,
    );
  }

  /// # 预加载新模板渲染插屏
  ///分为全屏和插屏，全屏和插屏场景下开发者都可以选择投放的广告类型，分别为图片+视频、仅视频、仅图片。
  static Future<bool> loadFullScreenVideoAdInteraction({
    required String androidCodeId,
    required String iosCodeId,
    int? orientation,
  }) async {
    return await _channel.invokeMethod("loadFullScreenVideoAdInteraction", {
      "androidCodeId": androidCodeId,
      "iosCodeId": iosCodeId,
      "orientation": orientation ?? FlutterUnionadOrientation.VERTICAL,
    });
  }

  ///显示新模板渲染插屏 分为全屏和插屏，全屏和插屏场景下开发者都可以选择投放的广告类型，分别为图片+视频、仅视频、仅图片。
  static Future<bool> showFullScreenVideoAdInteraction() async {
    return await _channel.invokeMethod("showFullScreenVideoAdInteraction", {});
  }

  /// 获取主题模式 0正常模式 1夜间模式
  static Future<int> getThemeStatus() async {
    return await _channel.invokeMethod("getThemeStatus");
  }
}
