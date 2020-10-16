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
    private var container : UIView
    var frame: CGRect;
    private var channel : FlutterMethodChannel?
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
        self.container = UIView(frame: frame)
        let dict = params as! NSDictionary
        self.mCodeId = dict.value(forKey: "iosCodeId") as? String
        self.mIsExpress = dict.value(forKey: "mIsExpress") as? Bool
        self.supportDeepLink = dict.value(forKey: "supportDeepLink") as? Bool
        self.expressViewWidth = Float(dict.value(forKey: "expressViewWidth") as! Double)
        self.expressViewHeight = Float(dict.value(forKey: "expressViewHeight") as! Double)
        self.expressAdNum = dict.value(forKey: "expressAdNum") as? Int64
        self.expressTime = dict.value(forKey: "expressTime") as? Int64
        super.init()
        self.channel = FlutterMethodChannel.init(name: FlutterUnionadConfig.view.bannerAdView + "_" + String(id), binaryMessenger: binaryMessenger)
        self.loadBannerExpressAd()
    }
    public func view() -> UIView {
        return self.container
    }
    
    private func loadBannerExpressAd(){
        self.removeAllView()
        let viewWidth:CGFloat = CGFloat(self.expressViewWidth!)
        let viewHeigh:CGFloat = CGFloat(self.expressViewHeight!)
        let size = CGSize(width: viewWidth, height: viewHeigh)
        let bannerAdView = BUNativeExpressBannerView.init(slotID: self.mCodeId!, rootViewController: MyUtils.getVC(), adSize: size, isSupportDeepLink: self.supportDeepLink!)
        bannerAdView.delegate = self
        self.container = bannerAdView
        bannerAdView.loadAdData()
        LogUtil.logInstance.printLog(message: "开始初始化")
    }
    
    private func removeAllView(){
        self.container.removeFromSuperview()
    }
    
    private func disposeView() {
        self.removeAllView()
    }
}

extension BannerAdView: BUNativeExpressBannerViewDelegate {
    public func nativeExpressBannerAdViewDidLoad(_ bannerAdView: BUNativeExpressBannerView) {
        
    }

    public func nativeExpressBannerAdViewRenderFail(_ bannerAdView: BUNativeExpressBannerView, error: Error?) {
        self.disposeView()
        LogUtil.logInstance.printLog(message:error)
//        self.channel?.invokeMethod("onFail", arguments: error)
    }

    public func nativeExpressBannerAdView(_ bannerAdView: BUNativeExpressBannerView, didLoadFailWithError error: Error?) {
        self.disposeView()
        LogUtil.logInstance.printLog(message:String(error.debugDescription))
        self.channel?.invokeMethod("onFail", arguments: String(error.debugDescription))
    }

    public func nativeExpressBannerAdView(_ bannerAdView: BUNativeExpressBannerView, dislikeWithReason filterwords: [BUDislikeWords]?) {
        LogUtil.logInstance.printLog(message:"点击了不感兴趣")
        self.disposeView()
        self.channel?.invokeMethod("onDislike", arguments: filterwords?[0].name)
    }
    
    public func nativeExpressBannerAdViewRenderSuccess(_ bannerAdView: BUNativeExpressBannerView) {
        LogUtil.logInstance.printLog(message: "banner渲染成功")
    }
    
    public func nativeExpressBannerAdViewDidClick(_ bannerAdView: BUNativeExpressBannerView) {
        LogUtil.logInstance.printLog(message: "banner点击了")
    }
}

