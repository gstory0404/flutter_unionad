//
//  TTAdManagerHolder.swift
//  flutter_unionad
//
//  Created by gstory0404@gmail on 2020/9/9.
//

import Foundation
import BUAdSDK

public class TTAdManagerHolder : NSObject{
    public static let instace = TTAdManagerHolder()
    
    public var isInit : Bool = false
    
    public func initTTSDK(params : NSDictionary,handelr:@escaping BUCompletionHandler){
        let appId = params.value(forKey: "iosAppId") as? String
        let debug = params.value(forKey: "debug") as? Bool ?? false
        if(appId != nil){
            BUAdSDKManager.setAppID(appId)
            BUAdSDKManager.setLoglevel(debug ? BUAdSDKLogLevel.debug : BUAdSDKLogLevel.none)
            BUAdSDKManager.start(asyncCompletionHandler: handelr)
            LogUtil.logInstance.printLog(message: debug)
        }
    }
}

