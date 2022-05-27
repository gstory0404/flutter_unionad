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