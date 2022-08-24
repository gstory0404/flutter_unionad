// 开屏广告
//  SplashAdView.swift
//  flutter_unionad
//
//  Created by gstory0404@gmail on 2020/9/27.
//

import Foundation
import BUAdSDK
import Flutter

public class SplashAdView : NSObject,FlutterPlatformView{
    private let container : UIView
    var frame: CGRect;
    private var channel : FlutterMethodChannel?
    //广告需要的参数
    let mCodeId :String?
    var supportDeepLink :Bool? = true
    let expressViewWidth : Float?
    let expressViewHeight :Float?
    var mIsExpress :Bool? = true
    var adLoadType : Int? = 0
    var timeout : Double? = 3.0
    var splashAd:BUSplashAd?
    
    
    init(_ frame : CGRect,binaryMessenger: FlutterBinaryMessenger , id : Int64, params :Any?) {
        self.frame = frame
        self.container = UIView(frame: frame)
        let dict = params as! NSDictionary
        self.mCodeId = dict.value(forKey: "iosCodeId") as? String
        self.mIsExpress = dict.value(forKey: "mIsExpress") as? Bool
        self.supportDeepLink = dict.value(forKey: "supportDeepLink") as? Bool
        self.expressViewWidth = Float(dict.value(forKey: "expressViewWidth") as! Double)
        self.expressViewHeight = Float(dict.value(forKey: "expressViewHeight") as! Double)
        self.adLoadType = dict.value(forKey: "adLoadType") as? Int
        self.timeout = (dict.value(forKey: "timeout") as! Double) / 1000
        super.init()
        self.channel = FlutterMethodChannel.init(name: FlutterUnionadConfig.view.splashAdView + "_" + String(id), binaryMessenger: binaryMessenger)
        self.loadSplash()
    }
    
    public func view() -> UIView {
        return self.container
    }
    
    func loadSplash(){
        self.container.removeFromSuperview()
        let size : CGSize
        if(self.expressViewWidth == 0 || self.expressViewHeight == 0){
            size = CGSize(width: MyUtils.getScreenSize().width, height: MyUtils.getScreenSize().height)
        }else{
            size = CGSize(width: CGFloat(self.expressViewWidth!), height: CGFloat(self.expressViewHeight!))
        }
        self.splashAd = BUSplashAd.init(slotID: self.mCodeId!, adSize:size);
        self.splashAd?.tolerateTimeout = self.timeout ?? 3.0;
//        self.splashAd?.hideSkipButton = false;
        self.splashAd?.delegate = self;
        LogUtil.logInstance.printLog(message: "开屏广告开始加载")
        self.splashAd?.loadData();
    }
    
    private func disposeView() {
        self.container.removeFromSuperview()
    }
}

extension SplashAdView : BUSplashAdDelegate{
    
    //SDK渲染开屏广告加载成功回调
    public func splashAdLoadSuccess(_ splashAd: BUSplashAd) {
        LogUtil.logInstance.printLog(message: "开屏广告加载成功回调")
        splashAd.showSplashView(inRootViewController: MyUtils.getVC());
    }
    
    //返回的错误码(error)表示广告加载失败的原因，所有错误码详情请见链接Link
    public func splashAdLoadFail(_ splashAd: BUSplashAd, error: BUAdError?) {
        LogUtil.logInstance.printLog(message:"开屏广告加载失败");
        self.disposeView()
        self.channel?.invokeMethod("onFail", arguments:error?.description ?? "")
    }
    
    //SDK渲染开屏广告渲染成功回调
    public func splashAdRenderSuccess(_ splashAd: BUSplashAd) {
        LogUtil.logInstance.printLog(message: "开屏广告渲染成功")
        self.container.addSubview(splashAd.splashView!);
        self.channel?.invokeMethod("onShow", arguments: "开屏广告加载完成")
    }
    
    //SDK渲染开屏广告渲染失败回调
    public func splashAdRenderFail(_ splashAd: BUSplashAd, error: BUAdError?) {
        LogUtil.logInstance.printLog(message: "开屏广告渲染失败")
        LogUtil.logInstance.printLog(message: error)
        self.disposeView()
        self.channel?.invokeMethod("onFail", arguments:error?.description ?? "")
    }
    
    //SDK渲染开屏广告即将展示
    public func splashAdWillShow(_ splashAd: BUSplashAd) {
        LogUtil.logInstance.printLog(message: "开屏广告即将展示")
    }
    
    public func splashAdDidShow(_ splashAd: BUSplashAd) {
        LogUtil.logInstance.printLog(message: "开屏广告展示")
    }
    
    public func splashAdDidClose(_ splashAd: BUSplashAd, closeType: BUSplashAdCloseType) {
        LogUtil.logInstance.printLog(message: "开屏广告关闭回调")
        if(closeType == BUSplashAdCloseType.clickSkip){
            self.channel?.invokeMethod("onSkip", arguments: "开屏广告跳过")
        }else{
            self.channel?.invokeMethod("onFinish", arguments: "开屏广告倒计时结束")
        }
        self.disposeView()
    }
    
    //SDK渲染开屏广告关闭回调，当用户点击广告时会直接触发此回调，建议在此回调方法中直接进行广告对象的移除操作
    public func splashAdViewControllerDidClose(_ splashAd: BUSplashAd) {
//        self.channel?.invokeMethod("onFinish", arguments: "开屏广告倒计时结束")
//        self.disposeView()
    }
    
    //此回调在广告跳转到其他控制器时，该控制器被关闭时调用。interactionType：此参数可区分是打开的appstore/网页/视频广告详情页面
    public func splashDidCloseOtherController(_ splashAd: BUSplashAd, interactionType: BUInteractionType) {
        
    }
    
    //视频广告播放完毕回调
    public func splashVideoAdDidPlayFinish(_ splashAd: BUSplashAd, didFailWithError error: Error) {
       
    }
    
    //SDK渲染开屏广告点击回调
    public func splashAdDidClick(_ splashAd: BUSplashAd) {
        self.channel?.invokeMethod("onClick", arguments: "开屏广告点击")
    }
}
