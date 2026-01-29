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
        let localConfig = params.value(forKey: "localConfig") as? String
        //流量分组
        let userInfoMap = params.value(forKey: "userInfo") as! NSDictionary
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
            if(localConfig != nil && !localConfig!.isEmpty){
                config.mediation.advanceSDKConfigPath = Bundle.path(forResource: localConfig, ofType: "json", inDirectory: "")
            }
//            config.mediation.forbiddenCAID = forbiddenCAID; //不禁止CAID（聚合维度功能）
            //流量分组
            let segment = BUMUserInfoForSegment.init()
            segment.user_id = userInfoMap.value(forKey: "userId") as? String
            segment.age = userInfoMap.value(forKey: "age") as! Int
            let gender = userInfoMap.value(forKey: "gender") as! Int
            if(gender == 0){
                segment.gender = BUUserInfoGender.female
            }else if(gender == 1){
                segment.gender = BUUserInfoGender.male
            }else if(gender == 2){
                segment.gender = BUUserInfoGender.unknown
            }else{
                segment.gender = BUUserInfoGender.unSet
            }
            segment.channel = userInfoMap.value(forKey: "channel") as? String
            segment.sub_channel = userInfoMap.value(forKey: "subChannel") as? String
            segment.user_value_group = userInfoMap.value(forKey: "userValueGroup") as? String
            segment.customized_id = userInfoMap.value(forKey: "customInfos") as? [AnyHashable: Any]
            config.mediation.userInfoForSegment = segment
            //主题
            config.themeStatus = themeStatus;
            BUAdSDKManager.start(asyncCompletionHandler: handelr)
        }
    }
}

