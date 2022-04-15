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
        
    public func initTTSDK(params : NSDictionary,handelr:@escaping BUCompletionHandler){
        let appId = params.value(forKey: "iosAppId") as? String
        let debug = params.value(forKey: "debug") as? Bool ?? false
        let personalise = params.value(forKey: "personalise") as? String
        let userExtData = "[{\"name\":\"personal_ads_type\" ,\"value\":\"%@\"}]"
        if(appId != nil){
            BUAdSDKManager.setAppID(appId)
            BUAdSDKManager.setLoglevel(debug ? BUAdSDKLogLevel.debug : BUAdSDKLogLevel.none)
            BUAdSDKManager.setUserExtData(NSString(format: userExtData as NSString, personalise!) as String)
            BUAdSDKManager.start(asyncCompletionHandler: handelr)
        }
    }
}

