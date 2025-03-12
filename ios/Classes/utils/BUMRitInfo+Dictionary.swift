//
//  BUMRitInfo+Dictionary.swift
//  Pods
//
//  Created by 郭维佳 on 2025/3/11.
//

import Foundation
import BUAdSDK

extension BUMRitInfo {
    func toDictionary() -> [String: Any] {
        var dict: [String: Any] = [:]
        
        // ADN的名称，与平台配置一致，自定义ADN时为ADN唯一标识
        if let adnName = self.value(forKey: "adnName") {
            dict["adnName"] = adnName
        }
        /// 自定义ADN的名称，与平台配置一致，非自定义ADN为nil
        if let customAdnName = self.value(forKey: "customAdnName") {
            dict["customAdnName"] = customAdnName
        }
        // 代码位
        if let slotID = self.value(forKey: "slotID") {
            dict["slotID"] = slotID
        }
        // 价格标签，多阶底价下有效
        if let levelTag = self.value(forKey: "levelTag") {
            dict["levelTag"] = levelTag
        }
        // 返回价格，nil为无权限
        if let ecpm = self.value(forKey: "ecpm") {
            dict["ecpm"] = ecpm
        }
        // 广告类型
        if let biddingType = self.value(forKey: "biddingType") {
            dict["biddingType"] = biddingType
        }
        // 额外错误信息,一般为空(扩展字段)
        if let errorMsg = self.value(forKey: "errorMsg") {
            dict["errorMsg"] = errorMsg
        }
        // adn提供的真实广告加载ID，可为空
        if let requestID = self.value(forKey: "requestID") {
            dict["requestID"] = requestID
        }
        // adn提供的真实广告创意ID，可为空
        if let creativeID = self.value(forKey: "creativeID") {
            dict["creativeID"] = creativeID
        }
        // 广告位类型
        if let adRitType = self.value(forKey: "adRitType") {
            dict["adRitType"] = adRitType
        }
        // 流量分组ID
        if let segmentId = self.value(forKey: "segmentId") {
            dict["segmentId"] = segmentId
        }
        // AB实验分组ID
        if let abtestId = self.value(forKey: "abtestId") {
            dict["abtestId"] = abtestId
        }
        // 渠道名称
        if let channel = self.value(forKey: "channel") {
            dict["channel"] = channel
        }
        // 子渠道名称
        if let sub_channel = self.value(forKey: "sub_channel") {
            dict["sub_channel"] = sub_channel
        }
        // 场景ID
        if let scenarioId = self.value(forKey: "scenarioId") {
            dict["scenarioId"] = scenarioId
        }
        // 混用类型，banner/fullVideo/rewardVideo/feed/draw/interstitial
        if let subRitType = self.value(forKey: "subRitType") {
            dict["subRitType"] = subRitType
        }
        return dict
    }
}
