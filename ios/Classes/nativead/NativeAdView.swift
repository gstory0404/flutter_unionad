// 信息流广告
//  NativeAdView.swift
//  flutter_unionad
//
//  Created by 9Y on 2020/9/28.
//

import Foundation
import BUAdSDK
import Flutter

public class NativeAdView : NSObject,FlutterPlatformView{
    private let container : ADContainerView
    private var nativeExpressAdManager : BUNativeExpressAdManager
    private var channel : FlutterMethodChannel?
    var frame: CGRect;
    //广告需要的参数
    let mCodeId :String?
    var supportDeepLink :Bool? = true
    let expressViewWidth : Float?
    let expressViewHeight :Float?
    var mIsExpress :Bool? = true
    let expressAdNum :Int64?
    let expressTime : Int64?
   
    
    init(_ frame : CGRect,binaryMessenger: FlutterBinaryMessenger , id : Int64, params :Any?) {
        self.frame = frame
        self.container = ADContainerView(frame: frame)
        let dict = params as! NSDictionary
        self.mCodeId = dict.value(forKey: "iosCodeId") as? String
        self.mIsExpress = dict.value(forKey: "mIsExpress") as? Bool
        self.supportDeepLink = dict.value(forKey: "supportDeepLink") as? Bool
        self.expressViewWidth = Float(dict.value(forKey: "expressViewWidth") as! Double)
        self.expressViewHeight = Float(dict.value(forKey: "expressViewHeight") as! Double)
        self.expressAdNum = dict.value(forKey: "expressAdNum") as? Int64
        self.expressTime = dict.value(forKey: "expressTime") as? Int64
        self.nativeExpressAdManager = BUNativeExpressAdManager()
        super.init()
        self.channel = FlutterMethodChannel.init(name: FlutterUnionadConfig.view.nativeAdView + "_" + String(id), binaryMessenger: binaryMessenger)
        self.loadNativeExpressAd()
        self.channel?.setMethodCallHandler({[weak self] call, result in
                    if call.method == "isUserInteractionEnabled" {
                        self?.container.isUserInteractionEnabled = call.arguments as! Bool
                        result(nil)
                        return
                    }
                    result(FlutterMethodNotImplemented)
                })
        LogUtil.logInstance.printLog(message: id)
    }
    public func view() -> UIView {
        return self.container
    }
    
    private func loadNativeExpressAd(){
        let viewWidth = CGFloat(self.expressViewWidth!)
        let viewHeigh = CGFloat(self.expressViewHeight!)
        let size = CGSize(width: viewWidth, height: viewHeigh)
        let buSlot = BUAdSlot.init()
        buSlot.id = self.mCodeId
        buSlot.adType = BUAdSlotAdType.feed
        buSlot.position = BUAdSlotPosition.feed
        let bUSize = BUSize.init()
        bUSize.width = Int(viewWidth)
        bUSize.height = Int(viewHeigh)
        buSlot.imgSize = bUSize
        buSlot.isSupportDeepLink = self.supportDeepLink!
        self.nativeExpressAdManager = BUNativeExpressAdManager.init(slot: buSlot, adSize: size)
        self.nativeExpressAdManager.delegate = self
        self.nativeExpressAdManager.loadAd(1)
        LogUtil.logInstance.printLog(message: "信息流开始加载")
    }
    
    private func removeAllView(){
        self.container.removeFromSuperview()
    }
    
    private func disposeView() {
        self.removeAllView()
    }
}

extension NativeAdView : BUNativeExpressAdViewDelegate{
    
    //view加载成功
    public func nativeExpressAdSuccess(toLoad nativeExpressAd: BUNativeExpressAdManager, views: [BUNativeExpressAdView]) {
        LogUtil.logInstance.printLog(message: "nativeExpressAdSuccess加载成功")
        if(views.count > 0){
            let view = views[0]
            view.rootViewController = MyUtils.getVC()
            view.render()
            self.container.addSubview(view)
        }
    }
    
    //加载失败
    public func nativeExpressAdFail(toLoad nativeExpressAd: BUNativeExpressAdManager, error: Error?) {
        LogUtil.logInstance.printLog(message: "nativeExpressAdFail")
        LogUtil.logInstance.printLog(message: error)
        self.channel?.invokeMethod("onFail", arguments: error?.localizedDescription)
    }
    //渲染成功
    public func nativeExpressAdViewRenderSuccess(_ nativeExpressAdView: BUNativeExpressAdView) {
        let map : NSDictionary = ["width":nativeExpressAdView.frame.size.width,
                                  "height":nativeExpressAdView.frame.size.height]
        self.channel?.invokeMethod("onShow", arguments: map)
        LogUtil.logInstance.printLog(message: "nativeExpressAdViewRenderSuccess")
    }
    //点击不感兴趣
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
        self.channel?.invokeMethod("onClick", arguments: nil)
    }
    
    public func nativeExpressAdViewWillPresentScreen(_ nativeExpressAdView: BUNativeExpressAdView) {
        LogUtil.logInstance.printLog(message: "nativeExpressAdViewWillPresentScreen")
    }
    
    public func nativeExpressAdViewRenderFail(_ nativeExpressAdView: BUNativeExpressAdView, error: Error?) {
        LogUtil.logInstance.printLog(message: "nativeExpressAdViewRenderFail")
        LogUtil.logInstance.printLog(message: error)
        self.disposeView()
        self.channel?.invokeMethod("onFail", arguments: error?.localizedDescription)
    }
    
    public func nativeExpressAdViewPlayerDidPlayFinish(_ nativeExpressAdView: BUNativeExpressAdView, error: Error) {
        LogUtil.logInstance.printLog(message: "nativeExpressAdViewPlayerDidPlayFinish")
    }
    
    public func nativeExpressAdViewDidCloseOtherController(_ nativeExpressAdView: BUNativeExpressAdView, interactionType: BUInteractionType) {
        LogUtil.logInstance.printLog(message: "nativeExpressAdViewDidCloseOtherController")
    }
    
    
}
