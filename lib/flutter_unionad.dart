import 'dart:async';
import 'dart:ffi';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const int NETWORK_STATE_MOBILE = 1;
const int NETWORK_STATE_2G = 2;
const int NETWORK_STATE_3G = 3;
const int NETWORK_STATE_WIFI = 4;
const int NETWORK_STATE_4G = 5;

class FlutterUnionad {
  static const MethodChannel _channel = const MethodChannel('flutter_unionad');
  static const EventChannel splashAdViewChannel =
      EventChannel("com.gstory.flutter_unionad/adsplashviewevent");

  //激励视频方向
  static const int VideoVERTICAL = 1;
  static const int VideoHORIZONTAL = 2;

  //sdk注册初始化
  static Future<bool> register({
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
      "directDownloadNetworkType": directDownloadNetworkType ??
          [
            NETWORK_STATE_MOBILE,
            NETWORK_STATE_3G,
            NETWORK_STATE_4G,
            NETWORK_STATE_WIFI
          ]
    });
  }

  ///请求权限
  static Future<bool> requestPermissionIfNecessary() async {
    return await _channel.invokeMethod("requestPermissionIfNecessary");
  }

  ///获取SDK版本号
  static Future<String> getSDKVersion() async {
    return await _channel.invokeMethod("getSDKVersion");
  }

  //banner广告
  static Widget bannerAdView(
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
    }
    return Container();
  }

  //开屏广告
  static Widget splashAdView(
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

  //个性化模板信息流广告
  static Widget nativeExpressAdView(
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

  //个性化模板插屏广告
  static Future<bool> interactionExpressAdView2({
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

 //个性化模板插屏广告
  static Widget interactionExpressAdView(
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

  //激励视频广告
  static Future<bool> loadRewardVideoAd({
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
}
