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
    
    public func initTTSDK(params : NSDictionary){
        let appId = params.value(forKey: "iosAppId") as? String
        let debug = params.value(forKey: "debug") as? Bool ?? false
        if(appId != nil){
            BUAdSDKManager.setAppID(appId)
            BUAdSDKManager.setLoglevel(debug ? BUAdSDKLogLevel.debug : BUAdSDKLogLevel.none)
            LogUtil.logInstance.printLog(message: debug)
        }
    }
}

