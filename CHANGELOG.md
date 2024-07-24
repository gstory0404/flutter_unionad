## 2.0.5
* fix bug

## 2.0.4
* Android SDK升级6.2.1.7
* iOS SDK升级6.3.0.1
* fix bug

## 2.0.3
* 修复android旧版穿山甲横幅广告无法显示异常

## 2.0.2
* 移除ios全屏广告

## 2.0.1
* 修复gromore激励广告透传参数无效异常

## 2.0.0 
* android、ios切换为融合sdk
* FlutterUnionad.register新增androidPrivacy、iosPrivacy隐私权限配置，移除FlutterUnionad.andridPrivacy
* 移除fullScreenVideoAd全屏广告，使用新版插全屏广告
* 新增FlutterUnionadBannerView横幅广告，旧版FlutterUnionad.bannerAdView后续会移除
* 新增FlutterUnionadDrawFeedAdView Draw视频广告广告，旧版FlutterUnionad.drawFeedAdView后续会移除
* 新增FlutterUnionadNativeAdView信息流广告，旧版FlutterUnionad.nativeAdView后续会移除
* 新增FlutterUnionadSplashAdView开屏广告，旧版FlutterUnionad.splashAdView后续会移除
* 部分配置参数调整，参考文档
* 新版本支持ADN聚合，插件默认仅集成穿山甲，其他ADN广告参考官方文档集成


## 1.3.28
* android sdk升级5.9.0.6
* ios sdk升级5.9.0.4

## 1.3.27
* android sdk升级5.8.0.8
* ios sdk升级5.8.0.7

## 1.3.26
* android sdk升级5.6.0.7
* ios sdk升级5.7.0.1

## 1.3.25
* fix bug
* android sdk升级5.5.1.2
* ios sdk升级5.6.0.0

## 1.3.24
FlutterUnionad.andridPrivacy隐私权限设置新增： 
- isCanUseAndroidId 是否允许SDK主动获取ANDROID_ID
- isCanUsePermissionRecordAudio 是否允许SDK在申明和授权了的情况下使用录音权限

## 1.3.23
* android sdk升级5.4.1.6
* ios sdk升级5.5.0.3

## 1.3.22
* android sdk升级5.4.0.3
* ios sdk升级5.4.0.2
* andorid kt版本升级1.6.10，gradle插件7.1.2 

## 1.3.21
* android sdk升级5.3.0.5
* ios sdk升级5.4.0.0

## 1.3.20
* android sdk升级5.2.0.5
* ios sdk升级5.2.0.1

## 1.3.19
* android sdk升级5.1.0.2
* ios sdk升级5.1.0.2
* 激励广告
FlutterUnionadRewardAdCallBack 新增onCache（激励广告物料缓存成功。建议在这里进行广告展示，可保证播放流畅和展示流畅，用户体验更好。）

## 1.3.18
* 修复ios banner广告点击穿透异常

## 1.3.17
* android sdk升级5.0.0.1
* ios sdk升级5.0.0.0
* 移除 FlutterUnionad.interactionAd 插屏广告
* 移除 FlutterUnionad.setThemeStatus设置主题模式，修改为在初始化FlutterUnionad.register中传入themeStatus FlutterUnionAdTheme来修改，每次修改均需重新初始化
* 移除 FlutterUnionad.nativeAdView参数isUserInteractionEnabled，插件自动处理点击事件穿透
* 移除 FlutterUnionad.nativeAdView参数expressNum

## 1.3.16
* 新增getThemeStatus 获取主题模式
* 新增setThemeStatus 设置主题模式
 
## 1.3.15
* ios升级4.9.0.1
* android升级5.0.0.0

## 1.3.14
* ios升级4.8.0.3
* 兼容ios16 

## 1.3.13
* 优化开屏广告

## 1.3.12
* ios升级4.8.0.1
* android升级4.8.0.3

## 1.3.10
* ios升级4.7.0.8
* 修复ios无法点击异常 [注意事项](https://github.com/gstory0404/flutter_unionad/blob/master/notice.md)
* 激励广告移除mIsExpress 新版本仅支持模版渲染广告

## 1.3.9
* ios升级4.7.1.2
* android升级4.7.0.7
* ios广告优化
* android广告优化

## 1.3.8
* ios升级4.7.0.8
* android升级4.7.0.5
* 适配新版开屏广告

## 1.3.7
* ios 升级4.6.0.7

## 1.3.6
* 修复激励广告参数错误

## 1.3.5
* android sdk升级4.6.0.7
* ios sdk升级4.5.1.6
* BannerAdView 新增 [isUserInteractionEnabled] 是否启用点击 仅ios生效 默认启用 解决点击穿透异常
* BannerAdView 新增 [adLoadType]用于标注此次的广告请求用途为预加载（当做缓存）还是实时加载，[FlutterUnionadLoadType]
* DrawFeedAdView 新增 [adLoadType]用于标注此次的广告请求用途为预加载（当做缓存）还是实时加载，[FlutterUnionadLoadType]
* NativeAdView 新增 [isUserInteractionEnabled] 是否启用点击 仅ios生效 默认启用，解决点击穿透异常
* NativeAdView 新增 [adLoadType]用于标注此次的广告请求用途为预加载（当做缓存）还是实时加载，[FlutterUnionadLoadType]
* loadRewardVideoAd 新增 [adLoadType]用于标注此次的广告请求用途为预加载（当做缓存）还是实时加载，[FlutterUnionadLoadType]
* loadFullScreenVideoAdInteraction 新增 新增 [adLoadType]用于标注此次的广告请求用途为预加载（当做缓存）还是实时加载，[FlutterUnionadLoadType]
* 感谢[BelindaShy](https://github.com/BelindaShy)的 [pr](https://github.com/gstory0404/flutter_unionad/pull/43)

## 1.3.4
* 开屏广告新增onLoadType参数，用于标注此次的广告请求用途为预加载（当做缓存）还是实时加载

## 1.3.3
* Andorid sdk升级[4.6.0.2](https://www.csjplatform.com/union/media/union/download/log?id=4)
* iOS sdk升级[4.4.0.7](https://www.csjplatform.com/union/media/union/download/log?id=16)
* 
## 1.3.2
* fixbug

## 1.3.1
* Andorid sdk升级[4.5.1.1](https://www.csjplatform.com/union/media/union/download/log?id=4)
* iOS sdk升级[4.5.0.0](https://www.csjplatform.com/union/media/union/download/log?id=16)

## 1.3.0
*兼容Flutter3.0

## 1.2.8
*新增个人化推荐管理

## 1.2.7
* Andorid sdk升级4.4.0.2
* iOS sdk升级4.4.0.0
* 激励广告广告新增进阶奖励回调,旧版的回调保留
```dart
///激励广告广告进阶奖励回调参数
/// [isVerify] 是否成功
/// [rewardType]奖励类型
/// [rewardAmount]奖励数量
/// [rewardName]奖励名称
/// [errorCode]错误码
/// [error]错误信息
/// [propose] 建议奖励数量
typedef OnRewardArrived = void Function(
    bool isVerify, int rewardType, int rewardAmount,
    String rewardName, int errorCode, String error, double propose);
```
* Android权限控制FlutterUnionad.andridPrivacy新增  
  alist（是否允许SDK主动获取设备上应用安装列表的采集权限）

## 1.2.6

* android sdk升级4.3.0.8
* 修复android隐私权限设置无返回

## 1.2.5

* ios sdk升级4.3.0.3
* 信息流广告现在支持高度设为0的时候，根据SDK广告返回自动填充高度
* 优化激励广告服务端验证

## 1.2.4

* Android sdk升级4.3.0.1
* ios sdk升级4.3.0.2
* 优化广告Widget在原生加载成功后动态调整大小，与原生view保持一致

## 1.2.3

* Android sdk升级4.2.5.2
* ios sdk升级4.2.5.2
* 优化ios ViewController

## 1.2.2

* Android sdk升级4.2.5.1
* ios sdk升级4.2.5.1

## 1.2.1

* Android sdk升级4.2.0.2
* 所有广告新增downloadType，用于控制下载APP前是否弹出二次确认弹窗，4andorid合规审核

## 1.2.0

* 1、Android sdk升级4.1.0.5
* 2、IOS sdk升级4.2.0.0

## 1.1.9

* 1、修复ios激励广告奖励校验异常

## 1.1.8

* 1、Android sdk升级4.0.2.2
* 2、IOS sdk升级4.1.0.1

## 1.1.7

* 1、Android sdk升级4.0.1.9
* 2、IOS sdk升级4.0.0.5

## 1.1.6

* 1、SDK初始化优化

## 1.1.5

* 1、android sdk更新4.0.1.1
* 2、ios sdk更新4.0.0.2
* 3、激励视频验证结果新增错误码

## 1.1.4

* 1、android sdk更新4.0.0.6
* 2、ios sdk更新4.0.0.1
* 3、优化android sdk初始化

## 1.1.3

* 1、android sdk更新4.0.0.1
* 2、ios sdk更新4.0.0.0

## 1.1.2

* 1、升级android 3.9.0.5
* 2、升级ios 3.9.0.4
* 3、andorid混淆更新

## 1.1.1

* 1、升级android 3.9.0.2
* 2、升级ios 3.9.0.3

## 1.1.0

* API方法名重构，方便聚合插件中引用，使用方法不变

## 1.0.6

*1、android sdk升级3.9.0.0
*  2、iOS SDK升级3.8.1.0
*  3、优化部分代码

## 1.0.5

* 1、降低android gradle版本

## 1.0.4

* 1、优化andorid隐私权限逻辑
*  2、andorid sdk升级为3.8.0.6
*  3、ios sdk升级为3.8.0.2

## 1.0.3

* android sdk指定3.6.1.8,官方Maven仓库库有问题

## 1.0.2

* TODO: 新增android 隐私权限设置

## 1.0.1

* 1、不指定andorid ios sdk版本，编译时拉去最新的
*  2、优化激励广告会调

## 1.0.0

* 1、升级ios sdk为3.6.1.6
*  2、全新的回调api

## 0.1.2
* 1、升级ios sdk为3.6.1.4
*  2、升级Android sdk3.6.1.3
* 3、修复开屏广告个性化使尺寸异常bug


## 0.1.1
* 1、升级ios sdk为3.6.1.1
*  2、升级Android sdk3.6.1.1
* 3、新增null safety支持


## 0.1.0
* 1、升级ios sdk为3.4.4.3
*  2、升级Android sdk3.5.0.4
*  3、新增优化信息流 banner 插屏广告拉取多个随机加载一条

## 0.0.9
* 1、升级Android sdk为3.5.0.2；
*  2、升级ios sdk为3.4.2.8；
*  3、解决激励广告打不开异常

## 0.0.8
* 1、新增ios版本广告轮播时间；
*  2、升级Android sdk为3.4.5.0；
*   3、升级ios sdk为3.4.2.3；
*   4、新增iso14 ATT授权

## 0.0.7

* 1、完善广告逻辑
*  2、新增原生广告view回调
*   3、分别输入广告 Android ios id

## 0.0.6

* 1、修复ios尺寸转化异常

## 0.0.5

* 1、完善剩余ios广告；
*  2、升级ios sdk为3.2.6.2；
*   3、ios14权限适配 新增IDFA获取请求
*   4、andorid sdk升级为3.3.0.0

## 0.0.4

* 优化广告逻辑，添加Android全屏视频广告


## 0.0.3

* 优化ios激励广告

## 0.0.2

* 新增ios激励广告
## 0.0.1

* 新增android端各广告