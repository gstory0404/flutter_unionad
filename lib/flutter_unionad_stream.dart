import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_unionad/flutter_unionad.dart';

import 'flutter_unionad_code.dart';

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
              if (flutterUnionadNewInteractionCallBack?.onShow != null) {
                flutterUnionadNewInteractionCallBack?.onShow!();
              }
              break;
            case FlutterUnionadMethod.onClose:
              if (flutterUnionadNewInteractionCallBack?.onClose != null) {
                flutterUnionadNewInteractionCallBack?.onClose!();
              }
              break;
            case FlutterUnionadMethod.onFail:
              if (flutterUnionadNewInteractionCallBack?.onFail != null) {
                flutterUnionadNewInteractionCallBack?.onFail!(data["error"]);
              }
              break;
            case FlutterUnionadMethod.onClick:
              if (flutterUnionadNewInteractionCallBack?.onClick != null) {
                flutterUnionadNewInteractionCallBack?.onClick!();
              }
              break;
            case FlutterUnionadMethod.onSkip:
              if (flutterUnionadNewInteractionCallBack?.onSkip != null) {
                flutterUnionadNewInteractionCallBack?.onSkip!();
              }
              break;
            case FlutterUnionadMethod.onFinish:
              if (flutterUnionadNewInteractionCallBack?.onFinish != null) {
                flutterUnionadNewInteractionCallBack?.onFinish!();
              }
              break;
            case FlutterUnionadMethod.onReady:
              if (flutterUnionadNewInteractionCallBack?.onReady != null) {
                flutterUnionadNewInteractionCallBack?.onReady!();
              }
              break;
            case FlutterUnionadMethod.onUnReady:
              if (flutterUnionadNewInteractionCallBack?.onUnReady != null) {
                flutterUnionadNewInteractionCallBack?.onUnReady!();
              }
              break;
          }
          break;

        ///激励广告
        case FlutterUnionadType.rewardAd:
          switch (data[FlutterUnionadMethod.onAdMethod]) {
            case FlutterUnionadMethod.onShow:
              if (flutterUnionadRewardAdCallBack?.onShow != null) {
                flutterUnionadRewardAdCallBack?.onShow!();
              }
              break;
            case FlutterUnionadMethod.onSkip:
              if (flutterUnionadRewardAdCallBack?.onSkip != null) {
                flutterUnionadRewardAdCallBack?.onSkip!();
              }
              break;
            case FlutterUnionadMethod.onClose:
              if (flutterUnionadRewardAdCallBack?.onClose != null) {
                flutterUnionadRewardAdCallBack?.onClose!();
              }
              break;
            case FlutterUnionadMethod.onFail:
              if (flutterUnionadRewardAdCallBack?.onFail != null) {
                flutterUnionadRewardAdCallBack?.onFail!(data["error"]);
              }
              break;
            case FlutterUnionadMethod.onClick:
              if (flutterUnionadRewardAdCallBack?.onClick != null) {
                flutterUnionadRewardAdCallBack?.onClick!();
              }
              break;
            case FlutterUnionadMethod.onVerify:
              if (flutterUnionadRewardAdCallBack?.onVerify != null) {
                flutterUnionadRewardAdCallBack?.onVerify!(
                    data["rewardVerify"],
                    data["rewardAmount"] ?? 0,
                    data["rewardName"] ?? "",
                    data["errorCode"] ?? 0,
                    data["error"] ?? "");
              }
              break;
            case FlutterUnionadMethod.onRewardArrived:
              if (flutterUnionadRewardAdCallBack?.onRewardArrived != null) {
                flutterUnionadRewardAdCallBack?.onRewardArrived!(
                    data["rewardVerify"],
                    data["rewardType"],
                    data["rewardAmount"] ?? 0,
                    data["rewardName"] ?? "",
                    data["errorCode"] ?? 0,
                    data["error"] ?? "",
                    data["propose"] ?? 1);
              }
              break;
            case FlutterUnionadMethod.onReady:
              if (flutterUnionadRewardAdCallBack?.onReady != null) {
                flutterUnionadRewardAdCallBack?.onReady!();
              }
              break;
            case FlutterUnionadMethod.onUnReady:
              if (flutterUnionadRewardAdCallBack?.onUnReady != null) {
                flutterUnionadRewardAdCallBack?.onUnReady!();
              }
              break;
            case FlutterUnionadMethod.onCache:
              if (flutterUnionadRewardAdCallBack?.onCache != null) {
                flutterUnionadRewardAdCallBack?.onCache!();
              }
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
