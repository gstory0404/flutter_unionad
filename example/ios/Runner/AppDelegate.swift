import UIKit
import Flutter

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
