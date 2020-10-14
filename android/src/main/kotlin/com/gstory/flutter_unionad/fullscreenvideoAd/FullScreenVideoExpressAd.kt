package com.gstory.flutter_unionad.fullscreenvideoAd

import android.app.Activity
import android.content.Context
import android.util.Log
import com.bytedance.sdk.openadsdk.*
import com.gstory.flutter_unionad.FlutterUnionadEventPlugin
import com.gstory.flutter_unionad.TTAdManagerHolder
import com.gstory.flutter_unionad.UIUtils

/**
 * @Description:
 * @Author: gstory0404@gmail
 * @CreateDate: 2020/8/21 15:48
 */
object FullScreenVideoExpressAd {
    private var TAG = "FullScreenVideoExpressAd"
    var mContext: Context? = null
    var mActivity: Activity? = null
    lateinit var mTTAdNative: TTAdNative
    private var mttFullVideoAd: TTFullScreenVideoAd? = null

    //广告所需参数
    private var mCodeId: String? = null
    private var supportDeepLink: Boolean? = true
    private var orientation: Int = 1


    fun init(context: Context, mActivity: Activity, mCodeId: String?, supportDeepLink: Boolean?, orientation: Int?) {
        this.mContext = context
        this.mActivity = mActivity
        this.mCodeId = mCodeId
        this.supportDeepLink = supportDeepLink
        this.orientation = orientation!!
        val mTTAdManager = TTAdManagerHolder.get()
        mTTAdNative = mTTAdManager.createAdNative(context.applicationContext)
        loadFullScreenVideoAd()
    }

    private fun loadFullScreenVideoAd() {
        Log.e(TAG, "广告位id  $mCodeId")
        var width = UIUtils.dip2px(mContext!!, UIUtils.getScreenWidthDp(mContext!!)).toFloat()
        var height =UIUtils.dip2px(mContext!!, UIUtils.getRealHeight(mContext!!).toFloat()).toFloat()
        //设置广告参数
        val adSlot = AdSlot.Builder()
                .setCodeId(mCodeId) //广告位id
                .setSupportDeepLink(supportDeepLink!!)
                .setExpressViewAcceptedSize(width, height)
                .setOrientation(orientation)
                .build()
        //加载全屏视频
        mTTAdNative.loadFullScreenVideoAd(adSlot, object : TTAdNative.FullScreenVideoAdListener {
            override fun onError(code: Int, message: String) {
                Log.e(TAG, "fullScreenVideoAd加载失败  $code === > $message")
            }

            override fun onFullScreenVideoAdLoad(ad: TTFullScreenVideoAd) {
                Log.e(TAG, "fullScreenVideoAd loaded")
                mttFullVideoAd = ad
                mttFullVideoAd!!.setFullScreenVideoAdInteractionListener(object : TTFullScreenVideoAd.FullScreenVideoAdInteractionListener {
                    override fun onAdShow() {
                        Log.e(TAG, "fullScreenVideoAd show")
                        var map: MutableMap<String, Any?> = mutableMapOf("adType" to "fullVideoAd", "fullVideoType" to "onAdShow")
                        FlutterUnionadEventPlugin.sendContent(map)
                    }

                    override fun onAdVideoBarClick() {
                        Log.e(TAG, "fullScreenVideoAd click")
                        var map: MutableMap<String, Any?> = mutableMapOf("adType" to "fullVideoAd", "fullVideoType" to "onAdVideoBarClick")
                        FlutterUnionadEventPlugin.sendContent(map)
                    }

                    override fun onAdClose() {
                        Log.e(TAG, "fullScreenVideoAd close")
                        var map: MutableMap<String, Any?> = mutableMapOf("adType" to "fullVideoAd", "fullVideoType" to "onAdClose")
                        FlutterUnionadEventPlugin.sendContent(map)
                    }

                    override fun onVideoComplete() {
                        Log.e(TAG, "fullScreenVideoAd complete")
                        var map: MutableMap<String, Any?> = mutableMapOf("adType" to "fullVideoAd", "fullVideoType" to "onVideoComplete")
                        FlutterUnionadEventPlugin.sendContent(map)
                    }

                    override fun onSkippedVideo() {
                        Log.e(TAG, "fullScreenVideoAd skipped")
                        var map: MutableMap<String, Any?> = mutableMapOf("adType" to "fullVideoAd", "fullVideoType" to "onSkippedVideo")
                        FlutterUnionadEventPlugin.sendContent(map)
                    }
                })
                mttFullVideoAd!!.showFullScreenVideoAd(mActivity)
            }

            override fun onFullScreenVideoCached() {
                Log.e(TAG, "fullScreenVideoAd video cached")
            }
        })
    }
}