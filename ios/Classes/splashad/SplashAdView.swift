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
    //广告需要的参数
    let mCodeId :String?
    var supportDeepLink :Bool? = true
    let expressViewWidth : CGFloat?
    let expressViewHeight :CGFloat?
    var mIsExpress :Bool? = true
    
    init(_ frame : CGRect,binaryMessenger: FlutterBinaryMessenger , id : Int64, params :Any?) {
        self.frame = frame
        self.container = UIView(frame: frame)
        let dict = params as! NSDictionary
        self.mCodeId = dict.value(forKey: "mCodeId") as? String
        self.mIsExpress = dict.value(forKey: "mIsExpress") as? Bool
        self.supportDeepLink = dict.value(forKey: "supportDeepLink") as? Bool
        self.expressViewWidth = dict.value(forKey: "expressViewWidth") as? CGFloat
        self.expressViewHeight = dict.value(forKey: "expressViewHeight") as? CGFloat
        super.init()
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
                size = CGSize(width: self.expressViewWidth!, height: self.expressViewHeight!)
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
        let map : NSDictionary = ["adType":"aplashAd",
                                  "aplashType":"onAplashClick"]
        SwiftFlutterUnionadPlugin.event!.sendEvent(event: map)
    }
    
    public func splashAdDidClickSkip(_ splashAd: BUSplashAdView) {
        let map : NSDictionary = ["adType":"aplashAd",
                                  "aplashType":"onAplashSkip"]
        SwiftFlutterUnionadPlugin.event!.sendEvent(event: map)
        self.disposeView()
    }
    
    public func splashAdCountdown(toZero splashAd: BUSplashAdView) {
        let map : NSDictionary = ["adType":"aplashAd",
                                  "aplashType":"onAplashFinish"]
        SwiftFlutterUnionadPlugin.event!.sendEvent(event: map)
        self.disposeView()
    }
    
    
    public func splashAd(_ splashAd: BUSplashAdView, didFailWithError error: Error?) {
        self.disposeView()
    }
}

extension SplashAdView : BUNativeExpressSplashViewDelegate{
    public func nativeExpressSplashViewDidLoad(_ splashAdView: BUNativeExpressSplashView) {
        LogUtil.logInstance.printLog(message: "加载完成")
    }

    public func nativeExpressSplashView(_ splashAdView: BUNativeExpressSplashView, didFailWithError error: Error?) {
        LogUtil.logInstance.printLog(message: "加载失败")
        LogUtil.logInstance.printLog(message: error)
        let map : NSDictionary = ["adType":"aplashAd",
                                  "aplashType":"onAplashError",
                                  "message":error!]
        SwiftFlutterUnionadPlugin.event!.sendEvent(event: map)
        splashAdView.remove()
        self.disposeView()
    }

    public func nativeExpressSplashViewRenderSuccess(_ splashAdView: BUNativeExpressSplashView) {
        LogUtil.logInstance.printLog(message: "加载成功")
    }

    public func nativeExpressSplashViewRenderFail(_ splashAdView: BUNativeExpressSplashView, error: Error?) {
        LogUtil.logInstance.printLog(message: "渲染失败")
        splashAdView.remove()
        self.disposeView()
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
        splashView.remove()
        self.disposeView()
    }

    public func nativeExpressSplashViewDidCloseOtherController(_ splashView: BUNativeExpressSplashView, interactionType: BUInteractionType) {
        LogUtil.logInstance.printLog(message: "关闭")
    }


}
