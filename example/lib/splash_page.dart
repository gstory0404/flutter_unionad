import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_unionad/flutter_unionad.dart' as FlutterUnionad;

/// 描述：开屏广告页
/// @author guozi
/// @e-mail gstory0404@gmail.com
/// @time   2020/3/11

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  StreamSubscription _adViewStream;

  @override
  void initState() {
    super.initState();
    // 这里的 data 就是原生端发送过来的数据
    _adViewStream = FlutterUnionad.adeventEvent
        .receiveBroadcastStream()
        .listen((data) {
      if (data[FlutterUnionad.adType] == FlutterUnionad.aplashAd) {
        if (data[FlutterUnionad.aplashType] == FlutterUnionad.onAplashTimeout) {
          print("开屏广告超时  ${FlutterUnionad.onAplashTimeout}");
        } else if (data[FlutterUnionad.aplashType] ==
            FlutterUnionad.onAplashShow) {
          print("开屏广告显示  ${FlutterUnionad.onAplashShow}");
        } else if (data[FlutterUnionad.aplashType] ==
            FlutterUnionad.onAplashClick) {
          print("开屏广告点击  ${FlutterUnionad.onAplashClick}");
        } else if (data[FlutterUnionad.aplashType] ==
            FlutterUnionad.onAplashSkip) {
          print("开屏广告跳过  ${FlutterUnionad.onAplashSkip}");
          Navigator.pop(context);
        } else if (data[FlutterUnionad.aplashType] ==
            FlutterUnionad.onAplashFinish) {
          print("开屏广告结束  ${FlutterUnionad.onAplashFinish}");
          Navigator.pop(context);
        } else if(data[FlutterUnionad.aplashType] ==
            FlutterUnionad.onAplashError){
          print("开屏广告结束  ${FlutterUnionad.message}");
          Navigator.pop(context);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            height: 600,
            child: FlutterUnionad.splashAdView(
                mCodeId: "887367774",
                supportDeepLink: true,
                mIsExpress: false,
                expressViewWidth: 540,
                expressViewHeight: 800),
          ),
          Expanded(
            flex: 1,
            child: Container(
              alignment: Alignment.center,
              color: Colors.blue,
              child: Text(
                "FlutterUnionad example app",
                style: TextStyle(fontSize: 14, color: Colors.white),
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    if (_adViewStream != null) {
      _adViewStream.cancel();
    }
  }
}
