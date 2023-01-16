// 激励广告
//  RewardedVideoAd.swift
//  flutter_unionad
//
//  Created by 9Y on 2020/9/28.
//

import Foundation
import BUAdSDK

public class RewardedVideoAd : NSObject{
    public static let instance = RewardedVideoAd()
    
    var mCodeId :String?
    //激励广告参数
    private var rewardModel :BURewardedVideoModel?
    
    private var bURewardedVideoAd :BUNativeExpressRewardedVideoAd?
    
    public func loadRewardedVideoAd(params : NSDictionary) {
        LogUtil.logInstance.printLog(message: params)
        let mCodeId = params.value(forKey: "iosCodeId") as? String
        let userID = params.value(forKey: "userID") as? String
        let rewardName = params.value(forKey: "rewardName") as? String
        let rewardAmount = params.value(forKey: "rewardAmount") as? Int
        let mediaExtra = params.value(forKey: "mediaExtra") as? String
        self.rewardModel = BURewardedVideoModel()
        self.rewardModel!.userId = userID
        if rewardName != nil {
            self.rewardModel!.rewardName = rewardName
        }
        if rewardAmount != nil {
            self.rewardModel!.rewardAmount = rewardAmount!
        }
        if mediaExtra != nil {
            self.rewardModel!.extra = mediaExtra
        }
        self.bURewardedVideoAd = BUNativeExpressRewardedVideoAd(slotID: mCodeId!, rewardedVideoModel: self.rewardModel!)
        self.bURewardedVideoAd!.delegate = self
        self.bURewardedVideoAd!.loadData()
    }
    
    public func showRewardedVideoAd(){
        if(self.bURewardedVideoAd == nil){
            let map : NSDictionary = ["adType":"rewardAd",
                                      "onAdMethod":"onUnReady"]
            SwiftFlutterUnionadPlugin.event!.sendEvent(event: map)
            return
        }
        UIApplication.shared.setStatusBarHidden(true, with: UIStatusBarAnimation.none)
        self.bURewardedVideoAd!.show(fromRootViewController: MyUtils.getVC())
        let map : NSDictionary = ["adType":"rewardAd",
                                  "onAdMethod":"onShow"]
        SwiftFlutterUnionadPlugin.event!.sendEvent(event: map)
    }
}

extension RewardedVideoAd: BUNativeExpressRewardedVideoAdDelegate {
    public func nativeExpressRewardedVideoAdDidLoad(_ rewardedVideoAd: BUNativeExpressRewardedVideoAd) {
        LogUtil.logInstance.printLog(message: "激励广告加载成功")
        let map : NSDictionary = ["adType":"rewardAd",
                                  "onAdMethod":"onReady"]
        SwiftFlutterUnionadPlugin.event!.sendEvent(event: map)
    }
    
    public func nativeExpressRewardedVideoAdDidDownLoadVideo(_ rewardedVideoAd: BUNativeExpressRewardedVideoAd) {
        LogUtil.logInstance.printLog(message: "激励广告物料缓存成功")
        let map : NSDictionary = ["adType":"rewardAd",
                                  "onAdMethod":"onCache"]
        SwiftFlutterUnionadPlugin.event!.sendEvent(event: map)
    }
    
    public func nativeExpressRewardedVideoAdDidClose(_ rewardedVideoAd: BUNativeExpressRewardedVideoAd) {
        LogUtil.logInstance.printLog(message: "激励广告关闭")
        UIApplication.shared.setStatusBarHidden(false, with: UIStatusBarAnimation.none)
        let map : NSDictionary = ["adType":"rewardAd",
                                  "onAdMethod":"onClose"]
        SwiftFlutterUnionadPlugin.event!.sendEvent(event: map)
        self.bURewardedVideoAd = nil
    }
    
    public func nativeExpressRewardedVideoAd(_ rewardedVideoAd: BUNativeExpressRewardedVideoAd, didFailWithError error: Error?) {
        LogUtil.logInstance.printLog(message: "激励广告加载失败")
        LogUtil.logInstance.printLog(message: error)
        let map : NSDictionary = ["adType":"rewardAd",
                                  "onAdMethod":"onFail",
                                  "error":error?.localizedDescription]
        SwiftFlutterUnionadPlugin.event!.sendEvent(event: map)
    }
    
    public func nativeExpressRewardedVideoAdDidClickSkip(_ rewardedVideoAd: BUNativeExpressRewardedVideoAd) {
        LogUtil.logInstance.printLog(message: "激励广告跳过")
        let map : NSDictionary = ["adType":"rewardAd",
                                  "onAdMethod":"onSkip"]
        SwiftFlutterUnionadPlugin.event!.sendEvent(event: map)
    }
    
    public func nativeExpressRewardedVideoAdViewRenderFail(_ rewardedVideoAd: BUNativeExpressRewardedVideoAd, error: Error?) {
        let map : NSDictionary = ["adType":"rewardAd",
                                  "onAdMethod":"onFail",
                                  "error":error?.localizedDescription]
        SwiftFlutterUnionadPlugin.event!.sendEvent(event: map)
    }
    
    public func nativeExpressRewardedVideoAdServerRewardDidFail(_ rewardedVideoAd: BUNativeExpressRewardedVideoAd, error: Error?) {
        LogUtil.logInstance.printLog(message: "异步请求的服务器验证失败回调")
        LogUtil.logInstance.printLog(message: error)
        //旧版奖励回调
        let map : NSDictionary = ["adType":"rewardAd",
                                  "onAdMethod":"onVerify",
                                  "rewardVerify":false,
                                  "rewardAmount":rewardedVideoAd.rewardedVideoModel.rewardAmount,
                                  "rewardName":rewardedVideoAd.rewardedVideoModel.rewardName ?? "",
                                  "errorCode":error != nil ? (error! as NSError).code : 0,
                                  "error":error?.localizedDescription]
        SwiftFlutterUnionadPlugin.event!.sendEvent(event: map)
        //新版奖励回调
        let arrivedMap : NSDictionary = ["adType":"rewardAd",
                                  "onAdMethod":"onRewardArrived",
                                  "rewardVerify":false,
                                  "rewardAmount":rewardedVideoAd.rewardedVideoModel.rewardAmount,
                                  "rewardName":rewardedVideoAd.rewardedVideoModel.rewardName ?? "",
                                  "errorCode":error != nil ? (error! as NSError).code : 0,
                                         "error":error?.localizedDescription,
                                  "rewardType":rewardedVideoAd.rewardedVideoModel.rewardType.rawValue,
                                  "extraInfo":String.init(format:"%.2f",rewardedVideoAd.rewardedVideoModel.rewardPropose)]
        SwiftFlutterUnionadPlugin.event!.sendEvent(event: arrivedMap)
    }

    public func nativeExpressRewardedVideoAdServerRewardDidSucceed(_ rewardedVideoAd: BUNativeExpressRewardedVideoAd, verify: Bool) {
        /// handle in close
        LogUtil.logInstance.printLog(message: "异步请求的服务器验证成功回调，开发者需要在此回调中进行奖励发放")
        //旧版奖励回调
        let map : NSDictionary = ["adType":"rewardAd",
                                  "onAdMethod":"onVerify",
                                  "rewardVerify":verify,
                                  "rewardAmount":rewardedVideoAd.rewardedVideoModel.rewardAmount,
                                  "rewardName":rewardedVideoAd.rewardedVideoModel.rewardName ?? "",
                                  "errorCode":0,
                                  "error":""]
        SwiftFlutterUnionadPlugin.event!.sendEvent(event: map)
        //新版奖励回调
        let arrivedMap : NSDictionary = ["adType":"rewardAd",
                                  "onAdMethod":"onRewardArrived",
                                  "rewardVerify":verify,
                                  "rewardAmount":rewardedVideoAd.rewardedVideoModel.rewardAmount,
                                  "rewardName":rewardedVideoAd.rewardedVideoModel.rewardName ?? "",
                                  "errorCode":0,
                                  "error":"",
                                  "rewardType":rewardedVideoAd.rewardedVideoModel.rewardType.rawValue,
                                  "extraInfo":String.init(format:"%.2f",rewardedVideoAd.rewardedVideoModel.rewardPropose)]
        SwiftFlutterUnionadPlugin.event!.sendEvent(event: arrivedMap)
    }
    
    public func nativeExpressRewardedVideoAdDidPlayFinish(_ rewardedVideoAd: BUNativeExpressRewardedVideoAd, didFailWithError error: Error?) {
        LogUtil.logInstance.printLog(message: "激励广告完成")
    }
    
    public func nativeExpressRewardedVideoAdDidClick(_ rewardedVideoAd: BUNativeExpressRewardedVideoAd) {
        let map : NSDictionary = ["adType":"rewardAd",
                                  "onAdMethod":"onClick"]
        SwiftFlutterUnionadPlugin.event!.sendEvent(event: map)
    }
    
    public func nativeExpressRewardedVideoAdCallback(_ rewardedVideoAd: BUNativeExpressRewardedVideoAd, with nativeExpressVideoType: BUNativeExpressRewardedVideoAdType) {
    }
}
