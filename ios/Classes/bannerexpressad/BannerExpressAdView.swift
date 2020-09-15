//
//  BannerExpressAdView.swift
//  flutter_unionad
// 个性化模板Banner广告
//  Created by 9Y on 2020/9/4.
//

import Foundation
import BUAdSDK
import Flutter

public class BannerExpressAdView : NSObject,FlutterPlatformView{
    private let container : UIView
    var frame: CGRect;
    //广告需要的参数
    let mCodeId :String?
    var supportDeepLink :Bool? = true
    let expressViewWidth : Float?
    let expressViewHeight :Float?
    let expressAdNum :Int64?
    let expressTime : Int64?
    
    init(_ frame : CGRect,binaryMessenger: FlutterBinaryMessenger , id : Int64, params :Any?) {
        self.frame = frame
        self.container = UIView(frame: frame)
        let dict = params as! NSDictionary
        self.mCodeId = dict.value(forKey: "mCodeId") as? String
        self.supportDeepLink = dict.value(forKey: "supportDeepLink") as? Bool
        self.expressViewWidth = dict.value(forKey: "expressViewWidth") as? Float
        self.expressViewHeight = dict.value(forKey: "expressViewHeight") as? Float
        self.expressAdNum = dict.value(forKey: "expressAdNum") as? Int64
        self.expressTime = dict.value(forKey: "expressTime") as? Int64
        super.init()
        self.loadBannerExpressAd()
    }
    public func view() -> UIView {
        return self.container
    }
    
    private func refreshBanner(width: CGFloat, height: CGFloat) {
           var params = [String: Any?]()
           params["width"] = width
           params["height"] = height
       }
    
    private func loadBannerExpressAd(){
        self.removeAllView()
        let viewWidth:CGFloat = CGFloat(self.expressViewWidth ?? 200)
        let viewHeigh:CGFloat = CGFloat(self.expressViewHeight ?? 100)
        let size = CGSize(width: viewWidth, height: viewHeigh)
        self.frame.size = size
        let bannerAdView = BUNativeExpressBannerView(slotID: self.mCodeId!, rootViewController: MyUtils.getVC(), adSize: size, isSupportDeepLink: self.supportDeepLink!)
        self.container.addSubview(bannerAdView)
        bannerAdView.delegate = self
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

extension BannerExpressAdView: BUNativeExpressBannerViewDelegate {
    public func nativeExpressBannerAdViewDidLoad(_ bannerAdView: BUNativeExpressBannerView) {
        let frame = bannerAdView.frame
        self.refreshBanner(width: frame.width, height: frame.height)
    }

    public func nativeExpressBannerAdViewRenderFail(_ bannerAdView: BUNativeExpressBannerView, error: Error?) {
        self.disposeView()
    }

    public func nativeExpressBannerAdView(_ bannerAdView: BUNativeExpressBannerView, didLoadFailWithError error: Error?) {
        self.disposeView()
    }

    public func nativeExpressBannerAdView(_ bannerAdView: BUNativeExpressBannerView, dislikeWithReason filterwords: [BUDislikeWords]?) {
        LogUtil.logInstance.printLog(message:"点击了不感兴趣")
        self.disposeView()
    }
    
    
}
