import 'dart:async';
import 'dart:io';

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
  bool? _init;
  String? _version;
  StreamSubscription? _adViewStream;

  @override
  void initState() {
    super.initState();
    _privacy();
    _initRegister();
    _adViewStream = FlutterUnionad.FlutterUnionadStream.initAdStream(
      fullVideoAdCallBack: FlutterUnionad.FullVideoAdCallBack(
        onShow: () {
          print("全屏广告显示");
        },
        onSkip: () {
          print("全屏广告跳过");
        },
        onClick: () {
          print("全屏广告点击");
        },
        onFinish: () {
          print("全屏广告结束");
        },
        onFail: (error) {
          print("全屏广告错误 $error");
        },
        onClose: () {
          print("全屏广告关闭");
        },
      ),
      //插屏广告回调
      interactionAdCallBack: FlutterUnionad.InteractionAdCallBack(onShow: () {
        print("插屏广告展示");
      }, onClose: () {
        print("插屏广告关闭");
      }, onFail: (error) {
        print("插屏广告失败 $error");
      }, onClick: () {
        print("插屏广告点击");
      }, onDislike: (message) {
        print("插屏广告不喜欢  $message");
      }),
      // 新模板渲染插屏广告回调
      fullScreenVideoAdInteractionCallBack:
          FlutterUnionad.FullScreenVideoAdInteractionCallBack(
        onShow: () {
          print("新模板渲染插屏广告显示");
        },
        onSkip: () {
          print("新模板渲染插屏广告跳过");
        },
        onClick: () {
          print("新模板渲染插屏广告点击");
        },
        onFinish: () {
          print("新模板渲染插屏广告结束");
        },
        onFail: (error) {
          print("新模板渲染插屏广告错误 $error");
        },
        onClose: () {
          print("新模板渲染插屏广告关闭");
        },
        onReady: () async {
          print("新模板渲染插屏广告预加载准备就绪");
          //显示新模板渲染插屏
          await FlutterUnionad.showFullScreenVideoAdInteraction();
        },
        onUnReady: () {
          print("新模板渲染插屏广告预加载未准备就绪");
        },
      ),
      //激励广告
      rewardAdCallBack: FlutterUnionad.RewardAdCallBack(
        onShow: () {
          print("激励广告显示");
        },
        onClick: () {
          print("激励广告点击");
        },
        onFail: (error) {
          print("激励广告失败 $error");
        },
        onClose: () {
          print("激励广告关闭");
        },
        onSkip: () {
          print("激励广告跳过");
        },
        onReady: () async {
          print("激励广告预加载准备就绪");
          await FlutterUnionad.showRewardVideoAd();
        },
        onUnReady: () {
          print("激励广告预加载未准备就绪");
        },
        onVerify: (rewardVerify, rewardAmount, rewardName) {
          print("激励广告奖励  $rewardVerify   $rewardAmount  $rewardName");
        },
      ),
    );
  }

  //注册
  void _initRegister() async {
    _init = await FlutterUnionad.register(
        androidAppId: "5098580",
        //穿山甲广告 Android appid 必填
        iosAppId: "5098580",
        //穿山甲广告 ios appid 必填
        useTextureView: true,
        //使用TextureView控件播放视频,默认为SurfaceView,当有SurfaceView冲突的场景，可以使用TextureView 选填
        appName: "unionad_test",
        //appname 必填
        allowShowNotify: true,
        //是否允许sdk展示通知栏提示 选填
        allowShowPageWhenScreenLock: true,
        //是否在锁屏场景支持展示广告落地页 选填
        debug: true,
        //是否显示debug日志
        supportMultiProcess: true,
        //是否支持多进程，true支持 选填
        directDownloadNetworkType: [
          FlutterUnionad.NetCode.NETWORK_STATE_2G,
          FlutterUnionad.NetCode.NETWORK_STATE_3G,
          FlutterUnionad.NetCode.NETWORK_STATE_4G,
          FlutterUnionad.NetCode.NETWORK_STATE_WIFI
        ]); //允许直接下载的网络状态集合 选填
    print("sdk初始化 $_init");
    _version = await FlutterUnionad.getSDKVersion();
    setState(() {});
  }

  //隐私权限
  void _privacy() async {
    if (Platform.isAndroid) {
      await FlutterUnionad.andridPrivacy(
        isCanUseLocation: false, //是否允许SDK主动使用地理位置信息 true可以获取，false禁止获取。默认为true
        lat: 1.0,//当isCanUseLocation=false时，可传入地理位置信息，穿山甲sdk使用您传入的地理位置信息lat
        lon: 1.0,//当isCanUseLocation=false时，可传入地理位置信息，穿山甲sdk使用您传入的地理位置信息lon
        isCanUsePhoneState: false,//是否允许SDK主动使用手机硬件参数，如：imei
        imei: "123",//当isCanUsePhoneState=false时，可传入imei信息，穿山甲sdk使用您传入的imei信息
        isCanUseWifiState: false,//是否允许SDK主动使用ACCESS_WIFI_STATE权限
        isCanUseWriteExternal: false,//是否允许SDK主动使用WRITE_EXTERNAL_STORAGE权限
        oaid: "111",//开发者可以传入oaid
      );
    }
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
              child: Text("穿山甲初始化>>>>>> ${_init != null ? "成功" : "失败"}"),
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
                switch (await FlutterUnionad.requestPermissionIfNecessary()) {
                  //未确定
                  case FlutterUnionad.PermissionCode.notDetermined:
                    break;
                  //限制
                  case FlutterUnionad.PermissionCode.restricted:
                    break;
                  //拒绝
                  case FlutterUnionad.PermissionCode.denied:
                    break;
                  //同意
                  case FlutterUnionad.PermissionCode.authorized:
                    break;
                }
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
                  androidCodeId: "945417892",
                  //andrrid 插屏广告id 必填
                  iosCodeId: "945417892",
                  //ios 插屏广告id 必填
                  supportDeepLink: true,
                  //是否支持 DeepLink 选填
                  expressViewWidth: 300.0,
                  // 期望view 宽度 dp 必填
                  expressViewHeight: 450.0,
                  //期望view高度 dp 必填
                  expressNum: 2, //一次请求广告数量 大于1小于3 必填
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
                  //是否个性化 选填
                  androidCodeId: "945418088",
                  //Android 激励视频广告id  必填
                  iosCodeId: "945418088",
                  //ios 激励视频广告id  必填
                  supportDeepLink: true,
                  //是否支持 DeepLink 选填
                  rewardName: "100金币",
                  //奖励名称 选填
                  rewardAmount: 100,
                  //奖励数量 选填
                  userID: "123",
                  //  用户id 选填
                  orientation: FlutterUnionad.AdOrientation.VERTICAL,
                  //视屏方向 选填
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
                  iosCodeId: "945491318", //ios 全屏广告id 必填
                  supportDeepLink: true, //是否支持 DeepLink 选填
                  orientation: FlutterUnionad.AdOrientation.VERTICAL, //视屏方向 选填
                );
              },
            ),
            //新模板渲染插屏广告
            MaterialButton(
              color: Colors.blue,
              textColor: Colors.white,
              child: new Text('新模板渲染插屏广告'),
              onPressed: () {
                FlutterUnionad.loadFullScreenVideoAdInteraction(
                  androidCodeId: "946201351", //android 全屏广告id 必填
                  iosCodeId: "946201351", //ios 全屏广告id 必填
                  supportDeepLink: true, //是否支持 DeepLink 选填
                  orientation: FlutterUnionad.AdOrientation.VERTICAL, //视屏方向 选填
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
      _adViewStream?.cancel();
    }
  }
}
