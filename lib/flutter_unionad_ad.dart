import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_unionad/flutter_unionad_code.dart';
import 'package:flutter/foundation.dart';

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
    @required String mCodeId,
    bool supportDeepLink,
    int expressAdNum,
    int expressTime,
    double expressViewWidth,
    double expressViewHeight}) {
  if (defaultTargetPlatform == TargetPlatform.android) {
    return AndroidView(
      viewType: 'com.gstory.flutter_unionad/BannerAdView',
      creationParams: {
        "mIsExpress": mIsExpress == null ? false : mIsExpress,
        "mCodeId": mCodeId,
        "supportDeepLink": supportDeepLink == null ? true : supportDeepLink,
        "expressViewWidth": expressViewWidth == null ? 0 : expressViewWidth,
        "expressViewHeight": expressViewHeight == null ? 0 : expressViewHeight,
        "expressAdNum": expressAdNum == null ? 1 : expressAdNum,
        "expressTime": expressTime == null ? 0 : expressTime
      },
      creationParamsCodec: const StandardMessageCodec(),
    );
  } else if (defaultTargetPlatform == TargetPlatform.iOS) {
    return UiKitView(
      viewType: "com.gstory.flutter_unionad/BannerAdView",
      creationParams: {
        "mIsExpress": mIsExpress == null ? false : mIsExpress,
        "mCodeId": mCodeId,
        "supportDeepLink": supportDeepLink == null ? true : supportDeepLink,
        "expressViewWidth": expressViewWidth == null ? 0 : expressViewWidth,
        "expressViewHeight": expressViewHeight == null ? 0 : expressViewHeight,
        "expressAdNum": expressAdNum == null ? 1 : expressAdNum,
        "expressTime": expressTime == null ? 0 : expressTime
      },
      creationParamsCodec: const StandardMessageCodec(),
    );
  }
  return Container();
}

///开屏广告
Widget splashAdView(
    {bool mIsExpress,
    @required String mCodeId,
    bool supportDeepLink,
    double expressViewWidth,
    double expressViewHeight}) {
  if (defaultTargetPlatform == TargetPlatform.android) {
    return AndroidView(
      viewType: 'com.gstory.flutter_unionad/SplashAdView',
      creationParams: {
        "mIsExpress": mIsExpress == null ? false : mIsExpress,
        "mCodeId": mCodeId,
        "supportDeepLink": supportDeepLink == null ? true : supportDeepLink,
        "expressViewWidth": expressViewWidth == null ? 0 : expressViewWidth,
        "expressViewHeight": expressViewHeight == null ? 0 : expressViewHeight,
      },
      creationParamsCodec: const StandardMessageCodec(),
    );
  } else if (defaultTargetPlatform == TargetPlatform.iOS) {
    return UiKitView(
      viewType: "com.gstory.flutter_unionad/SplashAdView",
      creationParams: {
        "mIsExpress": mIsExpress == null ? false : mIsExpress,
        "mCodeId": mCodeId,
        "supportDeepLink": supportDeepLink == null ? true : supportDeepLink,
        "expressViewWidth": expressViewWidth == null ? 0 : expressViewWidth,
        "expressViewHeight": expressViewHeight == null ? 0 : expressViewHeight,
      },
      creationParamsCodec: const StandardMessageCodec(),
    );
  }
  return Container();
}

///信息流广告
Widget nativeAdView(
    {@required String mCodeId,
      bool supportDeepLink,
      @required double expressViewWidth,
      @required double expressViewHeight}) {
  if (defaultTargetPlatform == TargetPlatform.android) {
    return AndroidView(
      viewType: 'com.gstory.flutter_unionad/NativeAdView',
      creationParams: {
        "mCodeId": mCodeId,
        "supportDeepLink": supportDeepLink == null ? true : supportDeepLink,
        "expressViewWidth": expressViewWidth == null ? 200 : expressViewWidth,
        "expressViewHeight": expressViewHeight == null ? 100 : expressViewHeight,
      },
      creationParamsCodec: const StandardMessageCodec(),
    );
  } else if (defaultTargetPlatform == TargetPlatform.iOS) {
    return UiKitView(
      viewType: "com.gstory.flutter_unionad/NativeAdView",
      creationParams: {
        "mCodeId": mCodeId,
        "supportDeepLink": supportDeepLink == null ? true : supportDeepLink,
        "expressViewWidth": expressViewWidth == null ? 200 : expressViewWidth,
        "expressViewHeight": expressViewHeight == null ? 100 : expressViewHeight,
      },
      creationParamsCodec: const StandardMessageCodec(),
    );
  }
  return Container();
}

///插屏广告
Future<bool> interactionAd({
  bool mIsExpress,
  @required String mCodeId,
  bool supportDeepLink,
  double expressViewWidth,
  double expressViewHeight,
}) async {
  return await _channel.invokeMethod("interactionAd", {
    "mIsExpress": mIsExpress == null ? false : mIsExpress,
    "mCodeId": mCodeId,
    "supportDeepLink": supportDeepLink == null ? true : supportDeepLink,
    "expressViewWidth": expressViewWidth == null ? 200 : expressViewWidth,
    "expressViewHeight": expressViewHeight == null ? 300 : expressViewHeight,
  });
}

///个性化模板插屏广告
Widget interactionAdView(
    {bool mIsExpress,
      @required String mCodeId,
    bool supportDeepLink,
    double expressViewWidth,
    double expressViewHeight}) {
  if (defaultTargetPlatform == TargetPlatform.android) {
    return AndroidView(
      viewType: 'com.gstory.flutter_unionad/InteractionAdView',
      creationParams: {
        "mIsExpress": mIsExpress == null ? false : mIsExpress,
        "mCodeId": mCodeId,
        "supportDeepLink": supportDeepLink == null ? true : supportDeepLink,
        "expressViewWidth": expressViewWidth == null ? 0 : expressViewWidth,
        "expressViewHeight": expressViewHeight == null ? 0 : expressViewHeight,
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
  @required String mCodeId,
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
    "mCodeId": mCodeId,
    "supportDeepLink": supportDeepLink == null ? true : supportDeepLink,
    "expressViewWidth": expressViewWidth == null ? 0 : expressViewWidth,
    "expressViewHeight": expressViewHeight == null ? 0 : expressViewHeight,
    "rewardName": rewardName == null ? "" : rewardName,
    "rewardAmount": rewardAmount == null ? 0 : rewardAmount,
    "userID": userID == null ? "" : userID,
    "orientation": orientation == null ? 0 : orientation,
    "mediaExtra": mediaExtra == null ? "" : mediaExtra
  });
}

///draw视频广告
Widget drawFeedAdView({
  bool mIsExpress,
  @required String mCodeId,
  bool supportDeepLink,
  double expressViewWidth,
  double expressViewHeight,
}) {
  if (defaultTargetPlatform == TargetPlatform.android) {
    return AndroidView(
      viewType: 'com.gstory.flutter_unionad/DrawFeedAdView',
      creationParams: {
        "mIsExpress": mIsExpress == null ? false : mIsExpress,
        "mCodeId": mCodeId,
        "supportDeepLink": supportDeepLink == null ? true : supportDeepLink,
        "expressViewWidth": expressViewWidth == null ? 0 : expressViewWidth,
        "expressViewHeight": expressViewHeight == null ? 0 : expressViewHeight,
      },
      creationParamsCodec: const StandardMessageCodec(),
    );
  } else if (defaultTargetPlatform == TargetPlatform.iOS) {
    return UiKitView(
      viewType: "com.gstory.flutter_unionad/DrawFeedAdView",
      creationParams: {
        "mIsExpress": mIsExpress == null ? false : mIsExpress,
        "mCodeId": mCodeId,
        "supportDeepLink": supportDeepLink == null ? true : supportDeepLink,
        "expressViewWidth": expressViewWidth == null ? 0 : expressViewWidth,
        "expressViewHeight": expressViewHeight == null ? 0 : expressViewHeight,
      },
      creationParamsCodec: const StandardMessageCodec(),
    );
  }
  return Container();
}

///个性化模板全屏广告
Future<bool> fullScreenVideoAd(
    { bool mIsExpress,
    @required String mCodeId,
    bool supportDeepLink,
    int orientation}) async {
  return await _channel.invokeMethod("fullScreenVideoAd", {
    "mIsExpress": mIsExpress == null ? false : mIsExpress,
    "mCodeId": mCodeId,
    "supportDeepLink": supportDeepLink == null ? true : supportDeepLink,
    "orientation": orientation == null ? VideoVERTICAL : orientation,
  });
}
