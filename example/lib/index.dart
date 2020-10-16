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
         print("广告结果 ${data[FlutterUnionad.adType]}");
     if (data[FlutterUnionad.adType] == FlutterUnionad.rewardAd) {
       print("激励广告结果----->  rewardVerify=${data[FlutterUnionad.rewardVerify]} "
           "rewardName=${data[FlutterUnionad.rewardName]} "
           "rewardAmount=${data[FlutterUnionad.rewardAmount]} ");
     }else if(data[FlutterUnionad.adType] == FlutterUnionad.fullVideoAd){
        switch(data[FlutterUnionad.fullVideoType]){
          case FlutterUnionad.onAdShow:
            print("全屏广告显示");
            break;
          case FlutterUnionad.onAdVideoBarClick:
            print("全屏广告返回");
            break;
          case FlutterUnionad.onAdClose:
            print("全屏广告关闭");
            break;
          case FlutterUnionad.onVideoComplete:
            print("全屏广告继续");
            break;
          case FlutterUnionad.onSkippedVideo:
            print("全屏广告跳过");
            break;
        }
     }
   });
  }

  void _initRegister() async {
    _init = await FlutterUnionad.register(
        androidAppId: "5098580", //穿山甲广告 Android appid 必填
        iosAppId:  "5098580", //穿山甲广告 ios appid 必填
        useTextureView: true, //使用TextureView控件播放视频,默认为SurfaceView,当有SurfaceView冲突的场景，可以使用TextureView 选填
        appName: "unionad_test", //appname 必填
        allowShowNotify: true, //是否允许sdk展示通知栏提示 选填
        allowShowPageWhenScreenLock: true, //是否在锁屏场景支持展示广告落地页 选填
        debug: true, //测试阶段打开，可以通过日志排查问题，上线时去除该调用 选太难
        supportMultiProcess: true, //是否支持多进程，true支持 选填
        directDownloadNetworkType: [
          FlutterUnionad.NETWORK_STATE_2G,
          FlutterUnionad.NETWORK_STATE_3G,
          FlutterUnionad.NETWORK_STATE_4G,
          FlutterUnionad.NETWORK_STATE_WIFI
        ]); //允许直接下载的网络状态集合 选填
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
            //banner广告
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
                await FlutterUnionad.interactionAd(
                  androidCodeId: "945417892",//andrrid 插屏广告id 必填
                  iosCodeId: "945417892",//ios 插屏广告id 必填
                  supportDeepLink: true, //是否支持 DeepLink 选填
                  expressViewWidth: 300.0, // 期望view 宽度 dp 必填
                  expressViewHeight: 450.0, //期望view高度 dp 必填
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
                    mIsExpress: true, //是否个性化 选填
                    androidCodeId: "945418088", //Android 激励视频广告id  必填
                    iosCodeId: "945418088", //ios 激励视频广告id  必填
                    supportDeepLink: true, //是否支持 DeepLink 选填
                    rewardName: "100金币", //奖励名称 选填
                    rewardAmount: 100, //奖励数量 选填
                    userID: "123",  //  用户id 选填
                    orientation: FlutterUnionad.VideoVERTICAL, //视屏方向 选填
                    mediaExtra: null, //扩展参数 选填
                );
              },
            ),
            //个性化模板draw广告
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
            //个性化全屏广告
            MaterialButton(
              color: Colors.blue,
              textColor: Colors.white,
              child: new Text('全屏广告'),
              onPressed: () {
              FlutterUnionad.fullScreenVideoAd(
                  androidCodeId: "945491318", //android 全屏广告id 必填
                  iosCodeId: "945491318",//ios 全屏广告id 必填
                  supportDeepLink: true,  //是否支持 DeepLink 选填
                  orientation: FlutterUnionad.VideoVERTICAL,//视屏方向 选填
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
