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
        let useMediation = params.value(forKey: "useMediation") as? Bool ?? false
        let themeStatus = params.value(forKey: "themeStatus") as! NSNumber
        //ios合规设置
        let iosPrivacy = params.value(forKey: "iosPrivacy") as! NSDictionary
        let limitPersonalAds = iosPrivacy.value(forKey: "limitPersonalAds") as! NSNumber
        let limitProgrammaticAds = iosPrivacy.value(forKey: "limitProgrammaticAds") as! NSNumber
        let forbiddenCAID = iosPrivacy.value(forKey: "forbiddenCAID") as! NSNumber
        if(appId != nil){
            let config = BUAdSDKConfiguration.init();
            config.appID = appId ?? "";
            config.useMediation = useMediation; //是否使用聚合
            if(debug){
                config.debugLog = 1;
            }else{
                config.debugLog = 0;
            }
            config.mediation.limitPersonalAds = limitPersonalAds; //限制个性化广告（聚合维度功能）
            config.mediation.limitProgrammaticAds = limitProgrammaticAds; // 不限制程序化广告（聚合维度功能）
            config.mediation.forbiddenCAID = forbiddenCAID; //不禁止CAID（聚合维度功能）
            config.themeStatus = themeStatus; //主题
            BUAdSDKManager.start(asyncCompletionHandler: handelr)
        }
    }
}

