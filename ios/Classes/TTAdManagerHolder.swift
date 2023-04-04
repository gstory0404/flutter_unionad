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
        let themeStatus = params.value(forKey: "themeStatus") as! NSNumber
        let userExtData = "[{\"name\":\"personal_ads_type\" ,\"value\":\"%@\"}]"
        if(appId != nil){
            let config = BUAdSDKConfiguration.init();
            config.appID = appId ?? "";
            if(debug){
                config.debugLog = 1;
            }else{
                config.debugLog = 0;
            }
//            config.privacyProvider = BUDPrivacyProvider.init();
            config.userExtData = NSString(format: userExtData as NSString, personalise!) as String;
            config.themeStatus = themeStatus;
            BUAdSDKManager.start(asyncCompletionHandler: handelr)
        }
    }
}

