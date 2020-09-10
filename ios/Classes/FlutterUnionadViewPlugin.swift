//
//  FlutterUnionadViewPlugin.swift
//  flutter_unionad
//
//  Created by 9Y on 2020/9/4.
//

import Foundation
import Flutter

class FlutterUnionadViewPlugin{
    static func register(viewRegistrar : FlutterPluginRegistrar){
        print("初始化view")
        print(viewRegistrar.messenger())
       //banner广告
        let bannerExpressAdViewFactory = BannerExpressAdViewFactory(messenger: viewRegistrar.messenger())
        viewRegistrar.register(bannerExpressAdViewFactory, withId: "com.gstory.flutter_unionad/BannerExpressAdView")
    }
}

