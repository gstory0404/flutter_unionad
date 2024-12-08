//banner广告
//  BannerExpressAdView.swift
//  flutter_unionad
// 个性化模板Banner广告
//  Created by gstory0404@gmail on 2020/9/4.
//
import Foundation
import BUAdSDK
import Flutter

public class BannerAdView : NSObject,FlutterPlatformView{
    private var container : ADContainerView
    var frame: CGRect;
    private var channel : FlutterMethodChannel?
    
    init(_ frame : CGRect,binaryMessenger: FlutterBinaryMessenger , id : Int64, params :Any?) {
        self.frame = frame
        self.container = ADContainerView(frame: frame)
        let dict = params as! NSDictionary
        super.init()
        self.channel = FlutterMethodChannel.init(name: FlutterUnionadConfig.view.bannerAdView + "_" + String(id), binaryMessenger: binaryMessenger)
        self.container = MyBannerView(frame: frame, dict: dict, methodChannel: channel!)
    }
    
    public func view() -> UIView {
        return self.container
    }
    
    deinit {
        container.removeFromSuperview()
    }
}

class MyBannerView : ADContainerView{
    private var channel : FlutterMethodChannel?
    //广告需要的参数
    var mCodeId :String?
    var viewWidth : Float?
    var viewHeight :Float?
    
    init(frame: CGRect, dict:NSDictionary, methodChannel: FlutterMethodChannel) {
        self.mCodeId = dict.value(forKey: "iosCodeId") as? String
        self.viewWidth = Float(dict.value(forKey: "width") as! Double)
        self.viewHeight = Float(dict.value(forKey: "height") as! Double)
        self.channel = methodChannel
        super.init(frame: frame)
        self.loadBannerAd()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func loadBannerAd(){
        let width:CGFloat = CGFloat(self.viewWidth!)
        let heigh:CGFloat = CGFloat(self.viewHeight!)
        let size = CGSize(width: width, height: heigh)
        let bannerAdView = BUNativeExpressBannerView.init(slotID: self.mCodeId!, rootViewController: MyUtils.getVC(), adSize: size)
        bannerAdView.delegate = self
        bannerAdView.frame = CGRect(x: 0, y: 0, width: width, height: heigh)
        bannerAdView.center = CGPoint(x: width / 2, y: heigh / 2)
        addSubview(bannerAdView)
        bannerAdView.loadAdData()
    }
    
    private func queryEcpm(){
//        let info = bannerAdView
    }
    
    
    private func disposeView() {
        removeFromSuperview()
    }
}

extension MyBannerView: BUNativeExpressBannerViewDelegate {
    public func nativeExpressBannerAdViewDidLoad(_ bannerAdView: BUNativeExpressBannerView) {
        
    }

    public func nativeExpressBannerAdViewRenderFail(_ bannerAdView: BUNativeExpressBannerView, error: Error?) {
        LogUtil.logInstance.printLog(message:error)
        self.channel?.invokeMethod("onFail", arguments:error?.localizedDescription)
        self.disposeView()
    }

    public func nativeExpressBannerAdView(_ bannerAdView: BUNativeExpressBannerView, didLoadFailWithError error: Error?) {
        LogUtil.logInstance.printLog(message:error)
        self.channel?.invokeMethod("onFail", arguments: error?.localizedDescription)
        self.disposeView()
    }

    public func nativeExpressBannerAdView(_ bannerAdView: BUNativeExpressBannerView, dislikeWithReason filterwords: [BUDislikeWords]?) {
        LogUtil.logInstance.printLog(message:"点击了不感兴趣")
        self.channel?.invokeMethod("onDislike", arguments: filterwords?[0].name)
        self.disposeView()
    }
    
    public func nativeExpressBannerAdViewRenderSuccess(_ bannerAdView: BUNativeExpressBannerView) {
        LogUtil.logInstance.printLog(message: "banner渲染成功")
        let map : NSDictionary = ["width":bannerAdView.frame.size.width,
                                  "height":bannerAdView.frame.size.height]
        self.channel?.invokeMethod("onShow", arguments: map)
    }
    
    public func nativeExpressBannerAdViewDidClick(_ bannerAdView: BUNativeExpressBannerView) {
        LogUtil.logInstance.printLog(message: "banner点击了")
        self.channel?.invokeMethod("onClick", arguments: "")
    }
    
    public func nativeExpressBannerAdViewDidRemoved(_ bannerAdView: BUNativeExpressBannerView) {
        LogUtil.logInstance.printLog(message: "banner移除了")
        self.disposeView()
    }
}

