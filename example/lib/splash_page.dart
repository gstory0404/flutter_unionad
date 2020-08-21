import 'package:flutter/material.dart';
import 'package:flutter_unionad/flutter_unionad.dart';

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
    // 这里的 data 就是原生端发送过来的数据
    FlutterUnionad.splashAdViewChannel.receiveBroadcastStream().listen((data) {
      print("触发回调  $data");
      Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            height: 700,
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
              child: Text("FlutterUnionad example app",style: TextStyle(
                fontSize: 18,
                color: Colors.white
              ),),
            ),
          )
        ],
      ),
    );
  }
}
