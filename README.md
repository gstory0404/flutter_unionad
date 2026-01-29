# 字节跳动穿山甲广告 Flutter版本

<p>
<a href="https://pub.dev/packages/flutter_unionad"><img src=https://img.shields.io/pub/v/flutter_unionad?color=orange></a>
<a href="https://pub.dev/packages/flutter_unionad"><img src=https://img.shields.io/pub/likes/flutter_unionad></a>
<a href="https://pub.dev/packages/flutter_unionad"><img src=https://img.shields.io/pub/points/flutter_unionad></a>
<a href="https://github.com/gstory0404/flutter_unionad/commits"><img src=https://img.shields.io/github/last-commit/gstory0404/flutter_unionad></a>
<a href="https://github.com/gstory0404/flutter_unionad"><img src=https://img.shields.io/github/stars/gstory0404/flutter_unionad></a>
</p>
<p>
<a href="http://qm.qq.com/cgi-bin/qm/qr?_wv=1027&k=VhD0AZSmzvsD3fu7CeQFkzpBQHMHANb1&authKey=W7JGJ0HKklyhP1jyBvbTF2Dkw0cq4UmhVSx2zXVdIm6n48Xrto%2B7%2B1n9jbkAadyF&noverify=0&group_code=649574038"><img src=https://img.shields.io/badge/flutter%E4%BA%A4%E6%B5%81%E7%BE%A4-649574038-blue></a>
<a href="http://qm.qq.com/cgi-bin/qm/qr?_wv=1027&k=9I9lyXewEsEnx0f00EOF_9hEcFmG5Bmg&authKey=AJfQ8%2FhOLcoJ0p5B16EITjFav1IIs3UAerZSUsWZfa0evuklgxibHti51AYlZgI3&noverify=0&group_code=769626410"><img src=https://img.shields.io/badge/flutter%E4%BA%A4%E6%B5%81%E7%BE%A42-769626410-blue></a>
<a href="https://qm.qq.com/q/4MSgZuKimc"><img src=https://img.shields.io/badge/flutte%E6%8F%92%E4%BB%B6%E5%8F%8D%E9%A6%88-662186116-blue></a>
</p>

<img src="https://github.com/gstory0404/flutter_unionad/blob/master/image/demo.gif" width="30%">

## 简介
  flutter_unioad是一款集成了穿山甲Android和iOSSDK的Flutter插件,方便直接调用穿山甲SDK方法开发，已支持null safety,[体验demo](https://www.pgyer.com/j7YB)，可通过[GTAds](https://github.com/gstory0404/GTAds)实现多个广告平台接入、统一管理。
  
## 官方文档
* [Android](https://www.csjplatform.com/union/media/union/download/detail?id=147&osType=android&locale=zh-CN&backPath=/union/media/union/download/pangle)
* [IOS](https://www.csjplatform.com/union/media/union/download/detail?id=148&osType=ios&locale=zh-CN&backPath=/union/media/union/download/pangle)
* [OpenHarmonyOS]()

## 版本更新

[更新日志](https://github.com/gstory0404/flutter_unionad/blob/master/CHANGELOG.md)

## 注意事项
⚠️ 版本更新必看，不然可能广告加载可能会出现异常
[插件更新调整](https://github.com/gstory0404/flutter_unionad/blob/master/notice.md)

⚠️ 由于融合SDK与旧版部分api不兼容，[2.0.0](https://github.com/gstory0404/flutter_unionad/blob/master/CHANGELOG.md)改动较大,更新后注意查看文档说明

⚠️ 用gromore来创建广告位，使用gromore id来展示广告

⚠️ 如需需要集成聚合其他广告SDK，需要根据当前插件使用的版本引入对应版本的Adapter库，[离线SDK](https://www.123865.com/s/3tw0Td-HTRkh)，根据官方文档进行配置


<img src="https://raw.githubusercontent.com/gstory0404/flutter_unionad/refs/heads/master/adspic.png" width="30%">


## 本地开发环境
```
[✓] Flutter (Channel stable, 3.22.1, on macOS 14.5 23F79 darwin-x64, locale zh-Hans-CN)
[✓] Android toolchain - develop for Android devices (Android SDK version 33.0.1)
[✓] Xcode - develop for iOS and macOS (Xcode 15.2)
[✓] Chrome - develop for the web
[✓] Android Studio (version 2022.1)
[✓] IntelliJ IDEA Ultimate Edition (version 2024.1.2)
[✓] VS Code (version 1.89.1)
[✓] Connected device (3 available)
[✓] Network resources
```

## 集成步骤
#### 1、pubspec.yaml
```Dart
flutter_unionad: ^latest
```
引入
```Dart
import 'package:flutter_unionad/flutter_unionad.dart';
```
#### 2、Android
[SDK](https://www.csjplatform.com/union/media/union/download/log?id=4)已配置插件中无需额外配置，只需要在android目录中AndroidManifest.xml配置
```Java
<manifest ···
    xmlns:tools="http://schemas.android.com/tools"
    ···>
  <application
        android:usesCleartextTraffic="true"
        tools:replace="android:label">
```

#### 3、IOS
[SDK](https://www.csjplatform.com/union/media/union/download/log?id=16)已配置插件中，其余根据SDK文档配置，因为使用PlatformView，在Info.plist加入
```
<key>io.flutter.embedded_views_preview</key>
    <true/>
<key>NSAppTransportSecurity</key>
<dict>
    <key>NSAllowsArbitraryLoads</key>
    <true/>
</dict>
```

#### 4、鸿蒙next
##### 需要把下面这个文件拷贝到你的鸿蒙项目根目录下
[.ohpmrc](example/ohos/.ohpmrc)



## 使用

#### 1、SDK初始化

⚠️如果要修改个性化，重新调用初始化方法
```Dart
await FlutterUnionad.register(
    //穿山甲广告 Android appid 必填
    androidAppId: "5098580",
    //穿山甲广告 ios appid 必填
    iosAppId: "5098580",
    //appname 必填
    appName: "unionad_test",
    //使用聚合功能一定要打开此开关，否则不会请求聚合广告，默认这个值为false
    //true使用GroMore下的广告位
    //false使用广告变现下的广告位
    useMediation: true,
    //是否为计费用户 选填
    paid: false,
    //用户画像的关键词列表 选填
    keywords: "",
    //是否允许sdk展示通知栏提示 选填
    allowShowNotify: true,
    //是否显示debug日志
    debug: true,
    //是否支持多进程 选填
    supportMultiProcess: false,
    //主题模式 默认FlutterUnionAdTheme.DAY,修改后需重新调用初始化
    themeStatus: _themeStatus,
    //允许直接下载的网络状态集合 选填
    directDownloadNetworkType: [
    FlutterUnionadNetCode.NETWORK_STATE_2G,
    FlutterUnionadNetCode.NETWORK_STATE_3G,
    FlutterUnionadNetCode.NETWORK_STATE_4G,
    FlutterUnionadNetCode.NETWORK_STATE_WIFI
    ],
    androidPrivacy: AndroidPrivacy(
        //是否允许SDK主动使用地理位置信息 true可以获取，false禁止获取。默认为true
        isCanUseLocation: false,
        //当isCanUseLocation=false时，可传入地理位置信息，穿山甲sdk使用您传入的地理位置信息lat
        lat: 0.0,
        //当isCanUseLocation=false时，可传入地理位置信息，穿山甲sdk使用您传入的地理位置信息lon
        lon: 0.0,
        // 是否允许SDK主动使用手机硬件参数，如：imei
        isCanUsePhoneState: false,
        //当isCanUsePhoneState=false时，可传入imei信息，穿山甲sdk使用您传入的imei信息
        imei: "",
        // 是否允许SDK主动使用ACCESS_WIFI_STATE权限
        isCanUseWifiState: false,
        // 当isCanUseWifiState=false时，可传入Mac地址信息
        macAddress: "",
        // 是否允许SDK主动使用WRITE_EXTERNAL_STORAGE权限
        isCanUseWriteExternal: false,
        // 开发者可以传入oaid
        oaid: "b69cd3cf68900323",
        // 是否允许SDK主动获取设备上应用安装列表的采集权限
        alist: false,
        // 是否能获取android ID
        isCanUseAndroidId: false,
        // 开发者可以传入android ID
        androidId: "",
        // 是否允许SDK在申明和授权了的情况下使用录音权限
        isCanUsePermissionRecordAudio: false,
        // 是否限制个性化推荐接口
        isLimitPersonalAds: false,
        // 是否启用程序化广告推荐 true启用 false不启用
        isProgrammaticRecommend: false,
        userPrivacyConfig: {
            //控制oaid获取频率，"0"表示关闭，“1"或者其他值表示打开。
            "mcod":"0",
            //关闭后台监听应用安装、更新、卸载行为
            "installUninstallListen": "0",
        }
    ),
    iosPrivacy: IOSPrivacy(
        //允许个性化广告
        limitPersonalAds: false,
        //允许程序化广告
        limitProgrammaticAds: false,
        //允许CAID
        forbiddenCAID: false,
    ),
    //配置拉取失败时导入本地配置 https://www.csjplatform.com/supportcenter/5885
    //android导入/android/app/src/main/assets/下，文件必须为json文件，传入文件名
    //ios导入/ios/下，文件必须为json文件，传入文件名
    localConfig: "site_config_5098580",
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
FlutterUnionadSplashAdView(
    //android 开屏广告广告id 必填 889033013 102729400
    androidCodeId: "102729400",
    //ios 开屏广告广告id 必填
    iosCodeId: "102729400",
    //是否支持 DeepLink 选填
    supportDeepLink: true,
    // 期望view 宽度 dp 选填
    width: MediaQuery.of(context).size.width,
    //期望view高度 dp 选填
    height: MediaQuery.of(context).size.height - 100,
    //是否影藏跳过按钮(当影藏的时候显示自定义跳过按钮) 默认显示
    hideSkip: false,
    //超时时间
    timeout: 3000,
    callBack: FlutterUnionadSplashCallBack(
        onShow: () {
            print("开屏广告显示");
            setState(() => _offstage = false);
        },
        onClick: () {
            print("开屏广告点击");
        },
        onFail: (error) {
            print("开屏广告失败 $error");
            Navigator.pop(context);
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
FlutterUnionadBannerView(
    //andrrid banner广告id 必填
    androidCodeId: "102735527",
    //ios banner广告id 必填
    iosCodeId: "102735527",
    // 期望view 宽度 dp 必填
    width: 600.5,
    //期望view高度 dp 必填
    height: 120.5,
    //广告事件回调 选填
    callBack: FlutterUnionadBannerCallBack(onShow: () {
            print("banner广告加载完成");
        }, onDislike: (message) {
            print("banner不感兴趣 $message");
        }, onFail: (error) {
            print("banner广告加载失败 $error");
        }, onClick: () {
            print("banner广告点击");
        },
    ),
),
```

#### 6、信息流广告
```dart
//个性化模板信息流广告
FlutterUnionadNativeAdView(
    //android 信息流广告id 必填
    androidCodeId: "102730271",
    //ios banner广告id 必填
    iosCodeId: "102730271",
    //是否支持 DeepLink 选填
    supportDeepLink: true,
    // 期望view 宽度 dp 必填
    width: 375.5,
    //期望view高度 dp 必填
    height: 0,
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
    //是否个性化 选填
    androidCodeId: "102733764",
    //Android 激励视频广告id  必填
    iosCodeId: "102733764",
    //ios 激励视频广告id  必填
    rewardName: "200金币",
    //奖励名称 选填
    rewardAmount: 200,
    //奖励数量 选填
    userID: "123",
    //  用户id 选填
    orientation: FlutterUnionadOrientation.VERTICAL,
    //视屏方向 选填
    mediaExtra: null,
    //扩展参数 选填
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
          await FlutterUnionad.showRewardVideoAd();
        }, 
        onCache: () async {
          print("激励广告物料缓存成功。建议在这里进行广告展示，可保证播放流畅和展示流畅，用户体验更好。");
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
FlutterUnionadDrawFeedAdView(
    androidCodeId: "102734241",
    iosCodeId: "102734241",
    //是否支持 DeepLink 选填
    width: 600.5,
    // 期望view 宽度 dp 必填
    height: 800.5,
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
        },
    ),
);
```

#### 11、新模版渲染插屏广告 分为全屏和插屏
预加载新模版渲染插屏广告
```dart
FlutterUnionad.loadFullScreenVideoAdInteraction(
    //android 全屏广告id 必填
    androidCodeId: "102735530",
    //ios 全屏广告id 必填
    iosCodeId: "102735530",
    //视屏方向 选填
    orientation: FlutterUnionadOrientation.VERTICAL,
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

#### 13、日间/夜间模式
获取主题模式
```dart
// 0正常模式 1夜间模式
 _themeStatus = await FlutterUnionad.getThemeStatus();
```
切换主题模式

修改初始化中themeStatus参数，重新调用初始化

#### 14 ecpm说明
```
/// [adnName] ADN的名称，与平台配置一致，自定义ADN时为ADN唯一标识
/// [customAdnName] 自定义ADN的名称，与平台配置一致，非自定义ADN为nil
/// [slotID] 代码位
/// [levelTag] 价格标签，多阶底价下有效
/// [ecpm] 返回价格，nil为无权限
/// [biddingType] 广告类型
/// [errorMsg] 额外错误信息,一般为空(扩展字段)
/// [requestID] adn提供的真实广告加载ID，可为空
/// [creativeID] adn提供的真实广告创意ID，可为空
/// [adRitType] 广告位类型
/// [segmentId] 流量分组ID
/// [abtestId] AB实验分组ID
/// [channel] 渠道名称
/// [subChannel] 子渠道名称
/// [scenarioId] 场景ID
/// [subRitType] 混用类型，banner/fullVideo/rewardVideo/feed/draw/interstitial
```

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

