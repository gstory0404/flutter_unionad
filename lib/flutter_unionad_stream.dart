import 'dart:async';

import 'package:flutter_unionad/flutter_unionad.dart';

import 'flutter_unionad_ad.dart';
import 'flutter_unionad_code.dart';

/// @Author: gstory
/// @CreateDate: 2021/5/25 7:45 下午
/// @Description: dart类作用描述

class FlutterUnionadStream {
  static late StreamSubscription _adStream;

  // factory FlutterUnionadStream() =>_initInstance();
  //
  // static FlutterUnionadStream? _instance;
  //
  // FlutterUnionadStream._() {
  //   _fullVideAdStream = adEventEvent.receiveBroadcastStream().listen((event) { });
  // }
  //
  // static FlutterUnionadStream _initInstance() {
  //   if (_instance == null) {
  //     _instance = FlutterUnionadStream._();
  //   }
  //   return _instance!;
  // }

  static void initAdStream({FullVideoAdCallBack? fullVideoAdCallBack,
    InteractionAdCallBack? interactionAdCallBack,
    RewardAdCallBack? rewardAdCallBack}) {
    _adStream = adEventEvent.receiveBroadcastStream().listen((data) {
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
          }
      }
    });
  }

  static void deleteAdStream() {
    _adStream.cancel();
  }
}
