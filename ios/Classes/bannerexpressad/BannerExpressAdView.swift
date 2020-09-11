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
    let frame: CGRect;
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
    
    private func refreshUI(width: CGFloat, height: CGFloat) {
           var params = [String: Any?]()
           params["width"] = width
           params["height"] = height
       }
    
    private func loadBannerExpressAd(){
        self.removeAllView()
//        let viewWidth = self.expressViewWidth ?? 0
//        let viewHeigh = self.expressViewHeight ?? 0
        let size = CGSize(width: 500, height: 200)
        print("mCodeId=" + self.mCodeId!)
        print("SupportDeepLink=" + self.mCodeId!)
        print("mCodeId=" + String(self.supportDeepLink!))
        let bannerAdView = BUNativeExpressBannerView(slotID: self.mCodeId!, rootViewController: getVC(), adSize: size, isSupportDeepLink: self.supportDeepLink!)
//        bannerAdView.frame = CGRect(x: 0, y: 0, width: viewWidth, height: viewHeight)
//        bannerAdView.center = CGPoint(x: viewWidth / 2, y: viewHeight / 2)
        self.container.addSubview(bannerAdView)
        
        bannerAdView.delegate = self
        bannerAdView.loadAdData()
        LogUtil.logInstance.printLog(message: "开始初始化")
    }
    
    private func removeAllView(){
        self.container.subviews.forEach { $0.removeFromSuperview() }
        
    }
    
    private func getVC() -> UIViewController {
            let viewController = UIApplication.shared.windows.filter { (w) -> Bool in
                w.isHidden == false
            }.first?.rootViewController
            return viewController!
        }
    
    private func disposeView() {
        self.removeAllView()
    }
}

extension BannerExpressAdView: BUNativeExpressBannerViewDelegate {
    public func nativeExpressBannerAdViewDidLoad(_ bannerAdView: BUNativeExpressBannerView) {
        let frame = bannerAdView.frame
        self.refreshUI(width: frame.width, height: frame.height)
    }

    public func nativeExpressBannerAdViewRenderFail(_ bannerAdView: BUNativeExpressBannerView, error: Error?) {
        self.disposeView()
    }

    public func nativeExpressBannerAdView(_ bannerAdView: BUNativeExpressBannerView, didLoadFailWithError error: Error?) {
//        invoke(code: err?.code ?? -1, message: error?.localizedDescription)
        self.disposeView()
    }

    public func nativeExpressBannerAdView(_ bannerAdView: BUNativeExpressBannerView, dislikeWithReason filterwords: [BUDislikeWords]?) {
        self.disposeView()
    }
}
