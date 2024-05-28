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
    var viewWidth : Float?
    var viewHeight :Float?
    var hideSkip :Bool = false
    var timeout : Double? = 3.0
    var splashAd:BUSplashAd?
    
    
    init(_ frame : CGRect,binaryMessenger: FlutterBinaryMessenger , id : Int64, params :Any?) {
        self.frame = frame
        self.container = UIView(frame: frame)
        let dict = params as! NSDictionary
        self.mCodeId = dict.value(forKey: "iosCodeId") as? String
        self.hideSkip = dict.value(forKey: "hideSkip") as! Bool
        self.viewWidth = Float(dict.value(forKey: "width") as! Double)
        self.viewHeight = Float(dict.value(forKey: "height") as! Double)
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
        self.splashAd?.removeSplashView()
        if(self.viewWidth == 0 || self.viewHeight == 0){
            size = CGSize(width: MyUtils.getScreenSize().width, height: MyUtils.getScreenSize().height)
        }else{
            size = CGSize(width: CGFloat(self.viewWidth!), height: CGFloat(self.viewHeight!))
        }
        let splash = BUSplashAd.init(slotID: self.mCodeId!, adSize:size)
        splash.tolerateTimeout = self.timeout ?? 3.0
        splash.hideSkipButton = self.hideSkip
        splash.supportCardView = false
        splash.supportZoomOutView = false
        splash.delegate = self
        self.splashAd = splash;
        self.splashAd?.loadData()
    }
    
    private func disposeView() {
        self.container.removeFromSuperview()
        self.splashAd?.removeSplashView()
        self.splashAd = nil;
    }
    
    //自定义跳过按钮
    func showSkipButton(){
        let skipBtn = UIButton(type: UIButton.ButtonType.custom)
        skipBtn.addTarget(self, action: #selector(skipClick), for: .touchUpInside)
        skipBtn.frame = CGRect.init(x: MyUtils.getScreenSize().width - 80, y: 50, width: 60, height: 24)
        skipBtn.setTitle("跳过", for: UIControl.State.normal)
        skipBtn.setTitleColor(UIColor.white, for: UIControl.State.normal)
        skipBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
        skipBtn.isUserInteractionEnabled = true
        skipBtn.backgroundColor = UIColor.gray
        skipBtn.alpha = 0.8
        skipBtn.layer.cornerRadius = 10
        self.splashAd?.splashView?.addSubview(skipBtn)
    }
    
    //跳过事件
    @objc func skipClick(sender: UIButton) {
        self.channel?.invokeMethod("onSkip", arguments: "开屏广告跳过")
        self.disposeView()
     }
}

extension SplashAdView : BUSplashAdDelegate{
    
    //SDK渲染开屏广告加载成功回调
    public func splashAdLoadSuccess(_ splashAd: BUSplashAd) {
        LogUtil.logInstance.printLog(message: "开屏广告加载成功回调")
        self.splashAd?.showSplashView(inRootViewController: MyUtils.getVC().navigationController ?? MyUtils.getVC())
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
        if(self.hideSkip){
            self.showSkipButton()
        }
        self.container.addSubview(self.splashAd!.splashView!)
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
        LogUtil.logInstance.printLog(message: "SDK渲染开屏广告关闭回调，当用户点击广告时会直接触发此回调")
//        self.channel?.invokeMethod("onFinish", arguments: "开屏广告倒计时结束")
//        self.disposeView()
    }
    
    //此回调在广告跳转到其他控制器时，该控制器被关闭时调用。interactionType：此参数可区分是打开的appstore/网页/视频广告详情页面
    public func splashDidCloseOtherController(_ splashAd: BUSplashAd, interactionType: BUInteractionType) {
        LogUtil.logInstance.printLog(message: "SDK渲染开屏广告跳转到其他控制器时，该控制器被关闭时调用")
    }
    
    //视频广告播放完毕回调
    public func splashVideoAdDidPlayFinish(_ splashAd: BUSplashAd, didFailWithError error: Error?) {
       
    }
    
    //SDK渲染开屏广告点击回调
    public func splashAdDidClick(_ splashAd: BUSplashAd) {
        self.channel?.invokeMethod("onClick", arguments: "开屏广告点击")
    }
}
