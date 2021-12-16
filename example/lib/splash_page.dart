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
  bool _offstage = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Offstage(
          offstage: _offstage,
          child: FlutterUnionad.splashAdView(
            //是否使用个性化模版  设定widget宽高
            mIsExpress: true,
            //android 开屏广告广告id 必填
            androidCodeId: "887367774",
            //ios 开屏广告广告id 必填
            iosCodeId: "887367774",
            //是否支持 DeepLink 选填
            supportDeepLink: true,
            // 期望view 宽度 dp 选填 mIsExpress=true必填
            expressViewWidth: 750,
            //期望view高度 dp 选填 mIsExpress=true必填
            expressViewHeight: 800,
            //控制下载APP前是否弹出二次确认弹窗
            downloadType: FlutterUnionadDownLoadType.DOWNLOAD_TYPE_POPUP,
            callBack: FlutterUnionadSplashCallBack(
              onShow: () {
                print("开屏广告显示");
                setState(() => _offstage = false);
              },
              onClick: () {
                print("开屏广告点击");
                Navigator.pop(context);
              },
              onFail: (error) {
                print("开屏广告失败 $error");
              },
              onFinish: () {
                print("开屏广告倒计时结束");
                Navigator.pop(context);
              },
              onSkip: () {
                print("开屏广告跳过");
                Navigator.pop(context);
              },
              onTimeOut: () {
                print("开屏广告超时");
              },
            ),
          ),
        ),
        Expanded(
          child: Container(
            color: Colors.red,
            alignment: Alignment.center,
            child: Text(
              "flutter_unionad",
              style: TextStyle(
                fontSize: 20,
                color: Colors.black,
                decoration: TextDecoration.none,
              ),
            ),
          ),
        )
      ],
    );
  }
}
