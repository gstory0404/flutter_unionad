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
        LogUtil.logInstance.isShow(debug: param.value(forKey: "debug") as? Bool ?? false)
        //如果已经初始化 就不再初始化
        if(TTAdManagerHolder.instace.isInit){
            result(true)
            break
        }
        TTAdManagerHolder.instace.initTTSDK(params: param) { isSuccess, error in
            if(isSuccess){
                TTAdManagerHolder.instace.isInit = true
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
//                switch (status) {
//                    //同意授权
//                    case ATTrackingManager.AuthorizationStatus.authorized:
//                        result(true)
//                        break
//                    //拒绝
//                    case ATTrackingManager.AuthorizationStatus.denied:
//                        result(false)
//                        break
//                        //用户未做选择或未弹窗
//                    case ATTrackingManager.AuthorizationStatus.notDetermined:
//                        result(false)
//                        break
//                    default:
//                        result(false)
//                        break
//                }
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
        let param = call.arguments as! NSDictionary
        RewardedVideoAd.instance.showRewardedVideoAd()
        result(true)
        break
            //加载全屏广告
    case "fullScreenVideoAd":
        print(call.arguments!)
        let param = call.arguments as! NSDictionary
        FullscreenVideoAd.instance.showFullscreenVideoAd(params: param)
        result(true)
        break
        //插屏广告
    case "interactionAd":
        let param = call.arguments as! NSDictionary
        InteractionAd.instance.showInteractionAd(params: param)
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
        let param = call.arguments as! NSDictionary
        FullScreenVideoAdInteraction.instance.showFullScreenVideoAdInteraction()
        result(true)
        break
    default:
        result(FlutterMethodNotImplemented)
    }
  }
}
