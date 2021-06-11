import 'dart:async';

import 'package:flutter_unionad/flutter_unionad.dart';

import 'flutter_unionad_ad.dart';
import 'flutter_unionad_code.dart';

/// @Author: gstory
/// @CreateDate: 2021/5/25 7:45 下午
/// @Description: dart类作用描述

class FlutterUnionadStream {


  ///注册stream监听原生返回的信息
  static StreamSubscription initAdStream({FullVideoAdCallBack? fullVideoAdCallBack,
    InteractionAdCallBack? interactionAdCallBack,
    FullScreenVideoAdInteractionCallBack? fullScreenVideoAdInteractionCallBack,
    RewardAdCallBack? rewardAdCallBack}) {
    StreamSubscription _adStream = adEventEvent.receiveBroadcastStream().listen((data) {
      switch (data[AdType.adType]){
        ///全屏广告
        case AdType.fullVideoAd:
          switch (data[OnAdMethod.onAdMethod]) {
            case OnAdMethod.onShow:
              fullVideoAdCallBack?.onShow!();
              break;
            case OnAdMethod.onSkip:
              fullVideoAdCallBack?.onSkip!();
              break;
            case OnAdMethod.onFinish:
              fullVideoAdCallBack?.onFinish!();
              break;
            case OnAdMethod.onClose:
              fullVideoAdCallBack?.onClose!();
              break;
            case OnAdMethod.onFail:
              fullVideoAdCallBack?.onFail!(data["error"]);
              break;
            case OnAdMethod.onClick:
              fullVideoAdCallBack?.onClick!();
              break;
          }
          break;
          ///插屏广告
         case AdType.interactAd:
           switch (data[OnAdMethod.onAdMethod]) {
             case OnAdMethod.onShow:
               interactionAdCallBack?.onShow!();
               break;
             case OnAdMethod.onDislike:
               interactionAdCallBack?.onDislike!(data["message"]);
               break;
             case OnAdMethod.onClose:
               interactionAdCallBack?.onClose!();
               break;
             case OnAdMethod.onFail:
               interactionAdCallBack?.onFail!(data["error"]);
               break;
             case OnAdMethod.onClick:
               interactionAdCallBack?.onClick!();
               break;
           }
           break;
           /// 新模板渲染插屏
        case AdType.fullScreenVideoAdInteraction:
          switch (data[OnAdMethod.onAdMethod]) {
            case OnAdMethod.onShow:
              fullScreenVideoAdInteractionCallBack?.onShow!();
              break;
            case OnAdMethod.onClose:
              fullScreenVideoAdInteractionCallBack?.onClose!();
              break;
            case OnAdMethod.onFail:
              fullScreenVideoAdInteractionCallBack?.onFail!(data["error"]);
              break;
            case OnAdMethod.onClick:
              fullScreenVideoAdInteractionCallBack?.onClick!();
              break;
            case OnAdMethod.onSkip:
              fullScreenVideoAdInteractionCallBack?.onSkip!();
              break;
            case OnAdMethod.onFinish:
              fullScreenVideoAdInteractionCallBack?.onFinish!();
              break;
            case OnAdMethod.onReady:
              fullScreenVideoAdInteractionCallBack?.onReady!();
              break;
            case OnAdMethod.onUnReady:
              fullScreenVideoAdInteractionCallBack?.onUnReady!();
              break;
          }
          break;
          ///激励广告
        case AdType.rewardAd:
          switch (data[OnAdMethod.onAdMethod]) {
            case OnAdMethod.onShow:
              rewardAdCallBack?.onShow!();
              break;
            case OnAdMethod.onSkip:
              rewardAdCallBack?.onSkip!();
              break;
            case OnAdMethod.onClose:
              rewardAdCallBack?.onClose!();
              break;
            case OnAdMethod.onFail:
              rewardAdCallBack?.onFail!(data["error"]);
              break;
            case OnAdMethod.onClick:
              rewardAdCallBack?.onClick!();
              break;
            case OnAdMethod.onVerify:
              rewardAdCallBack?.onVerify!(data["rewardVerify"],data["rewardAmount"],data["rewardName"]);
              break;
            case OnAdMethod.onReady:
              rewardAdCallBack?.onReady!();
              break;
            case OnAdMethod.onUnReady:
              rewardAdCallBack?.onUnReady!();
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
