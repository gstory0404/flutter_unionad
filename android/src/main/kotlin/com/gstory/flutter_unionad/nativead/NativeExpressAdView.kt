package com.gstory.flutter_unionad.nativead

import android.app.Activity
import android.content.Context
import android.util.Log
import android.view.View
import android.widget.FrameLayout
import com.bytedance.sdk.openadsdk.*
import com.bytedance.sdk.openadsdk.TTAdDislike.DislikeInteractionCallback
import com.bytedance.sdk.openadsdk.TTAdNative.NativeExpressAdListener
import com.bytedance.sdk.openadsdk.TTNativeExpressAd.ExpressAdInteractionListener
import com.gstory.flutter_unionad.FlutterunionadViewConfig
import com.gstory.flutter_unionad.TTAdManagerHolder
import com.gstory.flutter_unionad.UIUtils
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.platform.PlatformView


/**
 * @Description:个性化模板信息流广告
 * @Author: gstory0404@gmail
 * @CreateDate: 2020/8/20 16:31
 */
class NativeExpressAdView(var context: Context,var activity: Activity, var messenger: BinaryMessenger?, id: Int, params: Map<String?, Any?>) : PlatformView {
    private val TAG = "NativeExpressAdView"
    private var mExpressContainer: FrameLayout? = null
    var mTTAdNative: TTAdNative
    private var mTTAd: TTNativeExpressAd? = null
    //广告所需参数
    private val mCodeId: String?
    var supportDeepLink: Boolean? = true
    var expressViewWidth: Float
    var expressViewHeight: Float
    var mHasShowDownloadActive :Boolean? = false

    private var channel : MethodChannel?

    init {
        mCodeId = params["androidCodeId"] as String?
        supportDeepLink = params["supportDeepLink"] as Boolean?
        var width = params["expressViewWidth"] as Double
        var hight = params["expressViewHeight"] as Double
        expressViewWidth = width.toFloat()
        expressViewHeight = hight.toFloat()
        mExpressContainer = FrameLayout(context)
        val mTTAdManager = TTAdManagerHolder.get()
        mTTAdNative = mTTAdManager.createAdNative(context.applicationContext)
        channel = MethodChannel(messenger, FlutterunionadViewConfig.nativeAdView+"_"+id)
        loadNativeExpressAd()
    }

    override fun getView(): View {
        return mExpressContainer!!
    }

    /**
     * 加载信息流广告
     */
    private fun loadNativeExpressAd() {
        val adSlot = AdSlot.Builder()
                .setCodeId(mCodeId)
                .setSupportDeepLink(supportDeepLink!!)
                .setAdCount(1) //请求广告数量为1到3条
                .setImageAcceptedSize(640,320) //这个参数设置即可，不影响个性化模板广告的size
                .setExpressViewAcceptedSize(expressViewWidth, expressViewHeight)
                .build()
        //加载广告
        mTTAdNative.loadNativeExpressAd(adSlot, object : NativeExpressAdListener {
            override fun onError(code: Int, message: String) {
                Log.e(TAG, "信息流广告拉去失败 $code   $message")
                mExpressContainer!!.removeAllViews()
                channel?.invokeMethod("onFail",message)
            }

            override fun onNativeExpressAdLoad(ads: List<TTNativeExpressAd>) {
                if (ads == null || ads.size == 0) {
                    Log.e(TAG, "未拉去到信息流广告")
                    return
                }
                mTTAd = ads[0]
                bindAdListener(mTTAd!!)
                mTTAd!!.render() //调用render开始渲染广告
            }
        })
    }

    private fun bindAdListener(ad: TTNativeExpressAd) {
        ad.setExpressInteractionListener(object : ExpressAdInteractionListener {
            override fun onAdClicked(view: View, type: Int) {
                Log.e(TAG, "广告被点击")
            }

            override fun onAdShow(view: View, type: Int) {
                Log.e(TAG, "广告展示")
            }

            override fun onRenderFail(view: View, msg: String, code: Int) {
                Log.e(TAG, "ExpressView render fail:" + System.currentTimeMillis())
                channel?.invokeMethod("onFail",msg)
            }

            override fun onRenderSuccess(view: View, width: Float, height: Float) {
                //返回view的宽高 单位 dp
                Log.e(TAG, "渲染成功")
                //在渲染成功回调时展示广告，提升体验
                mExpressContainer!!.removeAllViews()
//                val mExpressContainerParams: FrameLayout.LayoutParams = FrameLayout.LayoutParams(UIUtils.dip2px(activity, width).toInt(), UIUtils.dip2px(activity, height).toInt())
//                mExpressContainerParams.gravity = Gravity.CENTER
//                mExpressContainer!!.layoutParams = mExpressContainerParams
                mExpressContainer!!.addView(view)
                channel?.invokeMethod("onShow","")
            }
        })
        //dislike设置
        bindDislike(ad, false)
        Log.e(TAG, ad.interactionType.toString())
//        if (ad.interactionType !== TTAdConstant.INTERACTION_TYPE_DOWNLOAD) {
//            return
//        }
        //可选，下载监听设置
//        ad.setDownloadListener(object : TTAppDownloadListener {
//            override fun onIdle() {
//                Log.e(TAG, "点击开始下载")
//            }
//
//            override fun onDownloadActive(totalBytes: Long, currBytes: Long, fileName: String, appName: String) {
//
//                if (!mHasShowDownloadActive!!) {
//                    mHasShowDownloadActive = true
//                    Log.e(TAG, "下载中，点击暂停")
//                }
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
        ad.setDislikeCallback(activity, object : DislikeInteractionCallback {
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
            //调用destroy()方法释放
            mTTAd!!.destroy();
        }
    }
}