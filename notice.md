# 2.0.0
* android、ios切换为融合sdk
* FlutterUnionad.register新增androidPrivacy、iosPrivacy隐私权限配置，移除FlutterUnionad.andridPrivacy
* 移除fullScreenVideoAd全屏广告，使用新版插全屏广告
* 新增FlutterUnionadBannerView横幅广告，旧版FlutterUnionad.bannerAdView后续会移除
* 新增FlutterUnionadDrawFeedAdView Draw视频广告广告，旧版FlutterUnionad.drawFeedAdView后续会移除
* 新增FlutterUnionadNativeAdView信息流广告，旧版FlutterUnionad.nativeAdView后续会移除
* 新增FlutterUnionadSplashAdView开屏广告，旧版FlutterUnionad.splashAdView后续会移除
* 部分配置参数调整，参考文档
* 新版本支持ADN聚合，插件默认仅集成穿山甲，其他ADN广告参考官方文档集成

# 1.3.10
 插件1.3.10以后ios必须添加以下，不然开屏广告无法点击
- swift
  AppDelegate.swift文件
```swift
@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    var navigationController : UINavigationController? = nil
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        GeneratedPluginRegistrant.register(with: self)
        let controller = self.window.rootViewController as! FlutterViewController
        self.navigationController = UINavigationController.init(rootViewController: controller)
        self.window =  UIWindow.init(frame: UIScreen.main.bounds)
        self.window.rootViewController = self.navigationController;
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        self.window.makeKeyAndVisible()
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
}
```
- Object-C
  AppDelegate.m
```objectivec
@interface AppDelegate()
  @property (nonatomic, strong) UINavigationController *navigationController;
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  [GeneratedPluginRegistrant registerWithRegistry:self];
    FlutterViewController *controller = (FlutterViewController*)self.window.rootViewController;
    self.navigationController = [[UINavigationController alloc] initWithRootViewController:controller];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = self.navigationController;
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [self.window makeKeyAndVisible];
  return [super application:application didFinishLaunchingWithOptions:launchOptions];
}
```

# 1.2.6
android 穿山甲SDK 4.3.0.8去除各广告downloadType方法，1.2.6后传入无效


# 1.2.2
插件1.2.2以后 android不再默认集成权限，需手动配置
```java

<!--必要权限-->
<uses-permission android:name="android.permission.INTERNET" />

<!--必要权限，解决安全风险漏洞，发送和注册广播事件需要调用带有传递权限的接口-->
<permission      android:name="${applicationId}.openadsdk.permission.TT_PANGOLIN"
        android:protectionLevel="signature" />

    <uses-permission android:name="${applicationId}.openadsdk.permission.TT_PANGOLIN" /> 
   

<!--可选权限-->
<uses-permission android:name="android.permission.READ_PHONE_STATE" />
<uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />
<uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" />
<uses-permission android:name="android.permission.ACCESS_WIFI_STATE" />
<uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />
<uses-permission android:name="android.permission.REQUEST_INSTALL_PACKAGES"/>
<uses-permission android:name="android.permission.GET_TASKS"/>

<!--可选，穿山甲提供“获取地理位置权限”和“不给予地理位置权限，开发者传入地理位置参数”两种方式上报用户位置，两种方式均可不选，添加位置权限或参数将帮助投放定位广告-->
<!--请注意：无论通过何种方式提供给穿山甲用户地理位置，均需向用户声明地理位置权限将应用于穿山甲广告投放，穿山甲不强制获取地理位置信息-->
<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />

<!-- 如果视频广告使用textureView播放，请务必添加，否则黑屏 -->
<uses-permission android:name="android.permission.WAKE_LOCK" />

<!--demo场景用到的权限，不是必须的-->
<uses-permission android:name="android.permission.RECEIVE_USER_PRESENT" />
<uses-permission android:name="android.permission.SYSTEM_ALERT_WINDOW" />
<uses-permission android:name="android.permission.EXPAND_STATUS_BAR" />

<!-- 穿山甲3400版本新增：建议添加“query_all_package”权限，穿山甲将通过此权限在Android R系统上判定广告对应的应用是否在用户的app上安装，避免投放错误的广告，以此提高用户的广告体验。若添加此权限，需要在您的用户隐私文档中声明！ -->
<uses-permission android:name="android.permission.QUERY_ALL_PACKAGES"/>

```
