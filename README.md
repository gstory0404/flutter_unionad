# 穿山甲广告 flutter版本

<p>
<a href="https://github.com/gstory0404/flutter_unionad"><img src=https://img.shields.io/badge/flutter_unionad-v0.0.4-success></a>
</p>

![image](https://github.com/gstory0404/flutter_unionad/blob/master/image/demo.gif)

## 简介
  flutter_unioad是一款集成了穿山甲Android和iOSSDK的Flutter插件,方便直接调用穿山甲SDK方法开发
## 官方文档
* [Android](https://partner.oceanengine.com/union/media/union/download/detail?id=4&osType=android)
* [IOS](https://partner.oceanengine.com/union/media/union/download/detail?id=16&osType=ios)

## 集成步骤
#### 1、pubspec.yaml
```Dart
flutter_unionad: ^0.0.4
```
引用插件
```Dart
import 'package:flutter_unionad/flutter_unionad.dart' as FlutterUnionad;
```
#### 2、Android
aar文件已集成进插件中无需额外配置，只需要在android目录中AndroidManifest.xml配置
```Java
  <application
        tools:replace="android:label">
```
SDK版本 3.2.0.3

#### 3、IOS
SDK已配置插件中，其余根据SDK文档配置，因为使用PlatformView，在Info.plist加入
```
 <key>io.flutter.embedded_views_preview</key>
    <true/>
```
SDK版本 3.2.0.1

## 使用

#### 1、SDK初始化
```Dart
await FlutterUnionad.register(
        androidAppId: "5098580",
        iosAppId:  "5098580",
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
```
#### 2、获取SDK版本
```Dart
await FlutterUnionad.getSDKVersion();
```

#### 3、请求权限
```Dart
await FlutterUnionad.requestPermissionIfNecessary();
```
#### 4、开屏广告
```Dart
Container(
            height: 700,
            child: FlutterUnionad.splashAdView(
                mCodeId: "887367774",
                supportDeepLink: true,
                mIsExpress: false,
                expressViewWidth: 540,
                expressViewHeight: 800),
          ),
```
监听开屏广告状态
```Dart
 StreamSubscription _adViewStream = FlutterUnionad.adeventEvent
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
        }
      }
    });
```
#### 5、banner广告
```Dart
Container(
              height: 200,
              child: FlutterUnionad.bannerAdView(
                mCodeId: "945410197",
                supportDeepLink: true,
                expressAdNum: 3,
                expressTime: 30,
                expressViewWidth: 1080,
                expressViewHeight: 400,
              ),
            ),
```

#### 6、信息流广告
```
 Container(
              height: 300,
              child: FlutterUnionad.nativeAdView(
                mCodeId: "945417699",
                supportDeepLink: true,
                expressViewWidth: 800,
                expressViewHeight: 600,
              ),
            ), 
```

#### 7、插屏广告
返回原生view
```Dart
FlutterUnionad.interactionAdView(
                  mCodeId: "945417892",
                  supportDeepLink: true,
                  expressViewWidth: 800,
                  expressViewHeight: 1200,
                );
```
直接弹窗
```Dart
FlutterUnionad.interactionExpressAd(
                  mCodeId: "945417892",
                  supportDeepLink: true,
                  expressViewWidth: 800,
                  expressViewHeight: 1200,
                );
```

#### 8、激励视频
```Dart
FlutterUnionad.loadRewardVideoAd(
                    mIsExpress: true,
                    mCodeId: "945418088",
                    supportDeepLink: true,
                    rewardName: "100金币",
                    rewardAmount: 100,
                    userID: "123",
                    orientation: FlutterUnionad.VideoVERTICAL,
                    mediaExtra: null);
```
监听激励视频状态

```Dart
 StreamSubscription _adViewStream = FlutterUnionad.adeventEvent
       .receiveBroadcastStream()
       .listen((data) {
     if (data[FlutterUnionad.adType] == FlutterUnionad.rewardAd) {
       print("激励广告结果----->  rewardVerify=${data[FlutterUnionad.rewardVerify]} "
           "rewardName=${data[FlutterUnionad.rewardName]} "
           "rewardAmount=${data[FlutterUnionad.rewardAmount]} ");
     }
   });
```
#### 9、draw视频广告
```Dart
Center(
              child: FlutterUnionad.drawFeedAdView(
                  mCodeId: "945426252",
                  supportDeepLink: true,
                  expressViewWidth: 1080,
                  expressViewHeight: 1920),
            );
          },
```

### 10、全屏视频广告
```Dart
 FlutterUnionad.fullScreenVideoAd(
                  mCodeId: "945491318",
                  supportDeepLink: true,
                  orientation: FlutterUnionad.VideoVERTICAL);
              }
```
结果监听
```Dart
FlutterUnionad.adeventEvent
       .receiveBroadcastStream()
       .listen((data) {
     if(data[FlutterUnionad.adType] == FlutterUnionad.fullVideoAd){
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
```

## 历史版本
| 版本  | 说明  | 
| :------------ |:---------------:| 
|  0.0.1      | 增加Android各广告的使用，新增ios激励广告 |
|  0.0.3      | 优化广告逻辑 |
|  0.0.4      | 1、优化广告逻辑 2、新增android全屏视频广告|

## 说明
 目前项目中只用到了激励视频，所以该插件只完善了激励视频相关的操作；
 android部分均已完善各个性化广告的使用，ios部分只做了激励视频，
 接下来有空会陆续完善插件。<br/>
 如果有什么建议可以联系我的邮箱 gstory0404@gmail.com
 
