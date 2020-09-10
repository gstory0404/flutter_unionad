import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_unionad/flutter_unionad_code.dart';

/// 描述：
/// @author guozi
/// @e-mail gstory0404@gmail.com
/// @time   2020/3/11

const MethodChannel _channel = const MethodChannel('flutter_unionad');
const EventChannel adeventEvent =
    EventChannel("com.gstory.flutter_unionad/adevent");

///sdk注册初始化
Future<bool> register({
  @required String appId,
  @required bool useTextureView,
  @required String appName,
  @required bool allowShowNotify,
  @required bool allowShowPageWhenScreenLock,
  @required bool debug,
  @required bool supportMultiProcess,
  List<int> directDownloadNetworkType,
}) async {
  return await _channel.invokeMethod("register", {
    "appId": appId,
    "useTextureView": useTextureView,
    "appName": appName,
    "allowShowNotify": allowShowNotify,
    "allowShowPageWhenScreenLock": allowShowPageWhenScreenLock,
    "debug": debug,
    "supportMultiProcess": supportMultiProcess,
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
    {String mCodeId,
    bool supportDeepLink,
    int expressAdNum,
    int expressTime,
    double expressViewWidth,
    double expressViewHeight}) {
  if (Platform.isAndroid) {
    return AndroidView(
      viewType: 'com.gstory.flutter_unionad/BannerExpressAdView',
      creationParams: {
        "mCodeId": mCodeId,
        "supportDeepLink": supportDeepLink,
        "expressViewWidth": expressViewWidth,
        "expressViewHeight": expressViewHeight,
        "expressAdNum": expressAdNum,
        "expressTime": expressTime
      },
      creationParamsCodec: const StandardMessageCodec(),
    );
  } else if (Platform.isIOS) {
    return UiKitView(
      viewType: "com.gstory.flutter_unionad/BannerExpressAdView",
      creationParams: {
        "mCodeId": mCodeId,
        "supportDeepLink": supportDeepLink,
        "expressViewWidth": expressViewWidth,
        "expressViewHeight": expressViewHeight,
        "expressAdNum": expressAdNum,
        "expressTime": expressTime
      },
      creationParamsCodec: const StandardMessageCodec(),
    );
  }
  return Container();
}

///开屏广告
Widget splashAdView(
    {String mCodeId,
    bool supportDeepLink,
    double expressViewWidth,
    double expressViewHeight,
    bool mIsExpress}) {
  if (Platform.isAndroid) {
    return AndroidView(
      viewType: 'com.gstory.flutter_unionad/SplashAdView',
      creationParams: {
        "mCodeId": mCodeId,
        "supportDeepLink": supportDeepLink,
        "expressViewWidth": expressViewWidth,
        "expressViewHeight": expressViewHeight,
        "mIsExpress": mIsExpress,
      },
      creationParamsCodec: const StandardMessageCodec(),
    );
  }
  return Container();
}

///个性化模板信息流广告
Widget nativeExpressAdView(
    {String mCodeId,
    bool supportDeepLink,
    double expressViewWidth,
    double expressViewHeight}) {
  if (Platform.isAndroid) {
    return AndroidView(
      viewType: 'com.gstory.flutter_unionad/NativeExpressAdView',
      creationParams: {
        "mCodeId": mCodeId,
        "supportDeepLink": supportDeepLink,
        "expressViewWidth": expressViewWidth,
        "expressViewHeight": expressViewHeight,
      },
      creationParamsCodec: const StandardMessageCodec(),
    );
  }
  return Container();
}

///个性化模板插屏广告
Future<bool> interactionExpressAd({
  @required String mCodeId,
  @required bool supportDeepLink,
  @required double expressViewWidth,
  @required double expressViewHeight,
}) async {
  return await _channel.invokeMethod("interactionExpressAd", {
    "mCodeId": mCodeId,
    "supportDeepLink": supportDeepLink,
    "expressViewWidth": expressViewWidth,
    "expressViewHeight": expressViewHeight,
  });
}

///个性化模板插屏广告
Widget interactionExpressAdView(
    {String mCodeId,
    bool supportDeepLink,
    double expressViewWidth,
    double expressViewHeight}) {
  if (Platform.isAndroid) {
    return AndroidView(
      viewType: 'com.gstory.flutter_unionad/InteractionExpressAdView',
      creationParams: {
        "mCodeId": mCodeId,
        "supportDeepLink": supportDeepLink,
        "expressViewWidth": expressViewWidth,
        "expressViewHeight": expressViewHeight,
      },
      creationParamsCodec: const StandardMessageCodec(),
    );
  }
  return Container();
}

///激励视频广告
Future<bool> loadRewardVideoAd({
  @required bool mIsExpress,
  @required String mCodeId,
  @required bool supportDeepLink,
  @required double expressViewWidth,
  @required double expressViewHeight,
  @required String rewardName,
  @required int rewardAmount,
  @required String userID,
  @required int orientation,
  @required String mediaExtra,
}) async {
  return await _channel.invokeMethod("loadRewardVideoAd", {
    "mIsExpress": mIsExpress,
    "mCodeId": mCodeId,
    "supportDeepLink": supportDeepLink,
    "expressViewWidth": expressViewWidth,
    "expressViewHeight": expressViewHeight,
    "rewardName": rewardName,
    "rewardAmount": rewardAmount,
    "userID": userID,
    "orientation": orientation,
    "mediaExtra": mediaExtra
  });
}

///draw视频广告
Widget drawFeedExpressAdView({
  String mCodeId,
  bool supportDeepLink,
  double expressViewWidth,
  double expressViewHeight,
}) {
  if (Platform.isAndroid) {
    return AndroidView(
      viewType: 'com.gstory.flutter_unionad/DrawFeedExpressAdView',
      creationParams: {
        "mCodeId": mCodeId,
        "supportDeepLink": supportDeepLink,
        "expressViewWidth": expressViewWidth,
        "expressViewHeight": expressViewHeight,
      },
      creationParamsCodec: const StandardMessageCodec(),
    );
  }
  return Container();
}
