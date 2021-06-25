package com.gstory.flutter_unionad.fullscreenvideoadinteraction

import android.app.Activity
import android.content.Context
import android.util.Log
import com.bykv.vk.openvk.TTFullVideoObject
import com.bykv.vk.openvk.TTVfNative
import com.bykv.vk.openvk.VfSlot
import com.gstory.flutter_unionad.FlutterUnionadEventPlugin
import com.gstory.flutter_unionad.TTAdManagerHolder
import com.gstory.flutter_unionad.UIUtils

/**
 * @Description:
 * @Author: gstory0404@gmail
 * @CreateDate: 2020/8/21 15:48
 */
object FullScreenVideoAdInteraction {
    private var TAG = "FullScreenVideoExpressAd"
    var mContext: Context? = null
    var mActivity: Activity? = null
    lateinit var mTTAdNative: TTVfNative
    private var mttFullVideoAd: TTFullVideoObject? = null

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
        mTTAdNative = mTTAdManager.createVfNative(context.applicationContext)
        loadFullScreenVideoAd()
    }

    private fun loadFullScreenVideoAd() {
        Log.e(TAG, "广告位id  $mCodeId")
        //设置广告参数
        val adSlot = VfSlot.Builder()
                .setCodeId(mCodeId) //广告位id
                .setSupportDeepLink(supportDeepLink!!)
                .setExpressViewAcceptedSize(500f, 500f)
                .setOrientation(orientation)
                .build()
        //加载全屏视频
        mTTAdNative.loadFullVideoVs(adSlot, object : TTVfNative.FullScreenVideoAdListener {
            override fun onError(code: Int, message: String) {
                Log.e(TAG, "fullScreenVideoAd加载失败  $code === > $message")
                var map: MutableMap<String, Any?> = mutableMapOf("adType" to "fullScreenVideoAdInteraction", "onAdMethod" to "onFail", "error" to "$code , $message")
                FlutterUnionadEventPlugin.sendContent(map)
            }


            override fun onFullVideoVsLoad(ad: TTFullVideoObject) {
                Log.e(TAG, "fullScreenVideoAdInteraction loaded")
                mttFullVideoAd = ad
                mttFullVideoAd!!.setFullScreenVideoAdInteractionListener(object : TTFullVideoObject.FullVideoVsInteractionListener {
                    override fun onShow() {
                        Log.e(TAG, "fullScreenVideoAdInteraction show")
                        var map: MutableMap<String, Any?> = mutableMapOf("adType" to "fullScreenVideoAdInteraction", "onAdMethod" to "onShow")
                        FlutterUnionadEventPlugin.sendContent(map)
                    }

                    override fun onVideoBarClick() {
                        Log.e(TAG, "fullScreenVideoAd click")
                        var map: MutableMap<String, Any?> = mutableMapOf("adType" to "fullScreenVideoAdInteraction", "onAdMethod" to "onClick")
                        FlutterUnionadEventPlugin.sendContent(map)
                    }

                    override fun onClose() {
                        Log.e(TAG, "fullScreenVideoAd close")
                        var map: MutableMap<String, Any?> = mutableMapOf("adType" to "fullScreenVideoAdInteraction", "onAdMethod" to "onClose")
                        FlutterUnionadEventPlugin.sendContent(map)
                    }

                    override fun onVideoComplete() {
                        Log.e(TAG, "fullScreenVideoAd complete")
                        var map: MutableMap<String, Any?> = mutableMapOf("adType" to "fullScreenVideoAdInteraction", "onAdMethod" to "onFinish")
                        FlutterUnionadEventPlugin.sendContent(map)
                    }

                    override fun onSkippedVideo() {
                        Log.e(TAG, "fullScreenVideoAd skipped")
                        var map: MutableMap<String, Any?> = mutableMapOf("adType" to "fullScreenVideoAdInteraction", "onAdMethod" to "onSkip")
                        FlutterUnionadEventPlugin.sendContent(map)
                    }
                })
                var map: MutableMap<String, Any?> = mutableMapOf("adType" to "fullScreenVideoAdInteraction", "onAdMethod" to "onReady")
                FlutterUnionadEventPlugin.sendContent(map)
            }

            override fun onFullVideoCached() {
                Log.e(TAG, "fullScreenVideoAdInteraction video cached")
            }
        })
    }

    fun showAd() {
        if (mttFullVideoAd == null) {
            var map: MutableMap<String, Any?> = mutableMapOf("adType" to "fullScreenVideoAdInteraction","onAdMethod" to "onUnReady" , "error" to "广告预加载未完成")
            FlutterUnionadEventPlugin.sendContent(map)
            return
        }
        mttFullVideoAd!!.showFullVideoVs(mActivity)
    }
}