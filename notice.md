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
