export 'package:flutter_unionad/flutter_unionad_code.dart';
export 'package:flutter_unionad/flutter_unionad_stream.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'bannerad/BannerAdView.dart';
import 'drawfeedad/DrawFeedAdView.dart';
import 'flutter_unionad_code.dart';
import 'nativead/NativeAdView.dart';
import 'splashad/SplashAdView.dart';

part 'package:flutter_unionad/flutter_unionad_callback.dart';

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
  ///[useTextureView] 使用TextureView控件播放视频,默认为SurfaceView,当有SurfaceView冲突的场景，可以使用TextureView 选填
  ///
  ///[appname] 必填
  ///
  ///[allowShowNotify] 是否允许sdk展示通知栏提示 选填
  ///
  ///[allowShowPageWhenScreenLock] 是否在锁屏场景支持展示广告落地页 选填
  ///
  ///[debug] 是否显示debug日志
  ///
  ///[supportMultiProcess] 是否支持多进程，true支持 选填
  ///
  ///[directDownloadNetworkType] 允许直接下载的网络状态集合 选填
  ///
  static Future<bool> register({
    required String iosAppId,
    required String androidAppId,
    bool? useTextureView,
    required String appName,
    bool? allowShowNotify,
    bool? allowShowPageWhenScreenLock,
    bool? debug,
    bool? supportMultiProcess,
    List<int>? directDownloadNetworkType,
  }) async {
    return await _channel.invokeMethod("register", {
      "iosAppId": iosAppId,
      "androidAppId": androidAppId,
      "useTextureView": useTextureView ?? false,
      "appName": appName,
      "allowShowNotify": allowShowNotify ?? true,
      "allowShowPageWhenScreenLock": allowShowPageWhenScreenLock ?? false,
      "debug": debug ?? false,
      "supportMultiProcess": supportMultiProcess ?? false,
      "directDownloadNetworkType": directDownloadNetworkType != null
          ? directDownloadNetworkType
          : [
              FlutterUnionadNetCode.NETWORK_STATE_MOBILE,
              FlutterUnionadNetCode.NETWORK_STATE_2G,
              FlutterUnionadNetCode.NETWORK_STATE_3G,
              FlutterUnionadNetCode.NETWORK_STATE_4G,
              FlutterUnionadNetCode.NETWORK_STATE_WIFI
            ]
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
  /// [FlutterUnionAdBannerCallBack]  banner广告回调
  ///
  static Widget bannerAdView(
      {bool? mIsExpress,
      required String androidCodeId,
      required String iosCodeId,
      bool? supportDeepLink,
      required int expressAdNum,
      int? expressTime,
      required double? expressViewWidth,
      required double? expressViewHeight,
      int? downloadType,
      FlutterUnionadBannerCallBack? callBack}) {
    return BannerAdView(
      mIsExpress: mIsExpress ?? false,
      androidCodeId: androidCodeId,
      iosCodeId: iosCodeId,
      supportDeepLink: supportDeepLink ?? true,
      expressViewWidth: expressViewWidth ?? 0,
      expressViewHeight: expressViewHeight ?? 0,
      expressAdNum: expressAdNum,
      expressTime: expressTime ?? 30,
      downloadType:
          downloadType ?? FlutterUnionadDownLoadType.DOWNLOAD_TYPE_POPUP,
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
  static Widget splashAdView(
      {bool? mIsExpress,
      required String androidCodeId,
      required String iosCodeId,
      bool? supportDeepLink,
      double? expressViewWidth,
      double? expressViewHeight,
      int? downloadType,
      FlutterUnionadSplashCallBack? callBack}) {
    return SplashAdView(
      mIsExpress: mIsExpress ?? false,
      androidCodeId: androidCodeId,
      iosCodeId: iosCodeId,
      supportDeepLink: supportDeepLink ?? true,
      expressViewWidth: expressViewWidth ?? 0.0,
      expressViewHeight: expressViewHeight ?? 0.0,
      downloadType:
          downloadType ?? FlutterUnionadDownLoadType.DOWNLOAD_TYPE_POPUP,
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
  /// [FlutterUnionAdNativeCallBack] 信息流广告回调
  ///
  static Widget nativeAdView(
      {bool? mIsExpress,
      required String androidCodeId,
      required String iosCodeId,
      bool? supportDeepLink,
      required double expressViewWidth,
      required double expressViewHeight,
      required int expressNum,
      int? downloadType,
      FlutterUnionadNativeCallBack? callBack}) {
    return NativeAdView(
      mIsExpress: mIsExpress ?? false,
      androidCodeId: androidCodeId,
      iosCodeId: iosCodeId,
      supportDeepLink: supportDeepLink ?? true,
      expressViewWidth: expressViewWidth,
      expressViewHeight: expressViewHeight,
      expressNum: expressNum,
      downloadType:
          downloadType ?? FlutterUnionadDownLoadType.DOWNLOAD_TYPE_POPUP,
      callBack: callBack,
    );
  }

  /// # 插屏广告
  ///
  /// [mIsExpress] 是否使用个性化模版
  ///
  /// [androidCodeId] android 插屏广告id 必填
  ///
  /// [iosCodeId] ios 插屏广告id 必填
  ///
  /// [supportDeepLink] 是否支持 DeepLink 选填
  ///
  /// [expressViewWidth] 期望view 宽度 dp 必填
  ///
  /// [expressViewHeight] 期望view高度 dp 必填
  ///
  /// [callBack] 插屏广告回调
  ///
  @Deprecated("推荐使用新模板渲染插屏 loadFullScreenVideoAdInteraction")
  static Future<bool> interactionAd({
    bool? mIsExpress,
    required String androidCodeId,
    required String iosCodeId,
    bool? supportDeepLink,
    required double expressViewWidth,
    required double expressViewHeight,
    required int expressNum,
    int? downloadType,
  }) async {
    return await _channel.invokeMethod("interactionAd", {
      "mIsExpress": mIsExpress ?? false,
      "androidCodeId": androidCodeId,
      "iosCodeId": iosCodeId,
      "supportDeepLink": supportDeepLink ?? true,
      "expressViewWidth": expressViewWidth,
      "expressViewHeight": expressViewHeight,
      "expressNum": expressNum,
      "downloadType": downloadType,
    });
  }

  /// # 激励视频广告预加载
  ///
  /// [mIsExpress] 是否使用个性化模版
  ///
  /// [androidCodeId] android 激励视频广告id 必填
  ///
  /// [iosCodeId] ios 激励视频广告id 必填
  ///
  /// [supportDeepLink] 是否支持 DeepLink 选填
  ///
  /// [expressViewWidth] 期望view 宽度 dp 必填
  ///
  /// [expressViewHeight] 期望view高度 dp 必填
  ///
  static Future<bool> loadRewardVideoAd({
    bool? mIsExpress,
    required String androidCodeId,
    required String iosCodeId,
    bool? supportDeepLink,
    double? expressViewWidth,
    double? expressViewHeight,
    required String rewardName,
    required int rewardAmount,
    required String userID,
    int? orientation,
    String? mediaExtra,
    int? downloadType,
  }) async {
    return await _channel.invokeMethod("loadRewardVideoAd", {
      "mIsExpress": mIsExpress ?? false,
      "androidCodeId": androidCodeId,
      "iosCodeId": iosCodeId,
      "supportDeepLink": supportDeepLink ?? true,
      "expressViewWidth": expressViewWidth ?? 750,
      "expressViewHeight": expressViewHeight ?? 1080,
      "rewardName": rewardName,
      "rewardAmount": rewardAmount,
      "userID": userID,
      "orientation": orientation ?? 0,
      "mediaExtra": mediaExtra ?? "",
      "downloadType":
          downloadType ?? FlutterUnionadDownLoadType.DOWNLOAD_TYPE_POPUP
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
    FlutterUnionadDrawFeedCallBack? callBack,
  }) {
    return DrawFeedAdView(
      mIsExpress: mIsExpress ?? false,
      androidCodeId: androidCodeId,
      iosCodeId: iosCodeId,
      supportDeepLink: supportDeepLink ?? true,
      expressViewWidth: expressViewWidth,
      expressViewHeight: expressViewHeight,
      downloadType:
          downloadType ?? FlutterUnionadDownLoadType.DOWNLOAD_TYPE_POPUP,
      callBack: callBack,
    );
  }

  ///个性化模板全屏广告
  @Deprecated("推荐使用新模板渲染插屏 loadFullScreenVideoAdInteraction")
  static Future<bool> fullScreenVideoAd({
    bool? mIsExpress,
    required String androidCodeId,
    required String iosCodeId,
    bool? supportDeepLink,
    int? orientation,
    int? downloadType,
  }) async {
    return await _channel.invokeMethod("fullScreenVideoAd", {
      "mIsExpress": mIsExpress ?? false,
      "androidCodeId": androidCodeId,
      "iosCodeId": iosCodeId,
      "supportDeepLink": supportDeepLink ?? true,
      "orientation": orientation ?? FlutterUnionadOrientation.VERTICAL,
      "downloadType":
          downloadType ?? FlutterUnionadDownLoadType.DOWNLOAD_TYPE_POPUP,
    });
  }

  /// # 预加载新模板渲染插屏
  ///分为全屏和插屏，全屏和插屏场景下开发者都可以选择投放的广告类型，分别为图片+视频、仅视频、仅图片。
  static Future<bool> loadFullScreenVideoAdInteraction({
    required String androidCodeId,
    required String iosCodeId,
    bool? supportDeepLink,
    int? orientation,
    int? downloadType,
  }) async {
    return await _channel.invokeMethod("loadFullScreenVideoAdInteraction", {
      "androidCodeId": androidCodeId,
      "iosCodeId": iosCodeId,
      "supportDeepLink": supportDeepLink ?? true,
      "orientation": orientation ?? FlutterUnionadOrientation.VERTICAL,
      "downloadType":
          downloadType ?? FlutterUnionadDownLoadType.DOWNLOAD_TYPE_POPUP,
    });
  }

  ///显示新模板渲染插屏 分为全屏和插屏，全屏和插屏场景下开发者都可以选择投放的广告类型，分别为图片+视频、仅视频、仅图片。
  static Future<bool> showFullScreenVideoAdInteraction() async {
    return await _channel.invokeMethod("showFullScreenVideoAdInteraction", {});
  }

  ///隐私信息控制开关 只有android起效
  ///
  ///isCanUseLocation 是否允许SDK主动使用地理位置信息 true可以获取，false禁止获取。默认为true
  ///
  ///lat 当isCanUseLocation=false时，可传入地理位置信息，穿山甲sdk使用您传入的地理位置信息lat
  ///
  ///lon 当isCanUseLocation=false时，可传入地理位置信息，穿山甲sdk使用您传入的地理位置信息lon
  ///
  ///isCanUsePhoneState 是否允许SDK主动使用手机硬件参数，如：imei
  ///
  ///imei 当isCanUsePhoneState=false时，可传入imei信息，穿山甲sdk使用您传入的imei信息
  ///
  ///isCanUseWifiState 是否允许SDK主动使用ACCESS_WIFI_STATE权限
  ///
  ///isCanUseWriteExternal 是否允许SDK主动使用WRITE_EXTERNAL_STORAGE权限
  ///
  ///oaid 开发者可以传入oaid
  static Future<bool> andridPrivacy(
      {bool? isCanUseLocation,
      double? lat,
      double? lon,
      bool? isCanUsePhoneState,
      String? imei,
      bool? isCanUseWifiState,
      bool? isCanUseWriteExternal,
      String? oaid}) async {
    return await _channel.invokeMethod("andridPrivacy", {
      "isCanUseLocation": isCanUseLocation ?? true,
      "lat": lat ?? 0.0,
      "lon": lon ?? 0.0,
      "isCanUsePhoneState": isCanUsePhoneState ?? true,
      "imei": imei ?? "",
      "isCanUseWifiState": isCanUseWifiState ?? true,
      "isCanUseWriteExternal": isCanUseWriteExternal ?? true,
      "oaid": oaid ?? "",
    });
  }
}
