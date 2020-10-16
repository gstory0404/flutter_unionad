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
    var supportDeepLink :Bool? = true
    let expressViewWidth : Float?
    let expressViewHeight :Float?
    var mIsExpress :Bool? = true
    
    init(_ frame : CGRect,binaryMessenger: FlutterBinaryMessenger , id : Int64, params :Any?) {
        self.frame = frame
        self.container = UIView(frame: frame)
        let dict = params as! NSDictionary
        self.mCodeId = dict.value(forKey: "iosCodeId") as? String
        self.mIsExpress = dict.value(forKey: "mIsExpress") as? Bool
        self.supportDeepLink = dict.value(forKey: "supportDeepLink") as? Bool
        self.expressViewWidth = Float(dict.value(forKey: "expressViewWidth") as! Double)
        self.expressViewHeight = Float(dict.value(forKey: "expressViewHeight") as! Double)
        nativeExpressAdManager = BUNativeExpressAdManager()
        super.init()
        self.channel = FlutterMethodChannel.init(name: FlutterUnionadConfig.view.nativeAdView + "_" + String(id), binaryMessenger: binaryMessenger)
        self.loadDrawAd()
    }
    public func view() -> UIView {
        return self.container
    }
    
    public func loadDrawAd(){
        self.removeAllView()
        let bUadSolt = BUAdSlot.init()
        bUadSolt.id = self.mCodeId
        bUadSolt.adType = BUAdSlotAdType.drawVideo
        bUadSolt.isOriginAd = true
        bUadSolt.position = BUAdSlotPosition.top
        bUadSolt.isSupportDeepLink = self.supportDeepLink!
        let size : BUSize = BUSize.init()
        if(self.expressViewWidth == 0 || self.expressViewHeight == 0){
            size.width = Int(MyUtils.getScreenSize().width)
            size.height = Int(MyUtils.getScreenSize().height)
        }else{
            size.width = Int(self.expressViewWidth!)
            size.height = Int(self.expressViewHeight!)
        }
        bUadSolt.imgSize = size
        let adSize = CGSize(width: Int(MyUtils.getScreenSize().width), height: Int(MyUtils.getScreenSize().height))
        self.nativeExpressAdManager = BUNativeExpressAdManager.init(slot: bUadSolt, adSize: adSize)
        self.nativeExpressAdManager.adslot = bUadSolt
        self.nativeExpressAdManager.delegate = self;
        self.nativeExpressAdManager.loadAd(1)
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
        LogUtil.logInstance.printLog(message: "nativeExpressAdSuccess加载成功")
        if(views.count > 0){
            view = views[0]
            view.rootViewController = MyUtils.getVC()
            view.render()
            self.container.addSubview(view)
            self.channel?.invokeMethod("onShow", arguments: "")
        }
    }
    
    //加载失败
    public func nativeExpressAdFail(toLoad nativeExpressAd: BUNativeExpressAdManager, error: Error?) {
        LogUtil.logInstance.printLog(message: "nativeExpressAdFail")
        LogUtil.logInstance.printLog(message: error)
        self.channel?.invokeMethod("onFail", arguments: String(error.debugDescription))
    }
    
    public func nativeExpressAdViewRenderSuccess(_ nativeExpressAdView: BUNativeExpressAdView) {
        LogUtil.logInstance.printLog(message: "nativeExpressAdViewRenderSuccess")
    }
    
    public func nativeExpressAdView(_ nativeExpressAdView: BUNativeExpressAdView, dislikeWithReason filterWords: [BUDislikeWords]) {
        self.disposeView()
        LogUtil.logInstance.printLog(message: "nativeExpressAdView")
        self.channel?.invokeMethod("onDislike", arguments: filterWords[0].name)
    }
    
    public func nativeExpressAdView(_ nativeExpressAdView: BUNativeExpressAdView, stateDidChanged playerState: BUPlayerPlayState) {
        LogUtil.logInstance.printLog(message: "nativeExpressAdView")
    }
    
    public func nativeExpressAdViewWillShow(_ nativeExpressAdView: BUNativeExpressAdView) {
        LogUtil.logInstance.printLog(message: "nativeExpressAdViewWillShow")
    }
    
    public func nativeExpressAdViewDidClick(_ nativeExpressAdView: BUNativeExpressAdView) {
        LogUtil.logInstance.printLog(message: "nativeExpressAdViewDidClick")
    }
    
    public func nativeExpressAdViewWillPresentScreen(_ nativeExpressAdView: BUNativeExpressAdView) {
        LogUtil.logInstance.printLog(message: "nativeExpressAdViewWillPresentScreen")
    }
    
    public func nativeExpressAdViewRenderFail(_ nativeExpressAdView: BUNativeExpressAdView, error: Error?) {
        LogUtil.logInstance.printLog(message: "nativeExpressAdViewRenderFail")
        LogUtil.logInstance.printLog(message: error)
        self.channel?.invokeMethod("onFail", arguments: String(error.debugDescription))
    }
    
    public func nativeExpressAdViewPlayerDidPlayFinish(_ nativeExpressAdView: BUNativeExpressAdView, error: Error) {
        LogUtil.logInstance.printLog(message: "nativeExpressAdViewPlayerDidPlayFinish")
        LogUtil.logInstance.printLog(message: error)
    }
    
    public func nativeExpressAdViewDidCloseOtherController(_ nativeExpressAdView: BUNativeExpressAdView, interactionType: BUInteractionType) {
        LogUtil.logInstance.printLog(message: "nativeExpressAdViewDidCloseOtherController")
    }
}
