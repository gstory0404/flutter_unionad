// 插屏广告
//  InteractionExpressAdView.swift
//  flutter_unionad
//
//  Created by 9Y on 2020/10/9.
//

import Foundation
import BUAdSDK

class InteractionAd : NSObject{
    public static let instance = InteractionAd()
    //全屏广告
    private var bUFullscreenVideoAd : BUFullscreenVideoAd?
    //个性化全屏广告
    private var bUNativeExpressInterstitialAd : BUNativeExpressInterstitialAd?
    
    public func showInteractionAd(params : NSDictionary){
        let mCodeId = params.value(forKey: "iosCodeId") as? String
        let expressViewWidth = params.value(forKey: "expressViewWidth") as? Double
        let expressViewHeight = params.value(forKey: "expressViewHeight") as? Double
        var size = CGSize.init()
        if(expressViewWidth == 0 || expressViewHeight == 0){
            size.width = MyUtils.getScreenSize().width / 2
            size.height = MyUtils.getScreenSize().height / 2
        }else{
            size.width = CGFloat(expressViewWidth!)
            size.height = CGFloat(expressViewHeight!)
        }
        self.bUNativeExpressInterstitialAd = BUNativeExpressInterstitialAd.init(slotID: mCodeId!, adSize: size)
        self.bUNativeExpressInterstitialAd!.delegate = self
        self.bUNativeExpressInterstitialAd!.loadData()
        LogUtil.logInstance.printLog(message: "插屏广告开始加载")
    }
}

extension InteractionAd : BUNativeExpresInterstitialAdDelegate{
    func nativeExpresInterstitialAdDidLoad(_ interstitialAd: BUNativeExpressInterstitialAd) {
        LogUtil.logInstance.printLog(message: "插屏广告数据加载完成")
    }
    
    func nativeExpresInterstitialAdRenderSuccess(_ interstitialAd: BUNativeExpressInterstitialAd) {
        LogUtil.logInstance.printLog(message: "插屏广告渲染成功")
        self.bUNativeExpressInterstitialAd!.show(fromRootViewController: MyUtils.getVC())
    }
    
    func nativeExpresInterstitialAdRenderFail(_ interstitialAd: BUNativeExpressInterstitialAd, error: Error?) {
        LogUtil.logInstance.printLog(message: "插屏广告数据渲染失败")
        LogUtil.logInstance.printLog(message: error!)
    }
    
    func nativeExpresInterstitialAd(_ interstitialAd: BUNativeExpressInterstitialAd, didFailWithError error: Error?) {
        LogUtil.logInstance.printLog(message: "插屏广告数据加载失败")
        LogUtil.logInstance.printLog(message: error!)
    }
}

