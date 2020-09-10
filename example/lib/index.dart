import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_unionad/flutter_unionad.dart' as FlutterUnionad;
import 'package:flutter_unionad_example/banner_page.dart';
import 'package:flutter_unionad_example/drawfeed_page.dart';
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
  StreamSubscription _adViewStream;

  @override
  void initState() {
    super.initState();
    _initRegister();
    // 这里的 data 就是原生端发送过来的数据
   _adViewStream = FlutterUnionad.adeventEvent
       .receiveBroadcastStream()
       .listen((data) {
     if (data[FlutterUnionad.adType] == FlutterUnionad.rewardAd) {
       print("激励广告结果----->  rewardVerify=${data[FlutterUnionad.rewardVerify]} "
           "rewardName=${data[FlutterUnionad.rewardName]} "
           "rewardAmount=${data[FlutterUnionad.rewardAmount]} ");
     }
   });
  }

  void _initRegister() async {
    _init = await FlutterUnionad.register(
        appId: "5098580",
        useTextureView: true,
        appName: "unionad_test",
        allowShowNotify: true,
        allowShowPageWhenScreenLock: true,
        debug: true,
        supportMultiProcess: true,
        directDownloadNetworkType: [
          FlutterUnionad.NETWORK_STATE_2G,
          FlutterUnionad.NETWORK_STATE_3G,
          FlutterUnionad.NETWORK_STATE_4G,
          FlutterUnionad.NETWORK_STATE_WIFI
        ]);
    _version = await FlutterUnionad.getSDKVersion();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (_init == null) {
      return Scaffold(
        body: Center(
          child: Text("正在进行穿山甲sdk初始化..."),
        ),
      );
    }
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
              onPressed: () async {
                await FlutterUnionad.interactionExpressAd(
                  mCodeId: "945417892",
                  supportDeepLink: true,
                  expressViewWidth: 800,
                  expressViewHeight: 1200,
                );
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
            //个性化模板信息流广告
            MaterialButton(
              color: Colors.blue,
              textColor: Colors.white,
              child: new Text('draw视频广告'),
              onPressed: () {
                Navigator.push(
                  context,
                  new MaterialPageRoute(
                    builder: (context) => new DrawFeedPage(),
                  ),
                );
              },
            ),
          ],
        ),
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
