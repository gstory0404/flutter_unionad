import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_unionad/bannerad/BannerAdView.dart';
import 'package:flutter_unionad/drawfeedad/DrawFeedAdView.dart';
import 'package:flutter_unionad/flutter_unionad_code.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_unionad/nativead/NativeAdView.dart';
import 'package:flutter_unionad/splashad/SplashAdView.dart';

/// 描述：字节跳动 穿山甲广告flutter版
/// @author guozi
/// @e-mail gstory0404@gmail.com
/// @time   2020/3/11
const MethodChannel _channel = const MethodChannel('flutter_unionad');
const EventChannel adeventEvent =
    EventChannel("com.gstory.flutter_unionad/adevent");

///sdk注册初始化
Future<bool> register({
  @required String iosAppId,
  @required String androidAppId,
  bool useTextureView,
  String appName,
  bool allowShowNotify,
  bool allowShowPageWhenScreenLock,
  bool debug,
  bool supportMultiProcess,
  List<int> directDownloadNetworkType,
}) async {
  return await _channel.invokeMethod("register", {
    "iosAppId": iosAppId,
    "androidAppId": androidAppId,
    "useTextureView": useTextureView ?? false,
    "appName": appName ?? "",
    "allowShowNotify": allowShowNotify ?? true,
    "allowShowPageWhenScreenLock": allowShowPageWhenScreenLock ?? false,
    "debug": debug ?? false,
    "supportMultiProcess": supportMultiProcess ?? false,
    "directDownloadNetworkType": directDownloadNetworkType != null ||
            directDownloadNetworkType.length > 0
        ? directDownloadNetworkType
        : [
            NETWORK_STATE_MOBILE,
            NETWORK_STATE_2G,
            NETWORK_STATE_3G,
            NETWORK_STATE_4G,
            NETWORK_STATE_WIFI
          ]
  });
}

///请求权限
Future<bool> requestPermissionIfNecessary() async {
  return await _channel.invokeMethod("requestPermissionIfNecessary");
}

///获取SDK版本号
Future<String> getSDKVersion() async {
  return await _channel.invokeMethod("getSDKVersion");
}

///banner广告
Widget bannerAdView(
    {bool mIsExpress,
    @required String androidCodeId,
    @required String iosCodeId,
    bool supportDeepLink,
    int expressAdNum,
    int expressTime,
    double expressViewWidth,
    double expressViewHeight,
    callBack}) {
  return BannerAdView(
    mIsExpress: mIsExpress ?? false,
    androidCodeId: androidCodeId,
    iosCodeId: iosCodeId,
    supportDeepLink: supportDeepLink ?? true,
    expressViewWidth: expressViewWidth ?? 400,
    expressViewHeight: expressViewHeight ?? 200,
    expressAdNum: expressAdNum ?? 1,
    expressTime: expressTime ?? 0,
    callBack: callBack,
  );
}

///开屏广告
Widget splashAdView(
    {bool mIsExpress,
    @required String androidCodeId,
    @required String iosCodeId,
    bool supportDeepLink,
    double expressViewWidth,
    double expressViewHeight,
    callBack}) {
  return SplashAdView(
    mIsExpress: mIsExpress ?? false,
    androidCodeId: androidCodeId,
    iosCodeId: iosCodeId,
    supportDeepLink: supportDeepLink ?? true,
    expressViewWidth: expressViewWidth ?? 400,
    expressViewHeight: expressViewHeight ?? 200,
    callBack: callBack,
  );
}

///信息流广告
Widget nativeAdView(
    {String mIsExpress,
    @required String androidCodeId,
    @required String iosCodeId,
    bool supportDeepLink,
    @required double expressViewWidth,
    @required double expressViewHeight,
    callBack}) {
  return NativeAdView(
    mIsExpress: mIsExpress ?? false,
    androidCodeId: androidCodeId,
    iosCodeId: iosCodeId,
    supportDeepLink: supportDeepLink ?? true,
    expressViewWidth: expressViewWidth ?? 200,
    expressViewHeight: expressViewHeight ?? 100,
    callBack: callBack,
  );
}

///插屏广告
Future<bool> interactionAd({
  bool mIsExpress,
  @required String androidCodeId,
  @required String iosCodeId,
  bool supportDeepLink,
  double expressViewWidth,
  double expressViewHeight,
}) async {
  return await _channel.invokeMethod("interactionAd", {
    "mIsExpress": mIsExpress ?? false,
    "androidCodeId": androidCodeId,
    "iosCodeId": iosCodeId,
    "supportDeepLink": supportDeepLink ?? true,
    "expressViewWidth": expressViewWidth ?? 200,
    "expressViewHeight": expressViewHeight ?? 300,
  });
}

///个性化模板插屏广告
Widget interactionAdView(
    {bool mIsExpress,
    @required String androidCodeId,
    @required String iosCodeId,
    bool supportDeepLink,
    double expressViewWidth,
    double expressViewHeight}) {
  if (defaultTargetPlatform == TargetPlatform.android) {
    return AndroidView(
      viewType: 'com.gstory.flutter_unionad/InteractionAdView',
      creationParams: {
        "mIsExpress": mIsExpress ?? false,
        "androidCodeId": androidCodeId,
        "supportDeepLink": supportDeepLink ?? true,
        "expressViewWidth": expressViewWidth ?? 300,
        "expressViewHeight": expressViewHeight ?? 400,
      },
      creationParamsCodec: const StandardMessageCodec(),
    );
  } else if (defaultTargetPlatform == TargetPlatform.iOS) {
    return Container();
  }
  return Container();
}

///激励视频广告
Future<bool> loadRewardVideoAd({
  bool mIsExpress,
  @required String androidCodeId,
  @required String iosCodeId,
  bool supportDeepLink,
  double expressViewWidth,
  double expressViewHeight,
  @required String rewardName,
  @required int rewardAmount,
  @required String userID,
  int orientation,
  @required String mediaExtra,
}) async {
  return await _channel.invokeMethod("loadRewardVideoAd", {
    "mIsExpress": mIsExpress == null ? false : mIsExpress,
    "androidCodeId": androidCodeId,
    "iosCodeId": iosCodeId,
    "supportDeepLink": supportDeepLink ?? true,
    "expressViewWidth": expressViewWidth ?? 750,
    "expressViewHeight": expressViewHeight ?? 1080,
    "rewardName": rewardName ?? "",
    "rewardAmount": rewardAmount ?? 0,
    "userID": userID ?? "",
    "orientation": orientation ?? 0,
    "mediaExtra": mediaExtra ?? ""
  });
}

///draw视频广告
Widget drawFeedAdView({
  bool mIsExpress,
  @required String androidCodeId,
  @required String iosCodeId,
  bool supportDeepLink,
  double expressViewWidth,
  double expressViewHeight,
  callBack,
}) {
  return DrawFeedAdView(
    mIsExpress: mIsExpress ?? false,
    androidCodeId: androidCodeId,
    iosCodeId: iosCodeId,
    supportDeepLink: supportDeepLink ?? true,
    expressViewWidth: expressViewWidth ?? 720,
    expressViewHeight: expressViewHeight ?? 1080,
    callBack: callBack,
  );
}

///个性化模板全屏广告
Future<bool> fullScreenVideoAd(
    {bool mIsExpress,
    @required String androidCodeId,
    @required String iosCodeId,
    bool supportDeepLink,
    int orientation}) async {
  return await _channel.invokeMethod("fullScreenVideoAd", {
    "mIsExpress": mIsExpress ?? false,
    "androidCodeId": androidCodeId,
    "iosCodeId": iosCodeId,
    "supportDeepLink": supportDeepLink ?? true,
    "orientation": orientation ?? VideoVERTICAL,
  });
}
