// 全屏视频广告
//  FullScreenVideoAd.swift
//  flutter_unionad
//
//  Created by gstory0404@gmail on 2020/9/28.
//

import Foundation
import BUAdSDK

public class FullscreenVideoAd : NSObject{
    public static let instance = FullscreenVideoAd()
    //全屏广告
    private var bUFullscreenVideoAd : BUFullscreenVideoAd?
    //个性化全屏广告
    private var bUNativeExpressFullscreenVideoAd : BUNativeExpressFullscreenVideoAd?
    
    public func showFullscreenVideoAd(params : NSDictionary){
        let mIsExpress = params.value(forKey: "mIsExpress") as? Bool
        let mCodeId = params.value(forKey: "iosCodeId") as? String
//        let supportDeepLink = params.value(forKey: "supportDeepLink") as? Bool
//        let orientation = params.value(forKey: "orientation") as? Int64
        if(!mIsExpress!){
            LogUtil.logInstance.printLog(message: "开始加载全屏广告3")
            self.bUNativeExpressFullscreenVideoAd = BUNativeExpressFullscreenVideoAd.init(slotID: mCodeId!)
            self.bUNativeExpressFullscreenVideoAd!.delegate = self
            self.bUNativeExpressFullscreenVideoAd!.loadData()
        }else{
            self.bUFullscreenVideoAd = BUFullscreenVideoAd.init(slotID: mCodeId!)
            self.bUFullscreenVideoAd!.delegate = self
            self.bUFullscreenVideoAd!.loadData()
            LogUtil.logInstance.printLog(message: "开始加载全屏广告")
        }
    }
}

extension FullscreenVideoAd : BUFullscreenVideoAdDelegate{
    public func fullscreenVideoAdDidClick(_ fullscreenVideoAd: BUFullscreenVideoAd) {
        LogUtil.logInstance.printLog(message: "fullscreenVideoAdDidClick")
    }
    public func fullscreenVideoAdDidVisible(_ fullscreenVideoAd: BUFullscreenVideoAd) {
        LogUtil.logInstance.printLog(message: "开始显示广告")
    }
    
    public func fullscreenVideoAdVideoDataDidLoad(_ fullscreenVideoAd: BUFullscreenVideoAd) {
        LogUtil.logInstance.printLog(message: "广告加载完成")
        self.bUFullscreenVideoAd!.show(fromRootViewController: MyUtils.getVC())
    }
    public func fullscreenVideoAd(_ fullscreenVideoAd: BUFullscreenVideoAd, didFailWithError error: Error?) {
        LogUtil.logInstance.printLog(message: error)
    }
    public func fullscreenVideoAdDidClose(_ fullscreenVideoAd: BUFullscreenVideoAd) {
        LogUtil.logInstance.printLog(message: "fullscreenVideoAdDidClose")
    }
    
    public func fullscreenVideoAdWillClose(_ fullscreenVideoAd: BUFullscreenVideoAd) {
        LogUtil.logInstance.printLog(message: "fullscreenVideoAdWillClose")
    }
    public func fullscreenVideoAdWillVisible(_ fullscreenVideoAd: BUFullscreenVideoAd) {
        LogUtil.logInstance.printLog(message: "fullscreenVideoAdWillVisible")
    }
    
    public func fullscreenVideoAdDidClickSkip(_ fullscreenVideoAd: BUFullscreenVideoAd) {
        LogUtil.logInstance.printLog(message: "fullscreenVideoAdDidClickSkip")
    }
    
    public func fullscreenVideoMaterialMetaAdDidLoad(_ fullscreenVideoAd: BUFullscreenVideoAd) {
        LogUtil.logInstance.printLog(message: "fullscreenVideoMaterialMetaAdDidLoad")
    }
    
    public func fullscreenVideoAdDidPlayFinish(_ fullscreenVideoAd: BUFullscreenVideoAd, didFailWithError error: Error?) {
        LogUtil.logInstance.printLog(message: error)
    }
    
    public func fullscreenVideoAdCallback(_ fullscreenVideoAd: BUFullscreenVideoAd, with fullscreenVideoAdType: BUFullScreenVideoAdType) {
        LogUtil.logInstance.printLog(message: "fullscreenVideoAdCallback")
    }
}

extension FullscreenVideoAd : BUNativeExpressFullscreenVideoAdDelegate{
    //渲染成功
    public func nativeExpressFullscreenVideoAdViewRenderSuccess(_ rewardedVideoAd: BUNativeExpressFullscreenVideoAd) {
        LogUtil.logInstance.printLog(message: "nativeExpressFullscreenVideoAdViewRenderSuccess")
    }
    
    //渲染失败
    public func nativeExpressFullscreenVideoAdViewRenderFail(_ rewardedVideoAd: BUNativeExpressFullscreenVideoAd, error: Error?) {
        LogUtil.logInstance.printLog(message: error)
    }
    
    //此方法用于获取nativeExpressFullScreenVideo广告的类型
    public func nativeExpressFullscreenVideoAdCallback(_ fullscreenVideoAd: BUNativeExpressFullscreenVideoAd, with nativeExpressVideoAdType: BUNativeExpressFullScreenAdType) {
        LogUtil.logInstance.printLog(message: "errnativeExpressFullscreenVideoAdCallbackor")
    }

    //视频被点击
    public func nativeExpressFullscreenVideoAdDidClick(_ fullscreenVideoAd: BUNativeExpressFullscreenVideoAd) {
        LogUtil.logInstance.printLog(message: "nativeExpressFullscreenVideoAdDidClick")
    }
    
    //视频关闭
    public func nativeExpressFullscreenVideoAdDidClose(_ fullscreenVideoAd: BUNativeExpressFullscreenVideoAd) {
        LogUtil.logInstance.printLog(message: "nativeExpressFullscreenVideoAdDidClose")
        let map : NSDictionary = ["adType":"fullVideoAd",
                                  "fullVideoType":"onAdClose"]
        SwiftFlutterUnionadPlugin.event!.sendEvent(event: map)
    }

    //显示广告
    public func nativeExpressFullscreenVideoAdDidVisible(_ fullscreenVideoAd: BUNativeExpressFullscreenVideoAd) {
        LogUtil.logInstance.printLog(message: "nativeExpressFullscreenVideoAdDidVisible")
        let map : NSDictionary = ["adType":"fullVideoAd",
                                  "fullVideoType":"onAdShow"]
        SwiftFlutterUnionadPlugin.event!.sendEvent(event: map)
    }
    
    //点击跳过
    public func nativeExpressFullscreenVideoAdDidClickSkip(_ fullscreenVideoAd: BUNativeExpressFullscreenVideoAd) {
        LogUtil.logInstance.printLog(message: "nativeExpressFullscreenVideoAdDidClickSkip")
        let map : NSDictionary = ["adType":"fullVideoAd",
                                  "fullVideoType":"onSkippedVideo"]
        SwiftFlutterUnionadPlugin.event!.sendEvent(event: map)
    }
    
    //当视频缓存成功时调用此方法
    public func nativeExpressFullscreenVideoAdDidDownLoadVideo(_ fullscreenVideoAd: BUNativeExpressFullscreenVideoAd) {
        self.bUNativeExpressFullscreenVideoAd!.show(fromRootViewController: MyUtils.getVC())
        LogUtil.logInstance.printLog(message: "nativeExpressFullscreenVideoAdDidDownLoadVideo")
    }
    
    public func nativeExpressFullscreenVideoAdDidCloseOtherController(_ fullscreenVideoAd: BUNativeExpressFullscreenVideoAd, interactionType: BUInteractionType) {
        LogUtil.logInstance.printLog(message: "nativeExpressFullscreenVideoAdDidCloseOtherController")
        
    }
    
    //广告播放结束
    public func nativeExpressFullscreenVideoAdDidPlayFinish(_ fullscreenVideoAd: BUNativeExpressFullscreenVideoAd, didFailWithError error: Error?) {
        LogUtil.logInstance.printLog(message: "nativeExpressFullscreenVideoAdDidPlayFinish")
        let map : NSDictionary = ["adType":"fullVideoAd",
                                  "fullVideoType":"onVideoComplete"]
        SwiftFlutterUnionadPlugin.event!.sendEvent(event: map)
    }
}
