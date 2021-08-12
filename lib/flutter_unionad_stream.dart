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
  static StreamSubscription initAdStream({FlutterUnionadFullVideoCallBack? flutterUnionadFullVideoCallBack,
    FlutterUnionadInteractionCallBack? flutterUnionadInteractionCallBack,
    FlutterUnionadNewInteractionCallBack? flutterUnionadNewInteractionCallBack,
    FlutterUnionadRewardAdCallBack? flutterUnionadRewardAdCallBack}) {
    StreamSubscription _adStream = adEventEvent.receiveBroadcastStream().listen((data) {
      switch (data[FlutterUnionadType.adType]){
        ///全屏广告
        case FlutterUnionadType.fullVideoAd:
          switch (data[FlutterUnionadMethod.onAdMethod]) {
            case FlutterUnionadMethod.onShow:
              flutterUnionadFullVideoCallBack?.onShow!();
              break;
            case FlutterUnionadMethod.onSkip:
              flutterUnionadFullVideoCallBack?.onSkip!();
              break;
            case FlutterUnionadMethod.onFinish:
              flutterUnionadFullVideoCallBack?.onFinish!();
              break;
            case FlutterUnionadMethod.onClose:
              flutterUnionadFullVideoCallBack?.onClose!();
              break;
            case FlutterUnionadMethod.onFail:
              flutterUnionadFullVideoCallBack?.onFail!(data["error"]);
              break;
            case FlutterUnionadMethod.onClick:
              flutterUnionadFullVideoCallBack?.onClick!();
              break;
          }
          break;
          ///插屏广告
         case FlutterUnionadType.interactAd:
           switch (data[FlutterUnionadMethod.onAdMethod]) {
             case FlutterUnionadMethod.onShow:
               flutterUnionadInteractionCallBack?.onShow!();
               break;
             case FlutterUnionadMethod.onDislike:
               flutterUnionadInteractionCallBack?.onDislike!(data["message"]);
               break;
             case FlutterUnionadMethod.onClose:
               flutterUnionadInteractionCallBack?.onClose!();
               break;
             case FlutterUnionadMethod.onFail:
               flutterUnionadInteractionCallBack?.onFail!(data["error"]);
               break;
             case FlutterUnionadMethod.onClick:
               flutterUnionadInteractionCallBack?.onClick!();
               break;
           }
           break;
           /// 新模板渲染插屏
        case FlutterUnionadType.fullScreenVideoAdInteraction:
          switch (data[FlutterUnionadMethod.onAdMethod]) {
            case FlutterUnionadMethod.onShow:
              flutterUnionadNewInteractionCallBack?.onShow!();
              break;
            case FlutterUnionadMethod.onClose:
              flutterUnionadNewInteractionCallBack?.onClose!();
              break;
            case FlutterUnionadMethod.onFail:
              flutterUnionadNewInteractionCallBack?.onFail!(data["error"]);
              break;
            case FlutterUnionadMethod.onClick:
              flutterUnionadNewInteractionCallBack?.onClick!();
              break;
            case FlutterUnionadMethod.onSkip:
              flutterUnionadNewInteractionCallBack?.onSkip!();
              break;
            case FlutterUnionadMethod.onFinish:
              flutterUnionadNewInteractionCallBack?.onFinish!();
              break;
            case FlutterUnionadMethod.onReady:
              flutterUnionadNewInteractionCallBack?.onReady!();
              break;
            case FlutterUnionadMethod.onUnReady:
              flutterUnionadNewInteractionCallBack?.onUnReady!();
              break;
          }
          break;
          ///激励广告
        case FlutterUnionadType.rewardAd:
          switch (data[FlutterUnionadMethod.onAdMethod]) {
            case FlutterUnionadMethod.onShow:
              flutterUnionadRewardAdCallBack?.onShow!();
              break;
            case FlutterUnionadMethod.onSkip:
              flutterUnionadRewardAdCallBack?.onSkip!();
              break;
            case FlutterUnionadMethod.onClose:
              flutterUnionadRewardAdCallBack?.onClose!();
              break;
            case FlutterUnionadMethod.onFail:
              flutterUnionadRewardAdCallBack?.onFail!(data["error"]);
              break;
            case FlutterUnionadMethod.onClick:
              flutterUnionadRewardAdCallBack?.onClick!();
              break;
            case FlutterUnionadMethod.onVerify:
              flutterUnionadRewardAdCallBack?.onVerify!(data["rewardVerify"],data["rewardAmount"],data["rewardName"]);
              break;
            case FlutterUnionadMethod.onReady:
              flutterUnionadRewardAdCallBack?.onReady!();
              break;
            case FlutterUnionadMethod.onUnReady:
              flutterUnionadRewardAdCallBack?.onUnReady!();
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
