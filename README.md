# 字节跳动穿山甲广告 Flutter版本

<p>
<a href="https://pub.flutter-io.cn/packages/flutter_unionad"><img src=https://img.shields.io/badge/flutter_unionad-v1.3.18-success></a>
</p>

<img src="https://github.com/gstory0404/flutter_unionad/blob/master/image/demo.gif" width="30%">

## 简介
  flutter_unioad是一款集成了穿山甲Android和iOSSDK的Flutter插件,方便直接调用穿山甲SDK方法开发，已支持null safety,[体验demo](https://www.pgyer.com/j7YB)，可通过[GTAds](https://github.com/gstory0404/GTAds)实现多个广告平台接入、统一管理。
  
## 官方文档
* [Android](https://partner.oceanengine.com/union/media/union/download/detail?id=4&osType=android)
* [IOS](https://partner.oceanengine.com/union/media/union/download/detail?id=16&osType=ios)

## 版本更新

[更新日志](https://github.com/gstory0404/flutter_unionad/blob/master/CHANGELOG.md)

## 注意事项
⚠️ 版本更新必看，不然可能广告加载可能会出现异常
[插件更新调整](https://github.com/gstory0404/flutter_unionad/blob/master/notice.md)

## 本地开发环境
```
[✓] Flutter (Channel stable, 3.3.6, on macOS 13.0.1 22A400 darwin-x64, locale zh-Hans-CN)
[✓] Android toolchain - develop for Android devices (Android SDK version 33.0.0-rc1)
[✓] Xcode - develop for iOS and macOS (Xcode 14.1)
[✓] Chrome - develop for the web
[✓] Android Studio (version 2021.3)
[✓] IntelliJ IDEA Ultimate Edition (version 2022.3)
[✓] VS Code (version 1.73.1)
[✓] Connected device (4 available)
[✓] HTTP Host Availability
```

## 集成步骤
#### 1、pubspec.yaml
```Dart
flutter_unionad: ^1.3.18

//测试版本
flutter_unionad:
  git:
     url: https://github.com/gstory0404/flutter_unionad.git
     ref: dev
```
引入
```Dart
import 'package:flutter_unionad/flutter_unionad.dart';
```
#### 2、Android
SDK([5.0.0.1](https://www.csjplatform.com/union/media/union/download/log?id=4))已配置插件中无需额外配置，只需要在android目录中AndroidManifest.xml配置
```Java
<manifest ···
    xmlns:tools="http://schemas.android.com/tools"
    ···>
  <application
        tools:replace="android:label">
```

#### 3、IOS
SDK([5.0.0.0](https://www.csjplatform.com/union/media/union/download/log?id=16)))已配置插件中，其余根据SDK文档配置，因为使用PlatformView，在Info.plist加入
```
 <key>io.flutter.embedded_views_preview</key>
    <true/>
```


## 使用

#### 1、SDK初始化

⚠️如果要修改个性化，重新调用初始化方法
```Dart
await FlutterUnionad.register(
        //穿山甲广告 Android appid 必填
        androidAppId: "5098580",
        //穿山甲广告 ios appid 必填
        iosAppId: "5098580",
        //使用TextureView控件播放视频,默认为SurfaceView,当有SurfaceView冲突的场景，可以使用TextureView 选填
        useTextureView: true,
        //appname 必填
        appName: "unionad_test",
        //是否允许sdk展示通知栏提示 选填
        allowShowNotify: true,
        //是否在锁屏场景支持展示广告落地页 选填
        allowShowPageWhenScreenLock: true,
        //是否显示debug日志
        debug: true,
        //是否支持多进程，true支持 选填
        supportMultiProcess: true,
        //是否开启个性化推荐 选填 默认开启
        personalise: FlutterUnionadPersonalise.close,
        //主题模式 默认FlutterUnionAdTheme.DAY,修改后需重新调用初始化
        themeStatus: FlutterUnionAdTheme.DAY,
        //允许直接下载的网络状态集合 选填
        directDownloadNetworkType: [
        FlutterUnionadNetCode.NETWORK_STATE_2G,
        FlutterUnionadNetCode.NETWORK_STATE_3G,
        FlutterUnionadNetCode.NETWORK_STATE_4G,
        FlutterUnionadNetCode.NETWORK_STATE_WIFI
        ]
);
```
#### 2、获取SDK版本
```Dart
await FlutterUnionad.getSDKVersion();
```

#### 3、请求权限
```Dart
  FlutterUnionad.requestPermissionIfNecessary(
      callBack: FlutterUnionadPermissionCallBack(
            notDetermined: () {
                print("权限未确定");
            },
            restricted: () {
                print("权限限制");
            },
            denied: () {
                print("权限拒绝");
            },
            authorized: () {
                print("权限同意");
            },
       ),
  );

```
Android获取定位、照片权限，只返回成功

Android相关权限为非必须权限，可选择在AndroidManifest.xml中声明

IOS 版本14及以上获取ATT权限，根据返回结果具体操作业务逻辑

#### 4、开屏广告
```Dart
FlutterUnionad.splashAdView(
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
          //用于标注此次的广告请求用途为预加载（当做缓存）还是实时加载，
          adLoadType: FlutterUnionadLoadType.LOAD,
          //是否影藏跳过按钮(当影藏的时候显示自定义跳过按钮) 默认显示
          hideSkip: false,
          callBack: FlutterUnionadSplashCallBack(
            onShow: () {
              print("开屏广告显示");
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
```
#### 5、banner广告
```Dart
FlutterUnionad.bannerAdView(
              //andrrid banner广告id 必填
              androidCodeId: "945410197",
              //ios banner广告id 必填
              iosCodeId: "945410197",
              //是否使用个性化模版
              mIsExpress: true,
              //是否支持 DeepLink 选填
              supportDeepLink: true,
              //一次请求广告数量 大于1小于3 必填
              expressAdNum: 3,
              //轮播间隔事件 30-120秒  选填
              expressTime: 30,
              // 期望view 宽度 dp 必填
              expressViewWidth: 600.5,
              //期望view高度 dp 必填
              expressViewHeight: 120.5,
              //控制下载APP前是否弹出二次确认弹窗
              downloadType: FlutterUnionadDownLoadType.DOWNLOAD_TYPE_POPUP,
             //用于标注此次的广告请求用途为预加载（当做缓存）还是实时加载，
              adLoadType: FlutterUnionadLoadType.LOAD,
              //是否启用点击 仅ios生效 默认启用
              isUserInteractionEnabled: true,
              //广告事件回调 选填
              callBack: FlutterUnionadBannerCallBack(
                onShow: () {
                  print("banner广告加载完成");
                },
                onDislike: (message){
                  print("banner不感兴趣 $message");
                },
                onFail: (error){
                  print("banner广告加载失败 $error");
                },
                onClick: (){
                  print("banner广告点击");
                }
              ),
            ),
```

#### 6、信息流广告
```dart
//个性化模板信息流广告
FlutterUnionad.nativeAdView(
    //android 信息流广告id 必填
    androidCodeId: "945417699",
    //ios banner广告id 必填
    iosCodeId: "945417699",
    //是否支持 DeepLink 选填
    supportDeepLink: true,
    // 期望view 宽度 dp 必填
    expressViewWidth: 375.5,
    //期望view高度 dp 必填
    expressViewHeight: 0,
    //一次请求广告数量 大于1小于3 必填
    expressNum: 2,
    mIsExpress: true,
    //控制下载APP前是否弹出二次确认弹窗
    downloadType: FlutterUnionadDownLoadType.DOWNLOAD_TYPE_POPUP,
    //用于标注此次的广告请求用途为预加载（当做缓存）还是实时加载，
    adLoadType: FlutterUnionadLoadType.LOAD,
    callBack: FlutterUnionadNativeCallBack(
        onShow: () {
            print("信息流广告显示");
        },
        onFail: (error) {
            print("信息流广告失败 $error");
        },
        onDislike: (message) {
            print("信息流广告不感兴趣 $message");
        },
        onClick: () {
            print("信息流广告点击");
        },
    ),
),

```


#### 8、激励视频广告
预加载激励视频广告
```Dart
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
                  orientation: FlutterUnionadOrientation.VERTICAL,
                  //控制下载APP前是否弹出二次确认弹窗
                  downloadType: FlutterUnionadDownLoadType.DOWNLOAD_TYPE_POPUP,
                  //视屏方向 选填
                  mediaExtra: null, //扩展参数 选填
                  //用于标注此次的广告请求用途为预加载（当做缓存）还是实时加载，
                  adLoadType: FlutterUnionadLoadType.PRELOAD,
                );
```
显示激励视频广告
```dart
 await FlutterUnionad.showRewardVideoAd();
```
监听激励视频结果

```Dart
 FlutterUnionad.FlutterUnionadStream.initAdStream(
      //激励广告
        flutterUnionadRewardAdCallBack: FlutterUnionadRewardAdCallBack(
        onShow: (){
          print("激励广告显示");
        },
        onClick: (){
          print("激励广告点击");
        },
        onFail: (error){
          print("激励广告失败 $error");
        },
        onClose: (){
          print("激励广告关闭");
        },
        onSkip: (){
          print("激励广告跳过");
        },
        onVerify: (rewardVerify,rewardAmount,rewardName){
          print("激励广告奖励  $rewardVerify   $rewardAmount  $rewardName");
        },
         onReady: () async{
          print("激励广告预加载准备就绪");
          //显示激励广告
          await FlutterUnionad.showRewardVideoAd();
        },
        onUnReady: (){
          print("激励广告预加载未准备就绪");
        }, 
        onRewardArrived: (rewardVerify, rewardType, rewardAmount, rewardName,
          errorCode, error, propose) {
            print(
            "阶段激励广告奖励  验证结果=$rewardVerify 奖励类型<FlutterUnionadRewardType>=$rewardType 奖励=$rewardAmount"
            "奖励名称$rewardName 错误码=$errorCode 错误$error 建议奖励$propose");
            }),
      ),
    );
```
#### 9、draw视频广告
```Dart
FlutterUnionad.drawFeedAdView(
                androidCodeId: "945426252",
                // Android draw视屏广告id 必填
                iosCodeId: "945426252",
                //ios draw视屏广告id 必填
                supportDeepLink: true,
                //是否支持 DeepLink 选填
                expressViewWidth: 600.5,
                // 期望view 宽度 dp 必填
                expressViewHeight: 800.5,
                //控制下载APP前是否弹出二次确认弹窗
                downloadType: FlutterUnionadDownLoadType.DOWNLOAD_TYPE_POPUP,
                //用于标注此次的广告请求用途为预加载（当做缓存）还是实时加载，
                adLoadType: FlutterUnionadLoadType.LOAD,
                //期望view高度 dp 必填
                callBack: FlutterUnionadDrawFeedCallBack(
                    onShow: () {
                      print("draw广告显示");
                    },
                    onFail: (error) {
                      print("draw广告加载失败 $error");
                    },
                    onClick: () {
                      print("draw广告点击");
                    },
                    onDislike: (message) {
                      print("draw点击不喜欢 $message");
                    },
                    onVideoPlay: () {
                      print("draw视频播放");
                    },
                    onVideoPause: () {
                      print("draw视频暂停");
                    },
                    onVideoStop: () {
                      print("draw视频结束");
                    }),
              ),
```

#### 10、~~全屏视频广告~~

不推荐使用，请使用新模版渲染插屏广告
```Dart
FlutterUnionad.fullScreenVideoAd(
                  androidCodeId: "945491318", //android 全屏广告id 必填
                  iosCodeId: "945491318", //ios 全屏广告id 必填
                  supportDeepLink: true, //是否支持 DeepLink 选填
                  orientation: FlutterUnionadOrientation.VERTICAL, //视屏方向 选填
                  //控制下载APP前是否弹出二次确认弹窗
                  downloadType: FlutterUnionadDownLoadType.DOWNLOAD_TYPE_POPUP,
                );
```

#### 11、新模版渲染插屏广告  分为全屏和插屏
预加载新模版渲染插屏广告
```dart
FlutterUnionad.loadFullScreenVideoAdInteraction(
                  androidCodeId: "946201351", //android 全屏广告id 必填
                  iosCodeId: "946201351", //ios 全屏广告id 必填
                  supportDeepLink: true, //是否支持 DeepLink 选填
                  orientation: FlutterUnionadOrientation.VERTICAL, //视屏方向 选填
                  //控制下载APP前是否弹出二次确认弹窗
                  downloadType: FlutterUnionadDownLoadType.DOWNLOAD_TYPE_POPUP,
                  //用于标注此次的广告请求用途为预加载（当做缓存）还是实时加载，
                  adLoadType: FlutterUnionadLoadType.PRELOAD,
                );
```

显示新模版渲染插屏广告
```dart
  await FlutterUnionad.showFullScreenVideoAdInteraction();
```

新模版渲染插屏广告结果监听
```dart
FlutterUnionad.FlutterUnionadStream.initAdStream(
      // 新模板渲染插屏广告回调
        flutterUnionadNewInteractionCallBack: FlutterUnionadNewInteractionCallBack(
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
              onReady: () async{
                print("新模板渲染插屏广告预加载准备就绪");
                //显示新模板渲染插屏
                await FlutterUnionad.showFullScreenVideoAdInteraction();
              },
              onUnReady: (){
                print("新模板渲染插屏广告预加载未准备就绪");
              },
            ),
    );
```

#### 12、Android隐私权限控制
注：必须在FlutterUnionad.register初始化前使用才生效
```dart
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
        alist: false,//是否允许SDK主动获取设备上应用安装列表的采集权限
      );
    }
```

#### 13、日间/夜间模式
获取主题模式
```dart
// 0正常模式 1夜间模式
 _themeStatus = await FlutterUnionad.getThemeStatus();
```
切换主题模式

修改初始化中themeStatus参数，重新调用初始化

## 常见问题

[常见问题](https://github.com/gstory0404/flutter_unionad/blob/master/%E5%B8%B8%E8%A7%81%E9%97%AE%E9%A2%98.md)

## 插件链接

|插件|地址|
|:----|:----|
|字节-穿山甲广告插件|[flutter_unionad](https://github.com/gstory0404/flutter_unionad)|
|腾讯-优量汇广告插件|[flutter_tencentad](https://github.com/gstory0404/flutter_tencentad)|
|百度-百青藤广告插件|[baiduad](https://github.com/gstory0404/baiduad)|
|字节-Gromore聚合广告|[gromore](https://github.com/gstory0404/gromore)|
|Sigmob广告|[sigmobad](https://github.com/gstory0404/sigmobad)|
|聚合广告插件(迁移至GTAds)|[flutter_universalad](https://github.com/gstory0404/flutter_universalad)|
|GTAds聚合广告|[GTAds](https://github.com/gstory0404/GTAds)|
|字节穿山甲内容合作插件|[flutter_pangrowth](https://github.com/gstory0404/flutter_pangrowth)|
|文档预览插件|[file_preview](https://github.com/gstory0404/file_preview)|
|滤镜|[gpu_image](https://github.com/gstory0404/gpu_image)|

### 开源不易，觉得有用的话可以请作者喝杯奶茶🧋
<img src="https://github.com/gstory0404/flutter_unionad/blob/master/image/weixin.jpg" width = "200" height = "160" alt="打赏"/>


## 联系方式
* Email: gstory0404@gmail.com
* blog：https://www.gstory.cn/

* QQ群: <a target="_blank" href="https://qm.qq.com/cgi-bin/qm/qr?k=4j2_yF1-pMl58y16zvLCFFT2HEmLf6vQ&jump_from=webapi"><img border="0" src="//pub.idqqimg.com/wpa/images/group.png" alt="649574038" title="flutter交流"></a>
* [Telegram](https://t.me/flutterex)
