import Flutter
import UIKit
import BUAdSDK
import AppTrackingTransparency
import AdSupport

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
        let isDebug = param.value(forKey: "debug") as? Bool ?? false;
        let appId = param.value(forKey: "iosAppId") as? String
        LogUtil.logInstance.isShow(debug: isDebug)
        TTAdManagerHolder.instace.initTTSDK(params: param) { isSuccess, error in
            if(isSuccess){
                result(true)
            }else{
                result(false)
            }
        }
        break
    //获取sdk版本号
    case "getSDKVersion":
        result(BUAdSDKManager.sdkVersion)
        break
    //获取权限AAT ios14以上才有
    case "requestPermissionIfNecessary":
        if #available(iOS 14, *) {
            ATTrackingManager.requestTrackingAuthorization(completionHandler: { status in
                LogUtil.logInstance.printLog(message: status.rawValue)
                result(status.rawValue)
            })
        } else {
            result(3)
        }
        //预加载激励广告
    case "loadRewardVideoAd":
        let param = call.arguments as! NSDictionary
        RewardedVideoAd.instance.loadRewardedVideoAd(params: param)
        result(true)
        break
    //显示激励广告
    case "showRewardVideoAd":
        RewardedVideoAd.instance.showRewardedVideoAd()
        result(true)
        break
    //  预加载新模版渲染插屏广告
    case "loadFullScreenVideoAdInteraction":
        let param = call.arguments as! NSDictionary
        FullScreenVideoAdInteraction.instance.loadFullScreenVideoAdInteraction(params: param)
        result(true)
        break
        //显示新模版渲染插屏广告
    case "showFullScreenVideoAdInteraction":
        FullScreenVideoAdInteraction.instance.showFullScreenVideoAdInteraction()
        result(true)
        break
        //获取主题模式
    case "getThemeStatus":
        result(BUAdSDKManager.themeStatus() == BUAdSDKThemeStatus.normal ? 0 : 1)
        break
    default:
        result(FlutterMethodNotImplemented)
    }
  }
}
