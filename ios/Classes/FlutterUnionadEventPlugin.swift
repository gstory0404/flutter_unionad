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
    private var pendingEvents:[NSDictionary] = []
    
    init(_ registrar: FlutterPluginRegistrar){
        super.init()
        let eventChannel = FlutterEventChannel.init(name: FlutterUnionadConfig.event.adevent, binaryMessenger:registrar.messenger())
        eventChannel.setStreamHandler((self as FlutterStreamHandler & NSObjectProtocol))
    }
    
    
    public func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        eventSink = events
        if !pendingEvents.isEmpty {
            let replay = pendingEvents
            pendingEvents.removeAll()
            replay.forEach { events($0) }
        }
        return nil
    }
    
    public func onCancel(withArguments arguments: Any?) -> FlutterError? {
        eventSink = nil
        return nil
    }
    
    //发送event
    public func sendEvent(event:NSDictionary) {
        DispatchQueue.main.async {
            if let sink = self.eventSink {
                sink(event)
            } else {
                // 监听尚未建立时先缓存，避免 onReady 等关键事件丢失导致上层超时。
                self.pendingEvents.append(event)
                if self.pendingEvents.count > 50 {
                    self.pendingEvents.removeFirst(self.pendingEvents.count - 50)
                }
            }
        }
    }

}
