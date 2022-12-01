//
//  NativeAdViewFactory.swift
//  flutter_unionad
//
//  Created by gstory0404@gmail on 2020/9/28.
//

import Foundation
import Flutter

public class NativeAdViewFactory: NSObject,FlutterPlatformViewFactory {
    private var messenger: FlutterBinaryMessenger

    init(messenger: NSObjectProtocol & FlutterBinaryMessenger) {
        self.messenger = messenger
        super.init()
    }

    public func create(withFrame frame: CGRect, viewIdentifier viewId: Int64, arguments args: Any?) -> FlutterPlatformView {
        return NativeAdView(frame,  binaryMessenger: self.messenger,id: viewId, params:args)
    }

    public func createArgsCodec() -> FlutterMessageCodec & NSObjectProtocol {
        return FlutterStandardMessageCodec.sharedInstance()
    }
}
