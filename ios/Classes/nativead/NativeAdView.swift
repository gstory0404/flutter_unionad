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
    var viewWidth : Float?
    var viewHeight :Float?

    
    init(_ frame : CGRect,binaryMessenger: FlutterBinaryMessenger , id : Int64, params :Any?) {
        self.frame = frame
        self.container = ADContainerView(frame: frame)
        let dict = params as! NSDictionary
        self.mCodeId = dict.value(forKey: "iosCodeId") as? String
        self.viewWidth = Float(dict.value(forKey: "width") as! Double)
        self.viewHeight = Float(dict.value(forKey: "height") as! Double)
        self.nativeExpressAdManager = BUNativeExpressAdManager()
        super.init()
        self.channel = FlutterMethodChannel.init(name: FlutterUnionadConfig.view.nativeAdView + "_" + String(id), binaryMessenger: binaryMessenger)
        self.loadNativeExpressAd()
    }
    public func view() -> UIView {
        return self.container
    }
    
    private func loadNativeExpressAd(){
        let width = CGFloat(self.viewWidth!)
        let heigh = CGFloat(self.viewHeight!)
        let size = CGSize(width: width, height: heigh)
        let buSlot = BUAdSlot.init()
        buSlot.id = self.mCodeId!
        buSlot.adType = BUAdSlotAdType.feed
        buSlot.position = BUAdSlotPosition.feed
        let bUSize = BUSize.init()
        bUSize.width = Int(width)
        bUSize.height = Int(heigh)
        buSlot.imgSize = bUSize
        self.nativeExpressAdManager = BUNativeExpressAdManager.init(slot: buSlot, adSize: size)
        self.nativeExpressAdManager.delegate = self
        self.nativeExpressAdManager.loadAdData(withCount: 1)
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
    
    public func nativeExpressAdViewPlayerDidPlayFinish(_ nativeExpressAdView: BUNativeExpressAdView, error: Error?) {
        LogUtil.logInstance.printLog(message: "nativeExpressAdViewPlayerDidPlayFinish")
    }
    
    public func nativeExpressAdViewDidCloseOtherController(_ nativeExpressAdView: BUNativeExpressAdView, interactionType: BUInteractionType) {
        LogUtil.logInstance.printLog(message: "nativeExpressAdViewDidCloseOtherController")
    }
    
    
}
