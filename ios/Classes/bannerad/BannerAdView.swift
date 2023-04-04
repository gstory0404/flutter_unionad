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
    var supportDeepLink :Bool? = true
    var expressViewWidth : Float?
    var expressViewHeight :Float?
    var mIsExpress :Bool? = true
    var expressAdNum :Int64?
    var expressTime : Int64?
    
    init(frame: CGRect, dict:NSDictionary, methodChannel: FlutterMethodChannel) {
        self.mCodeId = dict.value(forKey: "iosCodeId") as? String
        self.mIsExpress = dict.value(forKey: "mIsExpress") as? Bool
        self.supportDeepLink = dict.value(forKey: "supportDeepLink") as? Bool
        self.expressViewWidth = Float(dict.value(forKey: "expressViewWidth") as! Double)
        self.expressViewHeight = Float(dict.value(forKey: "expressViewHeight") as! Double)
        self.expressAdNum = dict.value(forKey: "expressAdNum") as? Int64
        self.expressTime = dict.value(forKey: "expressTime") as? Int64
        self.channel = methodChannel
        super.init(frame: frame)
        self.loadBannerAd()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func loadBannerAd(){
        let viewWidth:CGFloat = CGFloat(self.expressViewWidth!)
        let viewHeigh:CGFloat = CGFloat(self.expressViewHeight!)
        let size = CGSize(width: viewWidth, height: viewHeigh)
        let bannerAdView = BUNativeExpressBannerView.init(slotID: self.mCodeId!, rootViewController: MyUtils.getVC(), adSize: size, interval: Int(self.expressTime!))
        bannerAdView.delegate = self
        bannerAdView.frame = CGRect(x: 0, y: 0, width: viewWidth, height: viewHeigh)
        bannerAdView.center = CGPoint(x: viewWidth / 2, y: viewHeigh / 2)
        addSubview(bannerAdView)
        bannerAdView.loadAdData()
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

