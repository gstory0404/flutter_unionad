package com.gstory.flutter_unionad.splashad

import android.content.Context
import android.util.Log
import android.view.View
import android.widget.FrameLayout
import androidx.annotation.MainThread
import com.bytedance.sdk.openadsdk.*
import com.bytedance.sdk.openadsdk.TTAdNative.SplashAdListener
import com.gstory.flutter_unionad.TTAdManagerHolder
import com.gstory.flutter_unionad.UIUtils
import com.gstory.flutter_unionad.FlutterunionadViewConfig
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.platform.PlatformView


/**
 * @Description: 开屏广告
 * @Author: gstory0404@gmail
 * @CreateDate: 2020/8/19 10:34
 */
internal class SplashAdView(var context: Context, var messenger: BinaryMessenger, id: Int, params: Map<String?, Any?>) : PlatformView {
    private val TAG = "SplashAdView"
    private var mExpressContainer: FrameLayout? = null
    var mTTAdNative: TTAdNative

    //广告所需参数
    private val mCodeId: String?
    private var supportDeepLink: Boolean? = true
    private var expressViewWidth: Float
    private var expressViewHeight: Float
    private var mIsExpress: Boolean? = true
    private var downloadType : Int = 1
    private var adLoadType : Int = 0
    private var timeout : Int = 3000

    private var channel : MethodChannel?

    init {
        mCodeId = params["androidCodeId"] as String?
        supportDeepLink = params["supportDeepLink"] as Boolean?
        var width = params["expressViewWidth"] as Double
        var hight = params["expressViewHeight"] as Double
        downloadType = params["downloadType"] as Int
        adLoadType = params["adLoadType"] as Int
        timeout = params["timeout"] as Int
        if (width == 0.0) {
            expressViewWidth = UIUtils.getScreenWidthDp(context)
        } else {
            expressViewWidth = width.toFloat()
        }
        if (hight == 0.0) {
            expressViewHeight = UIUtils.px2dip(context, UIUtils.getRealHeight(context).toFloat())
        } else {
            expressViewHeight = hight.toFloat()
        }
        mIsExpress = params["mIsExpress"] as Boolean
        mExpressContainer = FrameLayout(context)
        val mTTAdManager = TTAdManagerHolder.get()
        mTTAdNative = mTTAdManager.createAdNative(context.applicationContext)
        channel = MethodChannel(messenger, FlutterunionadViewConfig.splashAdView+"_"+id)
        loadSplashAd()
    }

    override fun getView(): View {
        return mExpressContainer!!
    }

    /**
     * 加载开屏广告
     */
    private fun loadSplashAd() {
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
        var adSlot = AdSlot.Builder()
            .setCodeId(mCodeId)
            .setSupportDeepLink(supportDeepLink!!)
            //不区分渲染方式，要求开发者同时设置setImageAcceptedSize（单位：px）和setExpressViewAcceptedSize（单位：dp ）接口，不同时设置可能会导致展示异常。
            .setImageAcceptedSize(UIUtils.dip2px(context,expressViewWidth).toInt(),
                UIUtils.dip2px(context,expressViewHeight).toInt()
            )
            .setExpressViewAcceptedSize(expressViewWidth, expressViewHeight)
//                    .setDownloadType(downloadType)
            .setAdLoadType(loadType)
            .build()
        //step4:请求广告，调用开屏广告异步请求接口，对请求回调的广告作渲染处理
        mTTAdNative.loadSplashAd(adSlot,object : TTAdNative.CSJSplashAdListener{
            override fun onSplashLoadSuccess() {
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
                //获取SplashView
                val view = ad.splashView
                if (view != null && mExpressContainer != null) {
                    //把SplashView 添加到ViewGroup中,注意开屏广告view：width >=70%屏幕宽；height >=50%屏幕高
                    mExpressContainer!!.removeAllViews()
                    mExpressContainer!!.addView(view)
                }
                ad.setSplashAdListener(object :CSJSplashAd.SplashAdListener{
                    override fun onSplashAdShow(p0: CSJSplashAd?) {
                        Log.e(TAG, "开屏广告展示")
                        channel?.invokeMethod("onShow","开屏广告展示")
                    }

                    override fun onSplashAdClick(p0: CSJSplashAd?) {
                        Log.e(TAG, "开屏广告点击")
                        channel?.invokeMethod("onClick","开屏广告点击")
//                        channel?.invokeMethod("onFinish", "开屏广告点击关闭")
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
            }

            override fun onSplashRenderFail(p0: CSJSplashAd?, p1: CSJAdError?) {
                Log.e(TAG, p1?.msg.toString())
                channel?.invokeMethod("onFail",p1?.msg.toString())
            }

        },timeout)
    }

    override fun dispose() {
        mExpressContainer?.removeAllViews()
    }
}