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
        print("初始化view")
        print(viewRegistrar.messenger())
       //banner广告
        let bannerAdViewFactory = BannerAdViewFactory(messenger: viewRegistrar.messenger())
        viewRegistrar.register(bannerAdViewFactory, withId: "com.gstory.flutter_unionad/BannerAdView")
        //spalsh广告
        let splashAdViewFactory = SplashAdViewFactory(messenger: viewRegistrar.messenger())
        viewRegistrar.register(splashAdViewFactory, withId: "com.gstory.flutter_unionad/SplashAdView")
        //draw广告
        let drawfeedAdViewFactory = DrawFeedAdViewFactory(messenger: viewRegistrar.messenger())
        viewRegistrar.register(drawfeedAdViewFactory, withId: "com.gstory.flutter_unionad/DrawFeedAdView")
        //信息流广告
        let nativeAdviewFactory = NativeAdViewFactory(messenger: viewRegistrar.messenger())
        viewRegistrar.register(nativeAdviewFactory, withId: "com.gstory.flutter_unionad/NativeAdView")
    }
}

