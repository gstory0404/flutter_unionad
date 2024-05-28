package com.gstory.flutter_unionad.splashad

import android.app.Activity
import android.content.Context
import android.util.Log
import android.view.View
import android.widget.FrameLayout
import com.bytedance.sdk.openadsdk.*
import com.gstory.flutter_unionad.FlutterunionadViewConfig
import com.gstory.flutter_unionad.TTAdManagerHolder
import com.gstory.flutter_unionad.UIUtils
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.platform.PlatformView


/**
 * @Description: 开屏广告
 * @Author: gstory0404@gmail
 * @CreateDate: 2020/8/19 10:34
 */
internal class SplashAdView(var context: Context, var activity: Activity, private var messenger: BinaryMessenger, id: Int, params: Map<String?, Any?>) : PlatformView {
    private val TAG = "SplashAdView"
    private var mContainer: FrameLayout? = null
    private var mSplashAd : CSJSplashAd? = null

    //广告所需参数
    private val mCodeId: String?
    private var supportDeepLink: Boolean? = true
    private var viewWidth: Float
    private var viewHeight: Float
    private var timeout : Int = 3000

    private var channel : MethodChannel?

    init {
        mCodeId = params["androidCodeId"] as String?
        supportDeepLink = params["supportDeepLink"] as Boolean?
        var width = params["width"] as Double
        var height = params["height"] as Double
        timeout = params["timeout"] as Int
        if (width == 0.0) {
            viewWidth = UIUtils.getScreenWidthDp(context)
        } else {
            viewWidth = width.toFloat()
        }
        if (height == 0.0) {
            viewHeight = UIUtils.px2dip(context, UIUtils.getRealHeight(context).toFloat())
        } else {
            viewHeight = height.toFloat()
        }
        mContainer = FrameLayout(context)
        channel = MethodChannel(messenger, FlutterunionadViewConfig.splashAdView+"_"+id)
        loadSplashAd()
    }

    override fun getView(): View {
        return mContainer!!
    }

    /**
     * 加载开屏广告
     */
    private fun loadSplashAd() {
        val mTTAdNative = TTAdSdk.getAdManager().createAdNative(activity)
        var adSlot = AdSlot.Builder()
            .setCodeId(mCodeId)
            .setSupportDeepLink(supportDeepLink!!)
            //不区分渲染方式，要求开发者同时设置setImageAcceptedSize（单位：px）和setExpressViewAcceptedSize（单位：dp ）接口，不同时设置可能会导致展示异常。
            .setImageAcceptedSize(UIUtils.dip2px(context,viewWidth).toInt(), UIUtils.dip2px(context,viewHeight).toInt())
            .build()
        //step4:请求广告，调用开屏广告异步请求接口，对请求回调的广告作渲染处理
        mTTAdNative.loadSplashAd(adSlot,object : TTAdNative.CSJSplashAdListener{

            override fun onSplashLoadSuccess(p0: CSJSplashAd?) {
                Log.e(TAG, "开屏广告加载成功")
            }

            override fun onSplashLoadFail(p0: CSJAdError?) {
                Log.e(TAG, p0?.msg.toString())
                channel?.invokeMethod("onFail",p0?.msg.toString())
            }

            override fun onSplashRenderSuccess(ad: CSJSplashAd?) {
                Log.e(TAG, "开屏广告渲染成功")
                if (ad == null) {
                    channel?.invokeMethod("onFail","拉去广告失败")
                    return
                }
                mSplashAd = ad
                queryEcpm()
                showSplashAd()
            }

            override fun onSplashRenderFail(p0: CSJSplashAd?, p1: CSJAdError?) {
                Log.e(TAG, p1?.msg.toString())
                channel?.invokeMethod("onFail",p1?.msg.toString())
            }

        },timeout)
    }

    private fun showSplashAd(){
        mSplashAd?.setSplashAdListener(object :CSJSplashAd.SplashAdListener{
            override fun onSplashAdShow(p0: CSJSplashAd?) {
                Log.e(TAG, "开屏广告展示")
                channel?.invokeMethod("onShow","开屏广告展示")
            }

            override fun onSplashAdClick(p0: CSJSplashAd?) {
                Log.e(TAG, "开屏广告点击")
                channel?.invokeMethod("onClick","开屏广告点击")
            }

            override fun onSplashAdClose(p0: CSJSplashAd?, closeType: Int) {
                Log.e(TAG, "开屏广告结束$closeType")
                //closeType 1跳过 2倒计时结束
                if(closeType == 1){
                    channel?.invokeMethod("onSkip","开屏广告跳过")
                }else {
                    channel?.invokeMethod("onFinish", "开屏广告倒计时结束")
                }
            }
        })
        mContainer?.removeAllViews()
        mContainer?.addView(mSplashAd?.splashView)
    }

    /**
     * 获取ecpm
     */
    private fun queryEcpm(){
        var ecpmInfo = mSplashAd?.mediationManager?.showEcpm
        if (ecpmInfo != null) {
            Log.e(
                TAG, "ecpm: \n" +
                        "SdkName: " + ecpmInfo.sdkName + ",\n" +
                        "CustomSdkName: " + ecpmInfo.customSdkName + ",\n" +
                        "SlotId: " + ecpmInfo.slotId + ",\n" +
                        // 单位：分
                        "Ecpm: " + ecpmInfo.ecpm + ",\n" +
                        "ReqBiddingType: " + ecpmInfo.reqBiddingType + ",\n" +
                        "ErrorMsg: " + ecpmInfo.errorMsg + ",\n" +
                        "RequestId: " + ecpmInfo.requestId + ",\n" +
                        "RitType: " + ecpmInfo.ritType + ",\n" +
                        "AbTestId: " + ecpmInfo.abTestId + ",\n" +
                        "ScenarioId: " + ecpmInfo.scenarioId + ",\n" +
                        "SegmentId: " + ecpmInfo.segmentId + ",\n" +
                        "Channel: " + ecpmInfo.channel + ",\n" +
                        "SubChannel: " + ecpmInfo.subChannel + ",\n" +
                        "customData: " + ecpmInfo.customData
            )
        }
    }

    override fun dispose() {
        mContainer?.removeAllViews()
        mSplashAd?.mediationManager?.destroy()
    }
}