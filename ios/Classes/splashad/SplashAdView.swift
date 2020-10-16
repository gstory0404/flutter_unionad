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
    
    init(_ frame : CGRect,binaryMessenger: FlutterBinaryMessenger , id : Int64, params :Any?) {
        self.frame = frame
        self.container = UIView(frame: frame)
        let dict = params as! NSDictionary
        self.mCodeId = dict.value(forKey: "iosCodeId") as? String
        self.mIsExpress = dict.value(forKey: "mIsExpress") as? Bool
        self.supportDeepLink = dict.value(forKey: "supportDeepLink") as? Bool
        self.expressViewWidth = Float(dict.value(forKey: "expressViewWidth") as! Double)
        self.expressViewHeight = Float(dict.value(forKey: "expressViewHeight") as! Double)
        super.init()
        self.channel = FlutterMethodChannel.init(name: FlutterUnionadConfig.view.splashAdView + "_" + String(id), binaryMessenger: binaryMessenger)
        self.loadSplash()
    }
    
    public func view() -> UIView {
        return self.container
    }
    
    private func refreshView(width: CGFloat, height: CGFloat) {
           var params = [String: Any?]()
           params["width"] = width
           params["height"] = height
       }
    
    func loadSplash(){
        self.removeAllView()
        if(self.mIsExpress!){
            let size : CGSize
            if(self.expressViewWidth == 0 || self.expressViewHeight == 0){
                size = CGSize(width: MyUtils.getScreenSize().width, height: MyUtils.getScreenSize().height)
            }else{
                size = CGSize(width: CGFloat(self.expressViewWidth!), height: CGFloat(self.expressViewHeight!))
            }
            self.frame.size = size
            let splashView = BUNativeExpressSplashView(slotID: self.mCodeId!,adSize:size, rootViewController:MyUtils.getVC())
            self.container.addSubview(splashView)
            splashView.delegate = self
            splashView.loadAdData()
            LogUtil.logInstance.printLog(message: "BUNativeExpressSplashView开始初始化")
        }else{
            self.frame.size = CGSize(width: MyUtils.getScreenSize().width, height: MyUtils.getScreenSize().height)
            let splashView = BUSplashAdView(slotID: self.mCodeId!, frame: MyUtils.getScreenSize())
            self.container.addSubview(splashView)
            splashView.delegate = self
            splashView.rootViewController = MyUtils.getVC()
            splashView.loadAdData()
            LogUtil.logInstance.printLog(message: "BUSplashAdView开始初始化")
        }
    }
    
    private func removeAllView(){
        self.container.removeFromSuperview()
    }
    
    private func disposeView() {
        self.removeAllView()
    }
}

extension SplashAdView : BUSplashAdDelegate{
    public func splashAdDidLoad(_ splashAdView: BUSplashAdView) {
        LogUtil.logInstance.printLog(message: "加载完成")
        self.refreshView(width: frame.width, height: frame.height)
    }
    
    public func splashAdDidClick(_ splashAd: BUSplashAdView) {
        self.channel?.invokeMethod("onAplashClick", arguments: "开屏广告点击")
    }
    
    public func splashAdDidClickSkip(_ splashAd: BUSplashAdView) {
        self.channel?.invokeMethod("onAplashSkip", arguments: "开屏广告跳过")
    }
    
    public func splashAdCountdown(toZero splashAd: BUSplashAdView) {
        self.channel?.invokeMethod("onAplashFinish", arguments: "开屏广告倒计时结束")
    }
    
    
    public func splashAd(_ splashAd: BUSplashAdView, didFailWithError error: Error?) {
        self.disposeView()
        self.channel?.invokeMethod("onFail", arguments:String(error.debugDescription))
    }
}

extension SplashAdView : BUNativeExpressSplashViewDelegate{
    public func nativeExpressSplashViewDidLoad(_ splashAdView: BUNativeExpressSplashView) {
        LogUtil.logInstance.printLog(message: "加载完成")
    }

    public func nativeExpressSplashView(_ splashAdView: BUNativeExpressSplashView, didFailWithError error: Error?) {
        LogUtil.logInstance.printLog(message: "加载失败")
        LogUtil.logInstance.printLog(message: error)
        splashAdView.remove()
        self.disposeView()
        self.channel?.invokeMethod("onFail", arguments:String(error.debugDescription))
    }

    public func nativeExpressSplashViewRenderSuccess(_ splashAdView: BUNativeExpressSplashView) {
        LogUtil.logInstance.printLog(message: "加载成功")
        self.channel?.invokeMethod("onShow", arguments: "")
    }

    public func nativeExpressSplashViewRenderFail(_ splashAdView: BUNativeExpressSplashView, error: Error?) {
        LogUtil.logInstance.printLog(message: "渲染失败")
        splashAdView.remove()
        self.disposeView()
        self.channel?.invokeMethod("onFail", arguments:String(error.debugDescription))
    }

    public func nativeExpressSplashViewWillVisible(_ splashAdView: BUNativeExpressSplashView) {
        LogUtil.logInstance.printLog(message: "显示")
    }

    public func nativeExpressSplashViewDidClick(_ splashAdView: BUNativeExpressSplashView) {
        LogUtil.logInstance.printLog(message: "广告点击")
    }

    public func nativeExpressSplashViewDidClickSkip(_ splashAdView: BUNativeExpressSplashView) {
        LogUtil.logInstance.printLog(message: "点击跳过")
    }

    public func nativeExpressSplashViewCountdown(toZero splashAdView: BUNativeExpressSplashView) {
        LogUtil.logInstance.printLog(message: "倒计时结束")
    }

    public func nativeExpressSplashViewDidClose(_ splashAdView: BUNativeExpressSplashView) {
        LogUtil.logInstance.printLog(message: "点击关闭")
        splashAdView.remove()
        self.disposeView()
    }

    public func nativeExpressSplashViewFinishPlayDidPlayFinish(_ splashView: BUNativeExpressSplashView, didFailWithError error: Error) {
        LogUtil.logInstance.printLog(message: "加载完毕")
    }

    public func nativeExpressSplashViewDidCloseOtherController(_ splashView: BUNativeExpressSplashView, interactionType: BUInteractionType) {
        LogUtil.logInstance.printLog(message: "关闭")
    }


}
