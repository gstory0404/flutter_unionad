package com.gstory.flutter_unionad.rewardvideoad

import android.app.Activity
import android.content.Context
import android.os.Bundle
import android.os.Looper
import android.util.Log
import com.bytedance.sdk.openadsdk.AdSlot
import com.bytedance.sdk.openadsdk.TTAdConstant
import com.bytedance.sdk.openadsdk.TTAdLoadType
import com.bytedance.sdk.openadsdk.TTAdNative
import com.bytedance.sdk.openadsdk.TTAdNative.RewardVideoAdListener
import com.bytedance.sdk.openadsdk.TTRewardVideoAd
import com.bytedance.sdk.openadsdk.TTRewardVideoAd.RewardAdInteractionListener
import com.gstory.flutter_unionad.FlutterUnionadEventPlugin
import com.gstory.flutter_unionad.TTAdManagerHolder
import com.gstory.flutter_unionad.UIUtils
import java.util.*


/**
 * @Description:
 * @Author: gstory0404@gmail
 * @CreateDate: 2020/8/20 18:46
 */
object RewardVideoAd {
    private val TAG = "RewardVideoAd"

    var mContext: Context? = null
    var mActivity: Activity? = null

    lateinit var mTTAdNative: TTAdNative
    private var mttRewardVideoAd: TTRewardVideoAd? = null
    private var mIsLoaded = false //视频是否加载完成

    //参数
    private var mCodeId: String? = null
    private var supportDeepLink: Boolean? = false
    private var expressViewWidth: Float? = 0f
    private var expressViewHeight: Float? = 0f
    private var rewardName: String? = null
    private var rewardAmount: Int? = 0
    private var userID: String? = null
    private var orientation: Int? = TTAdConstant.VERTICAL
    private var mediaExtra: String? = null
    private var downloadType: Int = 1
    private var adLoadType : Int = 0

    fun init(context: Context, mActivity: Activity, params: Map<String?, Any?>) {
        this.mContext = context
        this.mActivity = mActivity
        this.mCodeId = params["androidCodeId"] as String
        this.supportDeepLink = params["supportDeepLink"] as Boolean
        this.expressViewWidth = UIUtils.dip2px(context, UIUtils.getScreenWidthDp(context))
        this.expressViewHeight = UIUtils.dip2px(context, UIUtils.getRealHeight(context).toFloat())
        this.rewardName = params["rewardName"] as String
        this.rewardAmount = params["rewardAmount"] as Int
        this.userID = params["userID"] as String
        if (params["orientation"] == null) {
            orientation = 0
        } else {
            this.orientation = params["orientation"] as Int
        }
        if (params["mediaExtra"] == null) {
            this.mediaExtra = ""
        } else {
            this.mediaExtra = params["mediaExtra"] as String
        }
        this.downloadType = params["downloadType"] as Int
        this.adLoadType = params["adLoadType"] as Int
        val mTTAdManager = TTAdManagerHolder.get()
        mTTAdNative = mTTAdManager.createAdNative(mContext)
        loadRewardVideoAd()
    }

    private fun loadRewardVideoAd() {
        var loadType = when (adLoadType) {
            1 -> {
                TTAdLoadType.LOAD
            }
            2 -> {
                TTAdLoadType.PRELOAD
            }
            else -> {
                TTAdLoadType.UNKNOWN
            }
        }
        val adSlot = AdSlot.Builder()
            .setCodeId(mCodeId)
            .setSupportDeepLink(supportDeepLink!!)
            .setAdCount(1) //个性化模板广告需要设置期望个性化模板广告的大小,单位dp,激励视频场景，只要设置的值大于0即可
            .setExpressViewAcceptedSize(UIUtils.px2dip(mContext!!, expressViewWidth!!), UIUtils.px2dip(mContext!!, expressViewHeight!!))
//            .setImageAcceptedSize(1080, 1920)
//                    .setRewardName(rewardName) //奖励的名称
//                    .setRewardAmount(rewardAmount!!) //奖励的数量
            .setAdLoadType(loadType) //预加载
            //必传参数，表来标识应用侧唯一用户；若非服务器回调模式或不需sdk透传
            //可设置为空字符串
            .setUserID(userID)
            .setOrientation(orientation!!) //设置期望视频播放的方向，为TTAdConstant.HORIZONTAL或TTAdConstant.VERTICAL
            .setMediaExtra(mediaExtra) //用户透传的信息，可不传
//                    .setDownloadType(downloadType)
            .build()

        mTTAdNative.loadRewardVideoAd(adSlot, object : RewardVideoAdListener {
            override fun onError(code: Int, message: String) {
                Log.e(TAG, "视频加载失败$code $message")
                var map: MutableMap<String, Any?> = mutableMapOf("adType" to "rewardAd", "onAdMethod" to "onFail", "error" to "$code $message")
                FlutterUnionadEventPlugin.sendContent(map)
            }

            //视频广告加载后的视频文件资源缓存到本地的回调
            override fun onRewardVideoCached() {
                Log.e(TAG, "rewardVideoAd video cached")
            }

            override fun onRewardVideoCached(p0: TTRewardVideoAd?) {
                Log.e(TAG, "rewardVideoAd video cached2")
                var map: MutableMap<String, Any?> = mutableMapOf("adType" to "rewardAd", "onAdMethod" to "onReady")
                FlutterUnionadEventPlugin.sendContent(map)
            }

            //视频广告素材加载到，如title,视频url等，不包括视频文件
            override fun onRewardVideoAdLoad(ad: TTRewardVideoAd) {
                Log.e(TAG, "rewardVideoAd loaded 广告类型：${getAdType(ad.rewardVideoAdType)}")
                mIsLoaded = false
                mttRewardVideoAd = ad
                mttRewardVideoAd?.setRewardAdInteractionListener(object : RewardAdInteractionListener {
                    override fun onAdShow() {
                        Log.e(TAG, "rewardVideoAd show")
                        var map: MutableMap<String, Any?> = mutableMapOf("adType" to "rewardAd", "onAdMethod" to "onShow")
                        FlutterUnionadEventPlugin.sendContent(map)
                    }

                    override fun onAdVideoBarClick() {
                        Log.e(TAG, "rewardVideoAd bar click")
                        var map: MutableMap<String, Any?> = mutableMapOf("adType" to "rewardAd", "onAdMethod" to "onClick")
                        FlutterUnionadEventPlugin.sendContent(map)
                    }

                    override fun onAdClose() {
                        Log.e(TAG, "rewardVideoAd close")
                        var map: MutableMap<String, Any?> = mutableMapOf("adType" to "rewardAd", "onAdMethod" to "onClose")
                        FlutterUnionadEventPlugin.sendContent(map)
                    }

                    override fun onVideoError() {
                        Log.e(TAG, "rewardVideoAd onVideoError")
                        var map: MutableMap<String, Any?> = mutableMapOf("adType" to "rewardAd", "onAdMethod" to "onFail", "error" to "")
                        FlutterUnionadEventPlugin.sendContent(map)
                    }

                    override fun onVideoComplete() {
                        Log.e(TAG, "rewardVideoAd complete")
                    }

                    /**
                     * 视频播放完成后，奖励验证回调
                     * rewardVerify：是否有效，
                     * rewardAmount：奖励梳理，
                     * rewardName：奖励名称，
                     * code：错误码，
                     * msg：错误信息
                     */
                    override fun onRewardVerify(p0: Boolean, p1: Int, p2: String?, p3: Int, p4: String?) {
                        Log.e(TAG, "verify: $p0 amount:$p1 name:$p2 p3:$p3 p4:$p4")
                        var map: MutableMap<String, Any?> = mutableMapOf("adType" to "rewardAd",
                                "onAdMethod" to "onVerify",
                                "rewardVerify" to p0,
                                "rewardAmount" to p1,
                                "rewardName" to p2,
                                "errorCode" to p3,
                                "error" to p4)
                        FlutterUnionadEventPlugin.sendContent(map)
                    }

                    /**
                     * 激励视频播放完毕，验证是否有效发放奖励的回调 4400版本新增
                     *
                     * @param isRewardValid 奖励有效
                     * @param rewardType 奖励类型，0:基础奖励 >0:进阶奖励
                     * @param extraInfo 奖励的额外参数
                     */
                    override fun onRewardArrived(p0: Boolean, p1: Int, p2: Bundle) {
                        Log.e(TAG, "onRewardArrived: $p0 amount:$p1 name:$p2")
                        var map: MutableMap<String, Any?> = mutableMapOf("adType" to "rewardAd",
                            "onAdMethod" to "onRewardArrived",
                            "rewardVerify" to p0,
                            "rewardType" to p1,
                            "rewardAmount" to p2["reward_extra_key_reward_amount"],
                            "rewardName" to p2["reward_extra_key_reward_name"],
                            "propose" to p2["reward_extra_key_reward_propose"],
                            "errorCode" to p2["reward_extra_key_error_code"],
                            "error" to p2["reward_extra_key_error_msg"])
                        FlutterUnionadEventPlugin.sendContent(map)
                    }

                    override fun onSkippedVideo() {
                        Log.e(TAG, "rewardVideoAd onSkippedVideo")
                        var map: MutableMap<String, Any?> = mutableMapOf("adType" to "rewardAd", "onAdMethod" to "onSkip")
                        FlutterUnionadEventPlugin.sendContent(map)
                    }
                })
            }
        })
    }

    /**
     * 显示激励广告
     */
    fun showAd() {
        if (mttRewardVideoAd == null) {
            var map: MutableMap<String, Any?> = mutableMapOf("adType" to "rewardAd", "onAdMethod" to "onUnReady", "error" to "广告预加载未完成")
            FlutterUnionadEventPlugin.sendContent(map)
            return
        }
        mIsLoaded = true
        mttRewardVideoAd?.showRewardVideoAd(mActivity, TTAdConstant.RitScenes.CUSTOMIZE_SCENES, "scenes_test")
        mttRewardVideoAd = null
    }

    private fun getAdType(type: Int): String? {
        when (type) {
            TTAdConstant.AD_TYPE_COMMON_VIDEO -> return "普通激励视频，type=$type"
            TTAdConstant.AD_TYPE_PLAYABLE_VIDEO -> return "Playable激励视频，type=$type"
            TTAdConstant.AD_TYPE_PLAYABLE -> return "纯Playable，type=$type"
        }
        return "未知类型+type=$type"
    }
}