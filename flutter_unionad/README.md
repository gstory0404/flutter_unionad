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

`flutter_unionad` 是一款集成了穿山甲 **Android / iOS / 鸿蒙** SDK 的 Flutter 插件，采用**联邦插件（Federated Plugin）**架构：

| 包名 | 说明 |
|:----|:----|
| `flutter_unionad` | 对外统一 API / Widget，统一调度 |
| `unionad_interface` | 平台接口层 |
| `unionad_android` | Android 实现 |
| `unionad_ios` | iOS 实现 |
| `unionad_ohos` | OpenHarmony 实现 |

业务侧只需依赖并使用 `flutter_unionad`，无需关心各端实现细节。  
可通过 [GTAds](https://github.com/gstory0404/GTAds) 实现多广告平台接入、统一管理。

> **API 说明**：`appId`、广告位 `codeId` 已统一为单参数，由调用方按当前平台自行传入对应 id（不再区分 `androidAppId` / `iosAppId` / `ohosAppId` 等）。

## 官方文档
* [Android](https://www.csjplatform.com/union/media/union/download/detail?id=147&osType=android&locale=zh-CN&backPath=/union/media/union/download/pangle)
* [IOS](https://www.csjplatform.com/union/media/union/download/detail?id=148&osType=ios&locale=zh-CN&backPath=/union/media/union/download/pangle)
* [OpenHarmonyOS](https://www.csjplatform.com/)

## 版本更新

[更新日志](https://github.com/gstory0404/flutter_unionad/blob/master/CHANGELOG.md)

## 注意事项
⚠️ 版本更新必看，不然可能广告加载可能会出现异常  
[插件更新调整](https://github.com/gstory0404/flutter_unionad/blob/master/notice.md)

⚠️ 由于融合SDK与旧版部分api不兼容，[2.0.0](https://github.com/gstory0404/flutter_unionad/blob/master/CHANGELOG.md)改动较大,更新后注意查看文档说明

⚠️ 用 gromore 来创建广告位，使用 gromore id 来展示广告

⚠️ 如需需要集成聚合其他广告SDK，需要根据当前插件使用的版本引入对应版本的 Adapter 库，[离线SDK](https://www.123865.com/s/3tw0Td-HTRkh)，根据官方文档进行配置

<img src="https://raw.githubusercontent.com/gstory0404/flutter_unionad/refs/heads/master/image/adspic.png" width="30%">

## 工程结构

```
flutter_unionad/                 # 仓库根目录
├── flutter_unionad/             # 主插件（统一 API）
│   ├── lib/
│   └── example/                 # 示例工程
├── unionad_interface/           # 平台接口
├── unionad_android/             # Android 实现
├── unionad_ios/                 # iOS 实现
└── unionad_ohos/                # 鸿蒙实现
```

## 集成步骤

#### 1、添加依赖

**pub.dev（发布后）：**
```yaml
dependencies:
  flutter_unionad: ^latest
```

**本地 path（联邦插件开发）：**
```yaml
dependencies:
  flutter_unionad:
    path: ../flutter_unionad   # 指向主包目录
```

引入：
```dart
import 'package:flutter_unionad/flutter_unionad.dart';
```

#### 2、Android

[SDK](https://www.csjplatform.com/union/media/union/download/log?id=4) 已配置在 `unionad_android` 中，只需在应用 `android/app/src/main/AndroidManifest.xml` 配置：

```xml
<manifest ···
    xmlns:tools="http://schemas.android.com/tools"
    ···>
  <application
        android:usesCleartextTraffic="true"
        tools:replace="android:label">
```

#### 3、iOS

[SDK](https://www.csjplatform.com/union/media/union/download/log?id=16) 已配置在 `unionad_ios` 中，其余按官方文档配置。因使用 PlatformView，在 `Info.plist` 加入：

```xml
<key>io.flutter.embedded_views_preview</key>
    <true/>
<key>NSAppTransportSecurity</key>
<dict>
    <key>NSAllowsArbitraryLoads</key>
    <true/>
</dict>
```

#### 4、鸿蒙（OpenHarmony）

将示例中的 [.ohpmrc](flutter_unionad/example/ohos/.ohpmrc) 拷贝到你的鸿蒙工程根目录。

鸿蒙侧需使用 **OpenHarmony Flutter SDK** 构建（含 `OhosView`）。

## 使用

> 以下示例中的 `appId` / `codeId` 请替换为你在穿山甲后台申请的、**当前平台对应**的 id。  
> 可参考示例工程按平台切换 id 的写法：[`flutter_unionad/example/lib/ad_config.dart`](flutter_unionad/example/lib/ad_config.dart)

#### 1、SDK 初始化

⚠️ 如果要修改个性化配置，重新调用初始化方法。

```dart
await FlutterUnionad.register(
    // 穿山甲 appId（按当前平台自行传入）
    appId: "5098580",
    // appname 必填
    appName: "unionad_test",
    // 使用聚合功能一定要打开此开关，否则不会请求聚合广告，默认这个值为 false
    // true 使用 GroMore 下的广告位
    // false 使用广告变现下的广告位
    useMediation: true,
    // 是否为计费用户 选填
    paid: false,
    // 用户画像的关键词列表 选填
    keywords: "",
    // 是否允许 sdk 展示通知栏提示 选填
    allowShowNotify: true,
    // 是否显示 debug 日志
    debug: true,
    // 是否支持多进程 选填
    supportMultiProcess: false,
    // 主题模式 默认 FlutterUnionAdTheme.DAY，修改后需重新调用初始化
    themeStatus: _themeStatus,
    // 允许直接下载的网络状态集合 选填
    directDownloadNetworkType: [
      FlutterUnionadNetCode.NETWORK_STATE_2G,
      FlutterUnionadNetCode.NETWORK_STATE_3G,
      FlutterUnionadNetCode.NETWORK_STATE_4G,
      FlutterUnionadNetCode.NETWORK_STATE_WIFI
    ],
    androidPrivacy: AndroidPrivacy(
        isCanUseLocation: false,
        lat: 0.0,
        lon: 0.0,
        isCanUsePhoneState: false,
        imei: "",
        isCanUseWifiState: false,
        macAddress: "",
        isCanUseWriteExternal: false,
        oaid: "b69cd3cf68900323",
        alist: false,
        isCanUseAndroidId: false,
        androidId: "",
        isCanUsePermissionRecordAudio: false,
        isLimitPersonalAds: false,
        isProgrammaticRecommend: false,
        userPrivacyConfig: {
          "mcod": "0",
          "installUninstallListen": "0",
        }),
    iosPrivacy: IOSPrivacy(
        limitPersonalAds: false,
        limitProgrammaticAds: false,
        forbiddenCAID: false,
    ),
    userInfo: UnionadUserInfo(
        userId: "unionad_123",
        age: 19,
        gender: 2,
        channel: "flutter",
        subChannel: "flutter_unionad",
        userValueGroup: "QQ",
        customInfos: {
          "QQ": "123",
          "WeChat": "456",
        }),
    // 配置拉取失败时导入本地配置 https://www.csjplatform.com/supportcenter/5885
    // android 导入 /android/app/src/main/assets/，文件必须为 json，传入文件名
    // ios 导入 /ios/，文件必须为 json，传入文件名
    localConfig: "site_config_5098580",
);
```

按平台传入 `appId` 示例：

```dart
import 'package:flutter/foundation.dart';

String get appId {
  switch (defaultTargetPlatform) {
    case TargetPlatform.iOS:
      return "你的iOS_AppId";
    case TargetPlatform.android:
      return "你的Android_AppId";
    default:
      return "你的鸿蒙_AppId";
  }
}

await FlutterUnionad.register(appId: appId, appName: "unionad_test", ...);
```

#### 2、获取 SDK 版本

```dart
await FlutterUnionad.getSDKVersion();
```

#### 3、请求权限

```dart
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

Android 获取定位、照片权限，只返回成功。  
Android 相关权限为非必须权限，可选择在 AndroidManifest.xml 中声明。  
iOS 14 及以上获取 ATT 权限，根据返回结果处理业务逻辑。

#### 4、开屏广告

```dart
FlutterUnionadSplashAdView(
  // 广告位 id（按当前平台自行传入）
  codeId: "102729400",
  supportDeepLink: true,
  width: MediaQuery.of(context).size.width,
  height: MediaQuery.of(context).size.height - 100,
  hideSkip: false,
  timeout: 3000,
  callBack: FlutterUnionadSplashCallBack(
    onShow: () {
      print("开屏广告显示");
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
)
```

#### 5、Banner 广告

```dart
FlutterUnionadBannerView(
  // 广告位 id（按当前平台自行传入）
  codeId: "102735527",
  width: 600.5,
  height: 120.5,
  callBack: FlutterUnionadBannerCallBack(
    onShow: () {
      print("banner广告加载完成");
    },
    onDislike: (message) {
      print("banner不感兴趣 $message");
    },
    onFail: (error) {
      print("banner广告加载失败 $error");
    },
    onClick: () {
      print("banner广告点击");
    },
  ),
)
```

#### 6、信息流广告

```dart
FlutterUnionadNativeAdView(
  // 广告位 id（按当前平台自行传入）
  codeId: "102730271",
  supportDeepLink: true,
  width: 375.5,
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
)
```

#### 7、激励视频广告

预加载：

```dart
FlutterUnionad.loadRewardVideoAd(
  // 广告位 id（按当前平台自行传入）
  codeId: "102733764",
  rewardName: "200金币",
  rewardAmount: 200,
  userID: "123",
  orientation: FlutterUnionadOrientation.VERTICAL,
  mediaExtra: null,
);
```

展示：

```dart
await FlutterUnionad.showRewardVideoAd();
```

结果监听：

```dart
FlutterUnionadStream.initAdStream(
  flutterUnionadRewardAdCallBack: FlutterUnionadRewardAdCallBack(
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
    onVerify: (rewardVerify, rewardAmount, rewardName) {
      print("激励广告奖励  $rewardVerify   $rewardAmount  $rewardName");
    },
    onReady: () async {
      print("激励广告预加载准备就绪");
      await FlutterUnionad.showRewardVideoAd();
    },
    onCache: () async {
      print("激励广告物料缓存成功。建议在这里进行广告展示，可保证播放流畅和展示流畅，用户体验更好。");
    },
    onUnReady: () {
      print("激励广告预加载未准备就绪");
    },
    onRewardArrived: (rewardVerify, rewardType, rewardAmount, rewardName,
        errorCode, error, propose) {
      print(
          "阶段激励广告奖励  验证结果=$rewardVerify 奖励类型=$rewardType 奖励=$rewardAmount "
          "奖励名称$rewardName 错误码=$errorCode 错误$error 建议奖励$propose");
    },
  ),
);
```

#### 8、Draw 视频广告

```dart
FlutterUnionadDrawFeedAdView(
  // 广告位 id（按当前平台自行传入）
  codeId: "102734241",
  width: 600.5,
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
)
```

#### 9、新模板渲染插屏（全屏 / 插屏）

预加载：

```dart
FlutterUnionad.loadFullScreenVideoAdInteraction(
  // 广告位 id（按当前平台自行传入）
  codeId: "102735530",
  orientation: FlutterUnionadOrientation.VERTICAL,
);
```

展示：

```dart
await FlutterUnionad.showFullScreenVideoAdInteraction();
```

结果监听：

```dart
FlutterUnionadStream.initAdStream(
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
    onReady: () async {
      print("新模板渲染插屏广告预加载准备就绪");
      await FlutterUnionad.showFullScreenVideoAdInteraction();
    },
    onUnReady: () {
      print("新模板渲染插屏广告预加载未准备就绪");
    },
  ),
);
```

#### 10、日间 / 夜间模式

获取主题模式：

```dart
// 0 正常模式 1 夜间模式
_themeStatus = await FlutterUnionad.getThemeStatus();
```

切换主题：修改初始化中的 `themeStatus`，重新调用初始化。

#### 11、ecpm 说明

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
