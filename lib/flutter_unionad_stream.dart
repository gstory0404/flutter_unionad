import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_unionad/flutter_unionad.dart';

/// @Author: gstory
/// @CreateDate: 2021/5/25 7:45 下午
/// @Description: 广告结果监听

const EventChannel adEventEvent =
    EventChannel("com.gstory.flutter_unionad/adevent");

class FlutterUnionadStream {
  ///注册stream监听原生返回的信息
  static StreamSubscription initAdStream(
      {FlutterUnionadFullVideoCallBack? flutterUnionadFullVideoCallBack,
      FlutterUnionadInteractionCallBack? flutterUnionadInteractionCallBack,
      FlutterUnionadNewInteractionCallBack?
          flutterUnionadNewInteractionCallBack,
      FlutterUnionadRewardAdCallBack? flutterUnionadRewardAdCallBack}) {
    StreamSubscription _adStream =
        adEventEvent.receiveBroadcastStream().listen((data) {
      switch (data[FlutterUnionadType.adType]) {
        ///全屏广告
        case FlutterUnionadType.fullVideoAd:
          switch (data[FlutterUnionadMethod.onAdMethod]) {
            case FlutterUnionadMethod.onShow:
              if (flutterUnionadFullVideoCallBack?.onShow != null) {
                flutterUnionadFullVideoCallBack?.onShow!();
              }
              break;
            case FlutterUnionadMethod.onSkip:
              if (flutterUnionadFullVideoCallBack?.onSkip != null) {
                flutterUnionadFullVideoCallBack?.onSkip!();
              }
              break;
            case FlutterUnionadMethod.onFinish:
              if (flutterUnionadFullVideoCallBack?.onFinish != null) {
                flutterUnionadFullVideoCallBack?.onFinish!();
              }
              break;
            case FlutterUnionadMethod.onClose:
              if (flutterUnionadFullVideoCallBack?.onClose != null) {
                flutterUnionadFullVideoCallBack?.onClose!();
              }
              break;
            case FlutterUnionadMethod.onFail:
              if (flutterUnionadFullVideoCallBack?.onFail != null) {
                flutterUnionadFullVideoCallBack?.onFail!(data["error"]);
              }
              break;
            case FlutterUnionadMethod.onClick:
              if (flutterUnionadFullVideoCallBack?.onClick != null) {
                flutterUnionadFullVideoCallBack?.onClick!();
              }
              break;
          }
          break;

        ///插屏广告
        case FlutterUnionadType.interactAd:
          switch (data[FlutterUnionadMethod.onAdMethod]) {
            case FlutterUnionadMethod.onShow:
              if (flutterUnionadInteractionCallBack?.onShow != null) {
                flutterUnionadInteractionCallBack?.onShow!();
              }
              break;
            case FlutterUnionadMethod.onDislike:
              if (flutterUnionadInteractionCallBack?.onDislike != null) {
                flutterUnionadInteractionCallBack?.onDislike!(data["message"]);
              }
              break;
            case FlutterUnionadMethod.onClose:
              if (flutterUnionadInteractionCallBack?.onClose != null) {
                flutterUnionadInteractionCallBack?.onClose!();
              }
              break;
            case FlutterUnionadMethod.onFail:
              if (flutterUnionadInteractionCallBack?.onFail != null) {
                flutterUnionadInteractionCallBack?.onFail!(data["error"]);
              }
              break;
            case FlutterUnionadMethod.onClick:
              if (flutterUnionadInteractionCallBack?.onClick != null) {
                flutterUnionadInteractionCallBack?.onClick!();
              }
              break;
          }
          break;

        /// 新模板渲染插屏
        case FlutterUnionadType.fullScreenVideoAdInteraction:
          switch (data[FlutterUnionadMethod.onAdMethod]) {
            case FlutterUnionadMethod.onShow:
              flutterUnionadNewInteractionCallBack?.onShow?.call();
              break;
            case FlutterUnionadMethod.onClose:
              flutterUnionadNewInteractionCallBack?.onClose?.call();
              break;
            case FlutterUnionadMethod.onFail:
              flutterUnionadNewInteractionCallBack?.onFail?.call(data["error"]);
              break;
            case FlutterUnionadMethod.onClick:
              flutterUnionadNewInteractionCallBack?.onClick?.call();
              break;
            case FlutterUnionadMethod.onSkip:
              flutterUnionadNewInteractionCallBack?.onSkip?.call();
              break;
            case FlutterUnionadMethod.onFinish:
              flutterUnionadNewInteractionCallBack?.onFinish?.call();
              break;
            case FlutterUnionadMethod.onReady:
              flutterUnionadNewInteractionCallBack?.onReady?.call();
              break;
            case FlutterUnionadMethod.onUnReady:
              flutterUnionadNewInteractionCallBack?.onUnReady?.call();
              break;
            case FlutterUnionadMethod.onEcpm:
              flutterUnionadNewInteractionCallBack?.onEcpm?.call(
                  data[FlutterUnionadMethod.ecpmInfo]?.cast<String, dynamic>());
              break;
          }
          break;

        ///激励广告
        case FlutterUnionadType.rewardAd:
          switch (data[FlutterUnionadMethod.onAdMethod]) {
            case FlutterUnionadMethod.onShow:
              flutterUnionadRewardAdCallBack?.onShow?.call();
              break;
            case FlutterUnionadMethod.onSkip:
              flutterUnionadRewardAdCallBack?.onSkip?.call();
              break;
            case FlutterUnionadMethod.onClose:
              flutterUnionadRewardAdCallBack?.onClose?.call();
              break;
            case FlutterUnionadMethod.onFail:
              flutterUnionadRewardAdCallBack?.onFail?.call(data["error"]);
              break;
            case FlutterUnionadMethod.onClick:
              flutterUnionadRewardAdCallBack?.onClick?.call();
              break;
            case FlutterUnionadMethod.onVerify:
              flutterUnionadRewardAdCallBack?.onVerify?.call(
                  data["rewardVerify"],
                  data["rewardAmount"] ?? 0,
                  data["rewardName"] ?? "",
                  data["errorCode"] ?? 0,
                  data["error"] ?? "");
              break;
            case FlutterUnionadMethod.onRewardArrived:
              flutterUnionadRewardAdCallBack?.onRewardArrived?.call(
                  data["rewardVerify"],
                  data["rewardType"],
                  data["rewardAmount"] ?? 0,
                  data["rewardName"] ?? "",
                  data["errorCode"] ?? 0,
                  data["error"] ?? "",
                  data["propose"] ?? 1);
              break;
            case FlutterUnionadMethod.onReady:
              flutterUnionadRewardAdCallBack?.onReady?.call();
              break;
            case FlutterUnionadMethod.onUnReady:
              flutterUnionadRewardAdCallBack?.onUnReady?.call();
              break;
            case FlutterUnionadMethod.onCache:
              flutterUnionadRewardAdCallBack?.onCache?.call();
              break;
            case FlutterUnionadMethod.onEcpm:
              flutterUnionadRewardAdCallBack?.onEcpm?.call(
                  data[FlutterUnionadMethod.ecpmInfo]?.cast<String, dynamic>());
              break;
          }
      }
    });
    return _adStream;
  }

  static void deleteAdStream(StreamSubscription stream) {
    stream.cancel();
  }
}
