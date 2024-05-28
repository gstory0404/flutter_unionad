// draw视频广告
//  DrawFeedAd.swift
//  flutter_unionad
//
//  Created by gstory0404@gmail on 2020/9/27.
//
import Foundation
import BUAdSDK
import Flutter

public class DrawFeedAdView : NSObject,FlutterPlatformView{
    private var container : UIView
    private var nativeExpressAdManager : BUNativeExpressAdManager
    private var channel : FlutterMethodChannel?
    var frame: CGRect;
    //广告需要的参数
    let mCodeId :String?
    var viewWidth : Float?
    var viewHeight :Float?
    
    init(_ frame : CGRect,binaryMessenger: FlutterBinaryMessenger , id : Int64, params :Any?) {
        self.frame = frame
        self.container = UIView(frame: frame)
        let dict = params as! NSDictionary
        self.mCodeId = dict.value(forKey: "iosCodeId") as? String
        self.viewWidth = Float(dict.value(forKey: "width") as! Double)
        self.viewHeight = Float(dict.value(forKey: "height") as! Double)
        nativeExpressAdManager = BUNativeExpressAdManager()
        super.init()
        self.channel = FlutterMethodChannel.init(name: FlutterUnionadConfig.view.drawFeedAdView + "_" + String(id), binaryMessenger: binaryMessenger)
        self.loadDrawAd()
    }
    public func view() -> UIView {
        return self.container
    }
    
    public func loadDrawAd(){
        self.removeAllView()
        let bUadSolt = BUAdSlot.init()
        bUadSolt.id = self.mCodeId!
        let adSize = CGSizeMake(CGFloat(self.viewWidth!),CGFloat(self.viewHeight!))
        bUadSolt.adSize = adSize
        bUadSolt.mediation.mutedIfCan = false; // 静音 聚合功能
        self.nativeExpressAdManager = BUNativeExpressAdManager.init(slot: bUadSolt, adSize:  adSize)
        self.nativeExpressAdManager.delegate = self;
        self.nativeExpressAdManager.loadAdData(withCount: 1)
    }
    
    private func removeAllView(){
        self.container.removeFromSuperview()
    }
    
    private func disposeView() {
        self.removeAllView()
    }
}

extension DrawFeedAdView : BUNativeExpressAdViewDelegate{
    //view加载成功
    public func nativeExpressAdSuccess(toLoad nativeExpressAd: BUNativeExpressAdManager, views: [BUNativeExpressAdView]) {
        let view : BUNativeExpressAdView
        LogUtil.logInstance.printLog(message: "DrawfeedAd加载成功")
        if(views.count > 0){
            view = views[0]
            view.rootViewController = MyUtils.getVC()
            view.render()
            self.container.addSubview(view)
            let map : NSDictionary = ["width":view.frame.size.width,
                                      "height":view.frame.size.height]
            self.channel?.invokeMethod("onShow", arguments: map)
        }
    }
    
    //加载失败
    public func nativeExpressAdFail(toLoad nativeExpressAd: BUNativeExpressAdManager, error: Error?) {
        LogUtil.logInstance.printLog(message: "DrawfeedAd Fail")
        LogUtil.logInstance.printLog(message: error)
        self.channel?.invokeMethod("onFail", arguments: error?.localizedDescription)
    }
    
    public func nativeExpressAdViewRenderSuccess(_ nativeExpressAdView: BUNativeExpressAdView) {
        LogUtil.logInstance.printLog(message: "DrawfeedAd RenderSuccess")
    }
    
    public func nativeExpressAdView(_ nativeExpressAdView: BUNativeExpressAdView, dislikeWithReason filterWords: [BUDislikeWords]) {
        self.disposeView()
        LogUtil.logInstance.printLog(message: "DrawfeedAd onDislike")
        self.channel?.invokeMethod("onDislike", arguments: filterWords[0].name)
    }
    
    public func nativeExpressAdView(_ nativeExpressAdView: BUNativeExpressAdView, stateDidChanged playerState: BUPlayerPlayState) {
        switch playerState {
        case BUPlayerPlayState.statePlaying:
            self.channel?.invokeMethod("onVideoPlay", arguments: "")
            break
        case BUPlayerPlayState.statePause:
            self.channel?.invokeMethod("onVideoPause", arguments: "")
            break
        case BUPlayerPlayState.stateStopped:
            self.channel?.invokeMethod("onVideoStop", arguments: "")
            break
        default:
            break
        }
    
    }
    
    public func nativeExpressAdViewWillShow(_ nativeExpressAdView: BUNativeExpressAdView) {
        LogUtil.logInstance.printLog(message: "DrawfeedAd WillShow")
    }
    
    public func nativeExpressAdViewDidClick(_ nativeExpressAdView: BUNativeExpressAdView) {
        LogUtil.logInstance.printLog(message: "DrawfeedAd DidClick")
        self.channel?.invokeMethod("onClick", arguments: nil)
    }
    
    public func nativeExpressAdViewWillPresentScreen(_ nativeExpressAdView: BUNativeExpressAdView) {
        LogUtil.logInstance.printLog(message: "DrawfeedAd WillPresentScreen")
    }
    
    public func nativeExpressAdViewRenderFail(_ nativeExpressAdView: BUNativeExpressAdView, error: Error?) {
        LogUtil.logInstance.printLog(message: "DrawfeedAdv RenderFail")
        LogUtil.logInstance.printLog(message: error)
        self.channel?.invokeMethod("onFail", arguments: error?.localizedDescription)
    }
    
    public func nativeExpressAdViewDidCloseOtherController(_ nativeExpressAdView: BUNativeExpressAdView, interactionType: BUInteractionType) {
        LogUtil.logInstance.printLog(message: "DrawfeedAd DidCloseOtherController")
    }
}
