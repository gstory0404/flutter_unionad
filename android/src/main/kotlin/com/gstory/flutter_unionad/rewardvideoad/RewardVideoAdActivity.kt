package com.gstory.flutter_unionad.rewardvideoad

import android.os.Bundle
import android.util.Log
import androidx.annotation.Nullable
import com.bytedance.sdk.openadsdk.*
import com.bytedance.sdk.openadsdk.TTAdNative.RewardVideoAdListener
import com.bytedance.sdk.openadsdk.TTRewardVideoAd.RewardAdInteractionListener
import com.gstory.flutter_unionad.FlutterUnionadEventPlugin
import com.gstory.flutter_unionad.R
import com.gstory.flutter_unionad.TTAdManagerHolder
import com.gstory.flutter_unionad.UIUtils
import io.flutter.app.FlutterActivity


/**
 * @Description:
 * @Author: gstory0404@gmail
 * @CreateDate: 2020/8/20 18:46
 */
class RewardVideoAdActivity : FlutterActivity() {
    private val TAG = "RewardVideoAdActivity"
    lateinit var mTTAdNative: TTAdNative
    private var mttRewardVideoAd: TTRewardVideoAd? = null
    private var mIsLoaded = false //视频是否加载完成

    //参数
    private var mIsExpress: Boolean = false //是否请求模板广告
    private var mCodeId: String? = null
    private var supportDeepLink: Boolean? = false
    private var expressViewWidth: Float? = 0f
    private var expressViewHeight: Float? = 0f
    private var rewardName: String? = null
    private var rewardAmount: Int? = 0
    private var userID: String? = null
    private var orientation: Int? = TTAdConstant.VERTICAL
    private var mediaExtra: String? = null


    override fun onCreate(@Nullable savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_rewardvideoad)
        mIsExpress = intent.getBooleanExtra("mIsExpress", true)
        mCodeId = intent.getStringExtra("mCodeId")
        supportDeepLink = intent.getBooleanExtra("supportDeepLink", true)
        expressViewWidth = intent.getFloatExtra("expressViewWidth", 1080f)
        expressViewHeight = intent.getFloatExtra("expressViewHeight", 1920f)
        rewardName = intent.getStringExtra("rewardName")
        rewardAmount = intent.getIntExtra("rewardAmount", 0)
        userID = intent.getStringExtra("userID")
        orientation = intent.getIntExtra("orientation", 1)
        mediaExtra = intent.getStringExtra("mediaExtra")
        val mTTAdManager = TTAdManagerHolder.get()
        mTTAdNative = mTTAdManager.createAdNative(this.applicationContext)
        loadRewardVideoAd()
    }

    private fun loadRewardVideoAd() {
        Log.e(TAG, "mIsExpress $mIsExpress " +
                "\nmCodeId $mCodeId " +
                "\nsupportDeepLink $supportDeepLink " +
                "\nexpressViewWidth $expressViewWidth " +
                "\nexpressViewHeight $expressViewHeight " +
                "\nrewardName $rewardName " +
                "\nrewardAmount $rewardAmount " +
                "\nuserID $userID " +
                "\norientation $orientation " +
                "\nmediaExtra $mediaExtra ")
        val adSlot: AdSlot
        if (mIsExpress) {
            adSlot = AdSlot.Builder()
                    .setCodeId(mCodeId)
                    .setSupportDeepLink(supportDeepLink!!)
                    .setAdCount(1) //个性化模板广告需要设置期望个性化模板广告的大小,单位dp,激励视频场景，只要设置的值大于0即可
                    .setExpressViewAcceptedSize(UIUtils.px2dip(this, expressViewWidth!!), UIUtils.px2dip(this, expressViewHeight!!))
                    .setImageAcceptedSize(1080, 1920)
                    .setRewardName(rewardName) //奖励的名称
                    .setRewardAmount(rewardAmount!!) //奖励的数量
                    //必传参数，表来标识应用侧唯一用户；若非服务器回调模式或不需sdk透传
                    //可设置为空字符串
                    .setUserID(userID)
                    .setOrientation(orientation!!) //设置期望视频播放的方向，为TTAdConstant.HORIZONTAL或TTAdConstant.VERTICAL
                    .setMediaExtra(mediaExtra) //用户透传的信息，可不传
                    .build()
        } else {
            adSlot = AdSlot.Builder()
                    .setCodeId(mCodeId)
                    .setSupportDeepLink(supportDeepLink!!)
                    .setAdCount(1)
                    .setRewardName(rewardName) //奖励的名称
                    .setRewardAmount(rewardAmount!!) //奖励的数量
                    //必传参数，表来标识应用侧唯一用户；若非服务器回调模式或不需sdk透传
                    //可设置为空字符串
                    .setUserID(userID)
                    .setOrientation(orientation!!) //设置期望视频播放的方向，为TTAdConstant.HORIZONTAL或TTAdConstant.VERTICAL
                    .setMediaExtra(mediaExtra) //用户透传的信息，可不传
                    .build()
        }
        mTTAdNative.loadRewardVideoAd(adSlot, object : RewardVideoAdListener {
            override fun onError(code: Int, message: String) {
                Log.e(TAG, "视频加载失败$code $message")
                this@RewardVideoAdActivity.finish()
            }

            //视频广告加载后的视频文件资源缓存到本地的回调
            override fun onRewardVideoCached() {
                Log.e(TAG, "rewardVideoAd video cached")
                mIsLoaded = true
                mttRewardVideoAd!!.showRewardVideoAd(this@RewardVideoAdActivity, TTAdConstant.RitScenes.CUSTOMIZE_SCENES, "scenes_test")
                mttRewardVideoAd = null
            }

            //视频广告素材加载到，如title,视频url等，不包括视频文件
            override fun onRewardVideoAdLoad(ad: TTRewardVideoAd) {
                Log.e(TAG, "rewardVideoAd loaded 广告类型：${getAdType(ad.rewardVideoAdType)}")
                mIsLoaded = false
                mttRewardVideoAd = ad
                //mttRewardVideoAd.setShowDownLoadBar(false);
                mttRewardVideoAd!!.setRewardAdInteractionListener(object : RewardAdInteractionListener {
                    override fun onAdShow() {
                        Log.e(TAG, "rewardVideoAd show")
                    }

                    override fun onAdVideoBarClick() {
                        Log.e(TAG, "rewardVideoAd bar click")
                    }

                    override fun onAdClose() {
                        Log.e(TAG, "rewardVideoAd close")
                        this@RewardVideoAdActivity.finish()
                    }

                    override fun onVideoError() {
                        Log.e(TAG, "rewardVideoAd onVideoError")
                        this@RewardVideoAdActivity.finish()
                    }

                    override fun onVideoComplete() {
                        Log.e(TAG, "rewardVideoAd complete")
                    }

                    override fun onRewardVerify(rewardVerify: Boolean, rewardAmount: Int, rewardName: String) {
                        Log.e(TAG, "verify: $rewardVerify amount:$rewardAmount name:$rewardName")
                        var map = mutableMapOf("adType" to "rewardAd", "rewardVerify" to rewardVerify, "rewardAmount" to rewardAmount, "rewardName" to rewardName)
                        FlutterUnionadEventPlugin.sendContent(map)
                    }

                    override fun onSkippedVideo() {
                        Log.e(TAG, "rewardVideoAd onSkippedVideo")
                    }
                })
                mttRewardVideoAd!!.setDownloadListener(object : TTAppDownloadListener {
                    override fun onIdle() {}
                    override fun onDownloadActive(totalBytes: Long, currBytes: Long, fileName: String, appName: String) {}
                    override fun onDownloadPaused(totalBytes: Long, currBytes: Long, fileName: String, appName: String) {}
                    override fun onDownloadFailed(totalBytes: Long, currBytes: Long, fileName: String, appName: String) {}
                    override fun onDownloadFinished(totalBytes: Long, fileName: String, appName: String) {}
                    override fun onInstalled(fileName: String, appName: String) {}
                })
            }
        })
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