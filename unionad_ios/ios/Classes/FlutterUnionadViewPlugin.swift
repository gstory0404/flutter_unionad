//
//  FlutterUnionadViewPlugin.swift
//  flutter_unionad
//
//  Created by gstory0404@gmail on 2020/9/4.
//

import Foundation
import Flutter

class FlutterUnionadViewPlugin{
    static func register(viewRegistrar : FlutterPluginRegistrar){
       //banner广告
        let bannerAdViewFactory = BannerAdViewFactory(messenger: viewRegistrar.messenger())
        viewRegistrar.register(bannerAdViewFactory, withId: FlutterUnionadConfig.view.bannerAdView)
        //spalsh广告
        let splashAdViewFactory = SplashAdViewFactory(messenger: viewRegistrar.messenger())
        viewRegistrar.register(splashAdViewFactory, withId: FlutterUnionadConfig.view.splashAdView)
        //draw广告
        let drawfeedAdViewFactory = DrawFeedAdViewFactory(messenger: viewRegistrar.messenger())
        viewRegistrar.register(drawfeedAdViewFactory, withId: FlutterUnionadConfig.view.drawFeedAdView)
        //信息流广告
        let nativeAdviewFactory = NativeAdViewFactory(messenger: viewRegistrar.messenger())
        viewRegistrar.register(nativeAdviewFactory, withId: FlutterUnionadConfig.view.nativeAdView)
    }
}

