//
//  FullScreenVideoAdInteraction.swift
//  flutter_unionad
//
//  Created by gstory on 2021/6/8.
//

import Foundation
import BUAdSDK

public class FullScreenVideoAdInteraction : NSObject{
    public static let instance = FullScreenVideoAdInteraction()
    //个性化全屏广告
    private var bUNativeExpressFullscreenVideoAd : BUNativeExpressFullscreenVideoAd?
    
    public func loadFullScreenVideoAdInteraction(params : NSDictionary){
        let mCodeId = params.value(forKey: "iosCodeId") as? String
        self.bUNativeExpressFullscreenVideoAd = BUNativeExpressFullscreenVideoAd.init(slotID: mCodeId!)
        self.bUNativeExpressFullscreenVideoAd!.delegate = self
        self.bUNativeExpressFullscreenVideoAd!.loadData()
    
    }
    
    public func showFullScreenVideoAdInteraction(){
        if(self.bUNativeExpressFullscreenVideoAd == nil){
            let map : NSDictionary = ["adType":"fullScreenVideoAdInteraction",
                                      "onAdMethod":"onUnReady"]
            SwiftFlutterUnionadPlugin.event!.sendEvent(event: map)
            return
        }
        self.bUNativeExpressFullscreenVideoAd!.show(fromRootViewController: MyUtils.getVC())
    }
}

extension FullScreenVideoAdInteraction : BUNativeExpressFullscreenVideoAdDelegate{
    
    //渲染成功
    public func nativeExpressFullscreenVideoAdViewRenderSuccess(_ rewardedVideoAd: BUNativeExpressFullscreenVideoAd) {
        LogUtil.logInstance.printLog(message: "nativeExpressFullscreenVideoAdViewRenderSuccess")
    }
    
    //渲染失败
    public func nativeExpressFullscreenVideoAdViewRenderFail(_ rewardedVideoAd: BUNativeExpressFullscreenVideoAd, error: Error?) {
        LogUtil.logInstance.printLog(message: error)
        let map : NSDictionary = ["adType":"fullScreenVideoAdInteraction",
                                  "onAdMethod":"onFail",
                                  "error":error?.localizedDescription]
        SwiftFlutterUnionadPlugin.event!.sendEvent(event: map)
    }
    
    //此方法用于获取nativeExpressFullScreenVideo广告的类型
    public func nativeExpressFullscreenVideoAdCallback(_ fullscreenVideoAd: BUNativeExpressFullscreenVideoAd, with nativeExpressVideoAdType: BUNativeExpressFullScreenAdType) {
        LogUtil.logInstance.printLog(message: "errnativeExpressFullscreenVideoAdCallbackor")
    }

    //视频被点击
    public func nativeExpressFullscreenVideoAdDidClick(_ fullscreenVideoAd: BUNativeExpressFullscreenVideoAd) {
        LogUtil.logInstance.printLog(message: "nativeExpressFullscreenVideoAdDidClick")
        let map : NSDictionary = ["adType":"fullScreenVideoAdInteraction",
                                  "onAdMethod":"onClick"]
        SwiftFlutterUnionadPlugin.event!.sendEvent(event: map)
    }
    
    //视频关闭
    public func nativeExpressFullscreenVideoAdDidClose(_ fullscreenVideoAd: BUNativeExpressFullscreenVideoAd) {
        LogUtil.logInstance.printLog(message: "nativeExpressFullscreenVideoAdDidClose")
        let map : NSDictionary = ["adType":"fullScreenVideoAdInteraction",
                                  "onAdMethod":"onClose"]
        SwiftFlutterUnionadPlugin.event!.sendEvent(event: map)
        bUNativeExpressFullscreenVideoAd = nil;
    }

    //显示广告
    public func nativeExpressFullscreenVideoAdDidVisible(_ fullscreenVideoAd: BUNativeExpressFullscreenVideoAd) {
        LogUtil.logInstance.printLog(message: "nativeExpressFullscreenVideoAdDidVisible")
        let map : NSDictionary = ["adType":"fullScreenVideoAdInteraction",
                                  "onAdMethod":"onShow"]
        SwiftFlutterUnionadPlugin.event!.sendEvent(event: map)
    }
    
    //点击跳过
    public func nativeExpressFullscreenVideoAdDidClickSkip(_ fullscreenVideoAd: BUNativeExpressFullscreenVideoAd) {
        LogUtil.logInstance.printLog(message: "nativeExpressFullscreenVideoAdDidClickSkip")
        let map : NSDictionary = ["adType":"fullScreenVideoAdInteraction",
                                  "onAdMethod":"onSkip"]
        SwiftFlutterUnionadPlugin.event!.sendEvent(event: map)
    }
    
    //当视频缓存成功时调用此方法
    public func nativeExpressFullscreenVideoAdDidDownLoadVideo(_ fullscreenVideoAd: BUNativeExpressFullscreenVideoAd) {
        let map : NSDictionary = ["adType":"fullScreenVideoAdInteraction",
                                  "onAdMethod":"onReady"]
        SwiftFlutterUnionadPlugin.event!.sendEvent(event: map)
        LogUtil.logInstance.printLog(message: "nativeExpressFullscreenVideoAdDidDownLoadVideo")
    }
    
    public func nativeExpressFullscreenVideoAdDidCloseOtherController(_ fullscreenVideoAd: BUNativeExpressFullscreenVideoAd, interactionType: BUInteractionType) {
        LogUtil.logInstance.printLog(message: "nativeExpressFullscreenVideoAdDidCloseOtherController")
        
    }
    
    //广告播放结束
    public func nativeExpressFullscreenVideoAdDidPlayFinish(_ fullscreenVideoAd: BUNativeExpressFullscreenVideoAd, didFailWithError error: Error?) {
        LogUtil.logInstance.printLog(message: "nativeExpressFullscreenVideoAdDidPlayFinish")
        let map : NSDictionary = ["adType":"fullScreenVideoAdInteraction",
                                  "onAdMethod":"onFinish"]
        SwiftFlutterUnionadPlugin.event!.sendEvent(event: map)
    }
}

