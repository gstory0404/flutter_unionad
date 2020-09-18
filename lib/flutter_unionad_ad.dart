import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_unionad/flutter_unionad_code.dart';
import 'package:flutter/foundation.dart';

/// 描述：
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
  @required bool useTextureView,
  @required String appName,
  @required bool allowShowNotify,
  @required bool allowShowPageWhenScreenLock,
  @required bool debug,
  @required bool supportMultiProcess,
  List<int> directDownloadNetworkType,
}) async {
  return await _channel.invokeMethod("register", {
    "iosAppId": iosAppId,
    "androidAppId": androidAppId,
    "useTextureView": useTextureView == null ? false : useTextureView,
    "appName": appName == null ? "" : appName,
    "allowShowNotify": allowShowNotify == null ? false : allowShowNotify,
    "allowShowPageWhenScreenLock": allowShowPageWhenScreenLock == null
        ? false
        : allowShowPageWhenScreenLock,
    "debug": debug == null ? false : debug,
    "supportMultiProcess":
        supportMultiProcess == null ? false : supportMultiProcess,
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
      String mCodeId,
    bool supportDeepLink,
    int expressAdNum,
    int expressTime,
    double expressViewWidth,
    double expressViewHeight}) {
  if (defaultTargetPlatform == TargetPlatform.android) {
    return AndroidView(
      viewType: 'com.gstory.flutter_unionad/BannerAdView',
      creationParams: {
        "mIsExpress": mIsExpress,
        "mCodeId": mCodeId,
        "supportDeepLink": supportDeepLink == null ? true : supportDeepLink,
        "expressViewWidth": expressViewWidth,
        "expressViewHeight": expressViewHeight,
        "expressAdNum": expressAdNum == null ? 1 : expressAdNum,
        "expressTime": expressTime == null ? 0 : expressTime
      },
      creationParamsCodec: const StandardMessageCodec(),
    );
  } else if (defaultTargetPlatform == TargetPlatform.iOS) {
    return UiKitView(
      viewType: "com.gstory.flutter_unionad/BannerAdView",
      creationParams: {
        "mIsExpress": mIsExpress,
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
    {bool mIsExpress,
    String mCodeId,
    bool supportDeepLink,
    double expressViewWidth,
    double expressViewHeight}) {
  if (defaultTargetPlatform == TargetPlatform.android) {
    return AndroidView(
      viewType: 'com.gstory.flutter_unionad/SplashAdView',
      creationParams: {
        "mIsExpress": mIsExpress,
        "mCodeId": mCodeId,
        "supportDeepLink": supportDeepLink,
        "expressViewWidth": expressViewWidth,
        "expressViewHeight": expressViewHeight,
      },
      creationParamsCodec: const StandardMessageCodec(),
    );
  } else if (defaultTargetPlatform == TargetPlatform.iOS) {
    return Container();
  }
  return Container();
}

///信息流广告
Widget nativeAdView(
    {bool mIsExpress,
    String mCodeId,
    bool supportDeepLink,
    double expressViewWidth,
    double expressViewHeight}) {
  if (defaultTargetPlatform == TargetPlatform.android) {
    return AndroidView(
      viewType: 'com.gstory.flutter_unionad/NativeAdView',
      creationParams: {
        "mIsExpress": mIsExpress,
        "mCodeId": mCodeId,
        "supportDeepLink": supportDeepLink,
        "expressViewWidth": expressViewWidth,
        "expressViewHeight": expressViewHeight,
      },
      creationParamsCodec: const StandardMessageCodec(),
    );
  } else if (defaultTargetPlatform == TargetPlatform.iOS) {
    return Container();
  }
  return Container();
}

///插屏广告
Future<bool> interactionAd({
  @required bool mIsExpress,
  @required String mCodeId,
  @required bool supportDeepLink,
  @required double expressViewWidth,
  @required double expressViewHeight,
}) async {
  return await _channel.invokeMethod("interactionAd", {
    "mIsExpress": mIsExpress,
    "mCodeId": mCodeId,
    "supportDeepLink": supportDeepLink,
    "expressViewWidth": expressViewWidth,
    "expressViewHeight": expressViewHeight,
  });
}

///个性化模板插屏广告
Widget interactionAdView(
    {bool mIsExpress,
    String mCodeId,
    bool supportDeepLink,
    double expressViewWidth,
    double expressViewHeight}) {
  if (defaultTargetPlatform == TargetPlatform.android) {
    return AndroidView(
      viewType: 'com.gstory.flutter_unionad/InteractionAdView',
      creationParams: {
        "mIsExpress": mIsExpress,
        "mCodeId": mCodeId,
        "supportDeepLink": supportDeepLink,
        "expressViewWidth": expressViewWidth,
        "expressViewHeight": expressViewHeight,
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
Widget drawFeedAdView({
  @required bool mIsExpress,
  String mCodeId,
  bool supportDeepLink,
  double expressViewWidth,
  double expressViewHeight,
}) {
  if (defaultTargetPlatform == TargetPlatform.android) {
    return AndroidView(
      viewType: 'com.gstory.flutter_unionad/DrawFeedAdView',
      creationParams: {
        "mIsExpress": mIsExpress,
        "mCodeId": mCodeId,
        "supportDeepLink": supportDeepLink,
        "expressViewWidth": expressViewWidth,
        "expressViewHeight": expressViewHeight,
      },
      creationParamsCodec: const StandardMessageCodec(),
    );
  } else if (defaultTargetPlatform == TargetPlatform.iOS) {
    return Container();
  }
  return Container();
}

///个性化模板全屏广告
Future<bool> fullScreenVideoAd(
    {@required bool mIsExpress,
    @required String mCodeId,
    @required bool supportDeepLink,
    @required int orientation}) async {
  return await _channel.invokeMethod("fullScreenVideoAd", {
    "mIsExpress": mIsExpress,
    "mCodeId": mCodeId,
    "supportDeepLink": supportDeepLink,
    "orientation": orientation,
  });
}
