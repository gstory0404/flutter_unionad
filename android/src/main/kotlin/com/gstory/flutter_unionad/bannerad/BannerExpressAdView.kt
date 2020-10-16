package com.gstory.flutter_unionad.bannerad

import android.app.Activity
import android.content.Context
import android.util.Log
import android.view.View
import android.widget.FrameLayout
import com.bytedance.sdk.openadsdk.*
import com.bytedance.sdk.openadsdk.TTAdNative.NativeExpressAdListener
import com.bytedance.sdk.openadsdk.TTNativeExpressAd.ExpressAdInteractionListener
import com.gstory.flutter_unionad.FlutterunionadViewConfig
import com.gstory.flutter_unionad.TTAdManagerHolder.get
import com.gstory.flutter_unionad.UIUtils
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.platform.PlatformView


/**
 * @Description: 个性化模板Banner广告
 * @Author: gstory0404@gmail
 * @CreateDate: 2020/8/7 10:31
 */
internal class BannerExpressAdView(var context: Context, var activity: Activity, messenger: BinaryMessenger?, id: Int, params: Map<String?, Any?>) : PlatformView {
    private val TAG = "BannerExpressAdView"
    var mTTAdNative: TTAdNative
    private var mTTAd: TTNativeExpressAd? = null
    private var mExpressContainer: FrameLayout? = null

    //广告所需参数
    private var mCodeId: String?
    var supportDeepLink: Boolean? = true
    var expressViewWidth: Float
    var expressViewHeight: Float
    var expressAdNum: Int
    var expressTime : Int

    private var startTime: Long = 0

    private var channel : MethodChannel?


    init {
        mCodeId = params["androidCodeId"] as String?
        supportDeepLink = params["supportDeepLink"] as Boolean?
        var width = params["expressViewWidth"] as Double
        var hight = params["expressViewHeight"] as Double
        expressAdNum = params["expressAdNum"] as Int
        expressTime = params["expressTime"] as Int
        expressViewWidth = width.toFloat()
        expressViewHeight = hight.toFloat()
        mExpressContainer = FrameLayout(activity)
        val mTTAdManager = get()
        mTTAdNative = mTTAdManager.createAdNative(context.applicationContext)
        channel = MethodChannel(messenger,FlutterunionadViewConfig.bannerAdView+"_"+id)
        loadBannerExpressAd()
    }

    override fun getView(): View {
        return mExpressContainer!!
    }

    private fun loadBannerExpressAd() {
        val adSlot = AdSlot.Builder()
                .setCodeId(mCodeId) //广告位id
                .setSupportDeepLink(supportDeepLink!!)
                .setAdCount(expressAdNum) //请求广告数量为1到3条
                .setExpressViewAcceptedSize(expressViewWidth, expressViewHeight) //期望模板广告view的size,单位dp
                .setImageAcceptedSize(640, 320)//这个参数设置即可，不影响个性化模板广告的size
                .build()
        mTTAdNative.loadBannerExpressAd(adSlot, object : NativeExpressAdListener {
            override fun onError(code: Int, message: String) {
                mExpressContainer!!.removeAllViews()
                channel?.invokeMethod("onFail",message)
            }

            override fun onNativeExpressAdLoad(ads: List<TTNativeExpressAd>) {
                if (ads == null || ads.size == 0) {
                    return
                }
                mTTAd = ads[0]
                if(null != expressTime && expressTime > 30){
                    //轮播间隔
                    mTTAd!!.setSlideIntervalTime(expressTime * 1000)
                }
                bindAdListener(mTTAd!!)
                startTime = System.currentTimeMillis()
                mTTAd!!.render()
            }
        })
    }


    private fun bindAdListener(ad: TTNativeExpressAd) {
        ad.setExpressInteractionListener(object : ExpressAdInteractionListener {
            override fun onAdClicked(view: View, type: Int) {
                Log.e(TAG, "广告点击")
            }

            override fun onAdShow(view: View, type: Int) {
                Log.e(TAG, "广告显示")
            }

            override fun onRenderFail(view: View, msg: String, code: Int) {
                Log.e(TAG, "render fail: $code   $msg")
                channel?.invokeMethod("onFail",msg)
            }

            override fun onRenderSuccess(view: View, width: Float, height: Float) {
                Log.e("ExpressView", "render suc:" + (System.currentTimeMillis() - startTime))
                Log.e(TAG, "\nexpressViewWidth=$expressViewWidth " +
                        "\nexpressViewWidthDP=${UIUtils.px2dip(activity, expressViewWidth)}" +
                        "\nexpressViewHeight $expressViewHeight" +
                        "\nexpressViewHeightDP=${UIUtils.px2dip(activity, expressViewHeight)}" +
                        "\nwidth= $width" +
                        "\nwidthDP= ${UIUtils.dip2px(activity, width)}"+
                        "\nheight= $height" +
                        "\nheightDP= ${UIUtils.dip2px(activity, height)}")
                //返回view的宽高 单位 dp
                mExpressContainer!!.removeAllViews()
//                val mExpressContainerParams: FrameLayout.LayoutParams = FrameLayout.LayoutParams(UIUtils.dip2px(activity, width).toInt(), UIUtils.dip2px(activity, height).toInt())
//                mExpressContainer!!.layoutParams = mExpressContainerParams
                mExpressContainer!!.addView(view)
                channel?.invokeMethod("onShow","")
            }
        })
        //dislike设置
        bindDislike(ad, false)
//        if (ad.interactionType != TTAdConstant.INTERACTION_TYPE_DOWNLOAD) {
//            return
//        }
//        ad.setDownloadListener(object : TTAppDownloadListener {
//            override fun onIdle() {
//                Log.e(TAG, "点击开始下载")
//            }
//
//            override fun onDownloadActive(totalBytes: Long, currBytes: Long, fileName: String, appName: String) {
//                Log.e(TAG, "下载中，点击暂停")
////                if (!mHasShowDownloadActive) {
////                    mHasShowDownloadActive = true
////                    TToast.show(this@BannerExpressActivity, "下载中，点击暂停", Toast.LENGTH_LONG)
////                }
//            }
//
//            override fun onDownloadPaused(totalBytes: Long, currBytes: Long, fileName: String, appName: String) {
//                Log.e(TAG, "下载暂停，点击继续")
//            }
//
//            override fun onDownloadFailed(totalBytes: Long, currBytes: Long, fileName: String, appName: String) {
//                Log.e(TAG, "下载失败，点击重新下载")
//            }
//
//            override fun onInstalled(fileName: String, appName: String) {
//                Log.e(TAG, "安装完成，点击图片打开")
//            }
//
//            override fun onDownloadFinished(totalBytes: Long, fileName: String, appName: String) {
//                Log.e(TAG, "点击安装")
//            }
//        })
    }

    /**
     * 设置广告的不喜欢，开发者可自定义样式
     * @param ad
     * @param customStyle 是否自定义样式，true:样式自定义
     */
    private fun bindDislike(ad: TTNativeExpressAd, customStyle: Boolean) {
        //使用默认个性化模板中默认dislike弹出样式
        ad.setDislikeCallback(activity, object : TTAdDislike.DislikeInteractionCallback {
            override fun onSelected(position: Int, value: String) {
                Log.e(TAG, "点击 $value")
                //用户选择不喜欢原因后，移除广告展示
                mExpressContainer!!.removeAllViews()
                channel?.invokeMethod("onDislike",value)
            }

            override fun onCancel() {
                Log.e(TAG, "点击取消")
            }

            override fun onRefuse() {

            }
        })
    }

    override fun dispose() {
        if (mTTAd != null) {
            mTTAd!!.destroy()
        }
    }
}