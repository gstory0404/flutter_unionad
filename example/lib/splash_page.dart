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

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FlutterUnionad.splashAdView(
        androidCodeId: "887367774", //android 开屏广告广告id 必填
        iosCodeId: "887367774", //ios 开屏广告广告id 必填
        supportDeepLink: true, //是否支持 DeepLink 选填
        expressViewWidth: 750, // 期望view 宽度 dp 必填
        expressViewHeight: 1334, //期望view高度 dp 必填
        callBack: (FlutterUnionad.FlutterUnionadState state) { //广告事件回调 选填
          //广告事件回调 选填
          //type onShow广告成功显示  onFail广告加载失败 onAplashClick开屏广告点击 onAplashSkip开屏广告跳过
          //  onAplashFinish开屏广告倒计时结束 onAplashTimeout开屏广告加载超时
          //params 详细说明
          print("到这里 ${state.tojson()}");
          switch (state.type) {
            case FlutterUnionad.onShow:
              print(state.tojson());
              break;
            case FlutterUnionad.onFail:
              print(state.tojson());
              Navigator.pop(context);
              break;
            case FlutterUnionad.onAplashClick:
              print(state.tojson());
              break;
            case FlutterUnionad.onAplashSkip:
              print(state.tojson());
              Navigator.pop(context);
              break;
            case FlutterUnionad.onAplashFinish:
              print(state.tojson());
              Navigator.pop(context);
              break;
            case FlutterUnionad.onAplashTimeout:
              print(state.tojson());
              Navigator.pop(context);
              break;
          }
        },
      ),
    );
  }
}
