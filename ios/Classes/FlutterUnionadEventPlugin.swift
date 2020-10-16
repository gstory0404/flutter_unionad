//
//  FlutterUnionadEventPlugin.swift
//  flutter_unionad
//
//  Created by gstory0404@gmail on 2020/9/3.
//

import Foundation
import Flutter

public class FlutterUnionadEnentPlugin : NSObject, FlutterStreamHandler{
    
    private var eventSink:FlutterEventSink? = nil
    
    init(_ registrar: FlutterPluginRegistrar){
        super.init()
        let eventChannel = FlutterEventChannel.init(name: FlutterUnionadConfig.event.adevent, binaryMessenger:registrar.messenger())
        eventChannel.setStreamHandler((self as FlutterStreamHandler & NSObjectProtocol))
    }
    
    
    public func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        eventSink = events
        return nil
    }
    
    public func onCancel(withArguments arguments: Any?) -> FlutterError? {
        eventSink = nil
        return nil
    }
    
    //发送event
    public func sendEvent(event:NSDictionary) {
        eventSink?(event)
    }

}
