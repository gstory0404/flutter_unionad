package com.gstory.flutter_unionad.interactionad

import android.app.Activity
import android.content.Context
import android.util.Log
import android.view.Gravity
import android.view.View
import android.widget.FrameLayout
import com.bytedance.sdk.openadsdk.*
import com.bytedance.sdk.openadsdk.TTAdNative.NativeExpressAdListener
import com.gstory.flutter_unionad.TTAdManagerHolder
import com.gstory.flutter_unionad.UIUtils
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.platform.PlatformView


/**
 * @Description:  个性化模板插屏广告
 * @Author: gstory0404@gmail
 * @CreateDate: 2020/8/20 17:57
 */
class InteractionExpressAdView(var context: Context, var activity: Activity, messenger: BinaryMessenger?, id: Int, params: Map<String?, Any?>) : PlatformView {
    private val TAG = "InteractionExpressAd"
    var mTTAdNative: TTAdNative
    private var mTTAd: TTNativeExpressAd? = null
    private var mExpressContainer : FrameLayout? = null
    //广告所需参数
    private val mCodeId: String?
    var supportDeepLink: Boolean? = true
    var expressViewWidth: Float
    var expressViewHeight: Float
    var mHasShowDownloadActive :Boolean? = false

    init {
        mCodeId = params["androidCodeId"] as String?
        supportDeepLink = params["supportDeepLink"] as Boolean?
        var width = params["expressViewWidth"] as Double
        var hight = params["expressViewHeight"] as Double
        Log.e("banner参数","${params["bannerViewWidth"]} ===== ${params["bannersViewHeight"]}")
        expressViewWidth = width.toFloat()
        expressViewHeight = hight.toFloat()
        mExpressContainer = FrameLayout(activity)
        val mTTAdManager = TTAdManagerHolder.get()
        mTTAdNative = mTTAdManager.createAdNative(context.applicationContext)
        loadInteractionExpressAd()
    }

    override fun getView(): View {
        return mExpressContainer!!
    }

    private fun loadInteractionExpressAd() {
        //设置广告参数
        val adSlot = AdSlot.Builder()
                .setCodeId(mCodeId) //广告位id
                .setSupportDeepLink(supportDeepLink!!)
                .setAdCount(1) //请求广告数量为1到3条
                .setExpressViewAcceptedSize(expressViewWidth, expressViewHeight)//期望个性化模板广告view的size,单位dp
                .setImageAcceptedSize(640, 320) //这个参数设置即可，不影响个性化模板广告的size
                .build()
        //加载广告
        mTTAdNative.loadInteractionExpressAd(adSlot, object : NativeExpressAdListener {
            override fun onError(code: Int, message: String) {
                Log.e(TAG,"load error : $code, $message")
                mExpressContainer!!.removeAllViews()
            }

            override fun onNativeExpressAdLoad(ads: List<TTNativeExpressAd>) {
                if (ads == null || ads.size == 0) {
                    return
                }
                mTTAd = ads[0]
                bindAdListener(mTTAd!!)
                mTTAd!!.render() //调用render开始渲染广告
            }
        })
    }

    //绑定广告行为
    private fun bindAdListener(ad: TTNativeExpressAd) {
        ad.setExpressInteractionListener(object : TTNativeExpressAd.AdInteractionListener {
            override fun onAdDismiss() {
                Log.e(TAG,"广告关闭")
            }

            override fun onAdClicked(view: View, type: Int) {
                Log.e(TAG,"广告被点击")
            }

            override fun onAdShow(view: View, type: Int) {
                Log.e(TAG,"广告展示")
            }

            override fun onRenderFail(view: View, msg: String, code: Int) {
                Log.e(TAG,"render fail: $code   $msg")
            }

            override fun onRenderSuccess(view: View, width: Float, height: Float) {
                //返回view的宽高 单位 dp
                Log.e(TAG,"渲染成功")
                //在渲染成功回调时展示广告，提升体验
                mExpressContainer!!.removeAllViews()
                val mExpressContainerParams: FrameLayout.LayoutParams = FrameLayout.LayoutParams(UIUtils.dip2px(activity, width).toInt(), UIUtils.dip2px(activity, height).toInt())
                mExpressContainerParams.gravity = Gravity.CENTER
                mExpressContainer!!.layoutParams = mExpressContainerParams
                mExpressContainer!!.addView(view)
            }
        })
//        if (ad.interactionType != TTAdConstant.INTERACTION_TYPE_DOWNLOAD) {
//            return
//        }
//        //可选，下载监听设置
//        ad.setDownloadListener(object : TTAppDownloadListener {
//            override fun onIdle() {
//                Log.e(TAG,"点击开始下载")
//            }
//
//            override fun onDownloadActive(totalBytes: Long, currBytes: Long, fileName: String, appName: String) {
//                if (!mHasShowDownloadActive!!) {
//                    mHasShowDownloadActive = true
//                    Log.e(TAG,"下载中，点击暂停")
//                }
//            }
//
//            override fun onDownloadPaused(totalBytes: Long, currBytes: Long, fileName: String, appName: String) {
//                Log.e(TAG,"下载暂停，点击继续")
//            }
//
//            override fun onDownloadFailed(totalBytes: Long, currBytes: Long, fileName: String, appName: String) {
//                Log.e(TAG,"下载失败，点击重新下载")
//            }
//
//            override fun onInstalled(fileName: String, appName: String) {
//                Log.e(TAG,"安装完成，点击图片打开")
//            }
//
//            override fun onDownloadFinished(totalBytes: Long, fileName: String, appName: String) {
//                Log.e(TAG,"点击安装")
//            }
//        })
    }

    override fun dispose() {
        if (mTTAd != null) {
            mTTAd!!.destroy()
        }
    }
}