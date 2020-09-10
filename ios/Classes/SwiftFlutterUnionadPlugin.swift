import Flutter
import UIKit
import BUAdSDK

public class SwiftFlutterUnionadPlugin: NSObject, FlutterPlugin {
    
  public static var event : FlutterUnionadEnentPlugin?
    
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "flutter_unionad", binaryMessenger: registrar.messenger())
    let instance = SwiftFlutterUnionadPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
    //注册广告view
    FlutterUnionadViewPlugin.register(viewRegistrar:registrar)
    //注册event
    event = FlutterUnionadEnentPlugin.init(registrar)
  }
    
  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    //注册初始化
    case "register":
        let param = call.arguments as! NSDictionary
        TTAdManagerHolder.instace.initTTSDK(params: param)
        result(true)
    //获取sdk版本号
    case "getSDKVersion":
        result("1.0.0")
        //加载激励广告
    case "loadRewardVideoAd":
        let param = call.arguments as! NSDictionary
        TTAdManagerHolder.instace.showRewardedVideoAd(params: param)
        result(true)
    case "":
//        ATTrackingManager.requestTrackingAuthorization(completionHandler: { status in
//          // Tracking authorization completed. Start loading ads here.
//          // loadAd()
//        })
        result(true)
    default:
        result(FlutterMethodNotImplemented)
    }
  }
}
