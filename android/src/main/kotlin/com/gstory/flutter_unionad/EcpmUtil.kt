package com.gstory.flutter_unionad

import com.bytedance.sdk.openadsdk.mediation.manager.MediationAdEcpmInfo

/**
 * @Author: gstory
 * @CreateDate: 2025/3/12 11:42
 * @Description: java类作用描述
 */

object EcpmUtil {
    fun toMap(info: MediationAdEcpmInfo?): Map<String, Any>? {
        if(info == null){
            return null
        }
        return mapOf(
            //ADN的名称，与平台配置一致，自定义ADN时为ADN唯一标识
            "adnName" to info.sdkName,
            // 自定义ADN的名称，与平台配置一致，非自定义ADN为nil
            "customAdnName" to info.customSdkName,
            // 代码位
            "slotID" to info.slotId,
            // 价格标签，多阶底价下有效
            "levelTag" to info.levelTag,
            // 返回价格，nil为无权限
            "ecpm" to info.ecpm,
            // 广告类型
            "biddingType" to info.reqBiddingType,
            // 额外错误信息,一般为空(扩展字段)
            "errorMsg" to info.errorMsg,
            // adn提供的真实广告加载ID，可为空
            "requestID" to info.requestId,
            // adn提供的真实广告创意ID，可为空
            "creativeID" to "",
            // 广告位类型
            "adRitType" to info.ritType,
            // 流量分组ID
            "segmentId" to info.segmentId,
            // AB实验分组ID
            "abtestId" to info.abTestId,
            // 渠道名称
            "channel" to info.channel,
            // 子渠道名称
            "sub_channel" to info.subChannel,
            // 场景ID
            "scenarioId" to info.scenarioId,
            // 混用类型，banner/fullVideo/rewardVideo/feed/draw/interstitial
            "subRitType" to info.subRitType
        )
    }
}