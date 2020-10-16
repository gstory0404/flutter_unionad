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
import com.gstory.flutter_unionad.FlutterUnionadEventPlugin
import com.gstory.flutter_unionad.FlutterunionadViewConfig
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.platform.PlatformView


/**
 * @Description: 开屏广告
 * @Author: gstory0404@gmail
 * @CreateDate: 2020/8/19 10:34
 */
internal class SplashAdView(var context: Context, var messenger: BinaryMessenger?, id: Int, params: Map<String?, Any?>) : PlatformView {
    private val TAG = "AdBannerView"
    private var mExpressContainer: FrameLayout? = null
    var mTTAdNative: TTAdNative

    //广告所需参数
    private val mCodeId: String?
    var supportDeepLink: Boolean? = true
    var expressViewWidth: Float
    var expressViewHeight: Float
    var mIsExpress: Boolean? = true

    //开屏广告加载超时时间,建议大于3000,这里为了冷启动第一次加载到广告并且展示,示例设置了3000ms
    private val AD_TIME_OUT = 3000

    private var channel : MethodChannel?

    init {
        mCodeId = params["androidCodeId"] as String?
        supportDeepLink = params["supportDeepLink"] as Boolean?
        var width = params["expressViewWidth"] as Double
        var hight = params["expressViewHeight"] as Double
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
        var adSlot = if (mIsExpress!!) {
            AdSlot.Builder()
                    .setCodeId(mCodeId)
                    .setSupportDeepLink(supportDeepLink!!)
                    .setImageAcceptedSize(1080, 1920) //模板广告需要设置期望个性化模板广告的大小,单位dp,代码位是否属于个性化模板广告，请在穿山甲平台查看
                    .setExpressViewAcceptedSize(expressViewWidth, expressViewHeight)
                    .build()
        } else {
            AdSlot.Builder()
                    .setCodeId(mCodeId)
                    .setSupportDeepLink(supportDeepLink!!)
                    .setImageAcceptedSize(1080, 1920)
                    .build()
        }
        //step4:请求广告，调用开屏广告异步请求接口，对请求回调的广告作渲染处理
        mTTAdNative.loadSplashAd(adSlot, object : SplashAdListener {
            @MainThread
            override fun onError(code: Int, message: String) {
                Log.e(TAG, message)
                channel?.invokeMethod("onFail",message)
            }

            @MainThread
            override fun onTimeout() {
                Log.e(TAG, "开屏广告加载超时")
                channel?.invokeMethod("onAplashTimeout","")
            }

            @MainThread
            override fun onSplashAdLoad(ad: TTSplashAd) {
                Log.e(TAG, "开屏广告请求成功")
                if (ad == null) {
                    channel?.invokeMethod("onFail","拉去广告失败")
                    return
                }
                //获取SplashView
                val view = ad.splashView
                if (view != null && mExpressContainer != null) {
                    //把SplashView 添加到ViewGroup中,注意开屏广告view：width >=70%屏幕宽；height >=50%屏幕高
                    mExpressContainer!!.removeAllViews()
//                    val mExpressContainerParams: FrameLayout.LayoutParams = FrameLayout.LayoutParams(UIUtils.dip2px(context, expressViewWidth).toInt(),
//                            UIUtils.dip2px(context, expressViewHeight).toInt())
//                    mExpressContainer!!.layoutParams = mExpressContainerParams
                    mExpressContainer!!.addView(view)
                    //设置不开启开屏广告倒计时功能以及不显示跳过按钮,如果这么设置，您需要自定义倒计时逻辑
                    //ad.setNotAllowSdkCountdown();
                } else {

                }

                //设置SplashView的交互监听器
                ad.setSplashInteractionListener(object : TTSplashAd.AdInteractionListener {
                    override fun onAdClicked(view: View, type: Int) {
                        Log.e(TAG, "onAdClicked开屏广告点击")
                        channel?.invokeMethod("onAplashClick","开屏广告点击")
                    }

                    override fun onAdShow(view: View, type: Int) {
                        Log.e(TAG, "onAdShow开屏广告展示")
                        channel?.invokeMethod("onShow","开屏广告展示")
                    }

                    override fun onAdSkip() {
                        Log.e(TAG, "onAdSkip开屏广告跳过")
                        channel?.invokeMethod("onAplashSkip","开屏广告跳过")
                    }

                    override fun onAdTimeOver() {
                        Log.e(TAG, "onAdTimeOver开屏广告倒计时结束")
                        channel?.invokeMethod("onAplashFinish","开屏广告倒计时结束")
                    }
                })
//                if (ad.interactionType == TTAdConstant.INTERACTION_TYPE_DOWNLOAD) {
//                    ad.setDownloadListener(object : TTAppDownloadListener {
//                        var hasShow = false
//                        override fun onIdle() {}
//                        override fun onDownloadActive(totalBytes: Long, currBytes: Long, fileName: String, appName: String) {
//                            if (!hasShow) {
//                                Log.e(TAG, "下载中...")
//                                hasShow = true
//                            }
//                        }
//
//                        override fun onDownloadPaused(totalBytes: Long, currBytes: Long, fileName: String, appName: String) {
//                            Log.e(TAG, "下载暂停...")
//                        }
//
//                        override fun onDownloadFailed(totalBytes: Long, currBytes: Long, fileName: String, appName: String) {
//                            Log.e(TAG, "下载失败...")
//                        }
//
//                        override fun onDownloadFinished(totalBytes: Long, fileName: String, appName: String) {
//                            Log.e(TAG, "下载完成...")
//                        }
//
//                        override fun onInstalled(fileName: String, appName: String) {
//                            Log.e(TAG, "安装完成...")
//                        }
//                    })
//                }
            }
        }, AD_TIME_OUT)
    }

    override fun dispose() {

    }
}