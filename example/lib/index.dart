import 'package:flutter/material.dart';
import 'package:flutter_unionad/flutter_unionad.dart';
import 'package:flutter_unionad_example/banner_page.dart';
import 'package:flutter_unionad_example/interscreen_dialog.dart';
import 'package:flutter_unionad_example/nativeexpressad_page.dart';
import 'package:flutter_unionad_example/splash_page.dart';

/// 描述：
/// @author guozi
/// @e-mail gstory0404@gmail.com
/// @time   2020/3/11

class IndexPage extends StatefulWidget {
  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  bool _init;
  String _version;

  @override
  void initState() {
    super.initState();
    _initRegister();
  }

  void _initRegister() async {
    _init = await FlutterUnionad.register(
        appId: "5098580",
        useTextureView: true,
        appName: "unionad_test",
        allowShowNotify: true,
        allowShowPageWhenScreenLock: true,
        debug: true,
        supportMultiProcess: true);
    _version = await FlutterUnionad.getSDKVersion();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FlutterUnionad example app'),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        reverse: false,
        physics: BouncingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.center,
              height: 50,
              child: Text("穿山甲初始化>>>>>> ${_init ? "成功" : "失败"}"),
            ),
            Container(
              alignment: Alignment.center,
              height: 50,
              child: Text("穿山甲SDK版本号>>>>>> v$_version"),
            ),
            //请求权限
            MaterialButton(
              color: Colors.blue,
              textColor: Colors.white,
              child: new Text('请求权限'),
              onPressed: () async {
                await FlutterUnionad.requestPermissionIfNecessary();
              },
            ),
            //开屏广告
            MaterialButton(
              color: Colors.blue,
              textColor: Colors.white,
              child: new Text('banner广告'),
              onPressed: () {
                Navigator.push(
                  context,
                  new MaterialPageRoute(
                    builder: (context) => new BannerPage(),
                  ),
                );
              },
            ),
            //开屏广告
            MaterialButton(
              color: Colors.blue,
              textColor: Colors.white,
              child: new Text('开屏广告'),
              onPressed: () {
                Navigator.push(
                  context,
                  new MaterialPageRoute(
                    builder: (context) => new SplashPage(),
                  ),
                );
              },
            ),
            //个性化模板信息流广告
            MaterialButton(
              color: Colors.blue,
              textColor: Colors.white,
              child: new Text('信息流广告'),
              onPressed: () {
                Navigator.push(
                  context,
                  new MaterialPageRoute(
                    builder: (context) => new NativeExpressAdPage(),
                  ),
                );
              },
            ),
            //插屏广告
            MaterialButton(
              color: Colors.blue,
              textColor: Colors.white,
              child: new Text('插屏广告'),
              onPressed: () async{
               await FlutterUnionad.interactionExpressAdView2(
                  mCodeId: "945417892",
                  supportDeepLink: true,
                  expressViewWidth: 800,
                  expressViewHeight: 1200,
                );
//                //显示插屏广告
//                showDialog(
//                  context: context,
//                  barrierDismissible: true,
//                  builder: (context) {
//                    return InterScreenDialog();
//                  },
//                );
              },
            ),
            //激励视频
            MaterialButton(
              color: Colors.blue,
              textColor: Colors.white,
              child: new Text('激励视频'),
              onPressed: () {
                FlutterUnionad.loadRewardVideoAd(
                    mIsExpress: true,
                    mCodeId: "945418088",
                    supportDeepLink: true,
//                    expressViewWidth: 1080,
//                    expressViewHeight: 1920,
                    rewardName: "100金币",
                    rewardAmount: 100,
                    userID: "123",
                    orientation: FlutterUnionad.VideoVERTICAL,
                    mediaExtra: null);
              },
            ),
          ],
        ),
      ),
    );
  }
}
