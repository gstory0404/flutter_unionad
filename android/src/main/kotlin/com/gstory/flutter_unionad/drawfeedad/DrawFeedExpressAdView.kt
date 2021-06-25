package com.gstory.flutter_unionad.drawfeedad

import android.app.Activity
import android.content.Context
import android.util.Log
import android.view.View
import android.widget.FrameLayout
import com.bykv.vk.openvk.TTNtExpressObject
import com.bykv.vk.openvk.TTVfNative
import com.bykv.vk.openvk.VfSlot
import com.gstory.flutter_unionad.FlutterunionadViewConfig
import com.gstory.flutter_unionad.TTAdManagerHolder.get
import com.gstory.flutter_unionad.UIUtils
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.platform.PlatformView


/**
 * @Description: 个性化模板draw广告
 * @Author: gstory0404@gmail
 * @CreateDate: 2020/8/7 10:31
 */
internal class DrawFeedExpressAdView(var context: Context, var activity: Activity, messenger: BinaryMessenger?, id: Int, params: Map<String?, Any?>) : PlatformView {
    private val TAG = "DrawFeedExpressAdView"
    var mTTAdNative: TTVfNative
    private var mTTAd: TTNtExpressObject? = null
    private var mExpressContainer: FrameLayout? = null

    //广告所需参数
    private var mCodeId: String?
    var supportDeepLink: Boolean? = true
    var expressViewWidth: Float
    var expressViewHeight: Float

    private var startTime: Long = 0

    private var channel : MethodChannel?


    init {
        mCodeId = params["androidCodeId"] as String?
        supportDeepLink = params["supportDeepLink"] as Boolean?
        var width = params["expressViewWidth"] as Double
        var hight = params["expressViewHeight"] as Double
        expressViewWidth = width.toFloat()
        expressViewHeight = hight.toFloat()
        mExpressContainer = FrameLayout(activity)
        val mTTAdManager = get()
        mTTAdNative = mTTAdManager.createVfNative(context.applicationContext)
        loadBannerExpressAd()
        channel = MethodChannel(messenger, FlutterunionadViewConfig.drawFeedAdView+"_"+id)
    }

    override fun getView(): View {
        return mExpressContainer!!
    }

    private fun loadBannerExpressAd() {
        val adSlot = VfSlot.Builder()
                .setCodeId(mCodeId) //广告位id
                .setSupportDeepLink(supportDeepLink!!)
                .setAdCount(1) //请求广告数量为1到3条
                .setExpressViewAcceptedSize(expressViewWidth,expressViewHeight) //期望模板广告view的size,单位dp
                .setImageAcceptedSize(640, 320)//这个参数设置即可，不影响个性化模板广告的size
                .build()
        mTTAdNative.loadExpressDrawVf(adSlot, object : TTVfNative.NtExpressVfListener {
            override fun onError(code: Int, message: String) {
                Log.e(TAG, "load error : $code, $message")
                channel?.invokeMethod("onFail",message);
            }


            override fun onNtExpressVnLoad(ads: MutableList<TTNtExpressObject>?) {
                if (ads == null || ads.isEmpty()) {
                    return;
                }
                for (ad in ads) {
                    ad!!.setVideoListener(object : TTNtExpressObject.ExpressVideoListener {
                        override fun onVideoPaused() {
                            channel?.invokeMethod("onVideoPause","");
                        }

                        override fun onProgressUpdate(p0: Long, p1: Long) {
                        }

                        override fun onVideoComplete() {
                            channel?.invokeMethod("onVideoStop","");
                        }

                        override fun onVideoStartPlay() {
                            channel?.invokeMethod("onVideoPlay","");
                        }

                        override fun onVideoError(p0: Int, p1: Int) {
                            channel?.invokeMethod("onFail","$p0,$p1");
                        }

                        override fun onVideoContinuePlay() {
                        }

                        override fun onVideoLoad() {
                        }

                        override fun onClickRetry() {
                        }

                    })
                    //是否允许点击暂停视频播放
                    ad!!.setCanInterruptVideoPlay(true)
                    ad!!.setExpressInteractionListener(object : TTNtExpressObject.NtInteractionListener{
                        override fun onClicked(view: View, type: Int) {
                            Log.e(TAG, "广告点击")
                            channel?.invokeMethod("onClick","");
                        }

                        override fun onShow(view: View, type: Int) {
                            Log.e(TAG, "广告显示")
                            channel?.invokeMethod("onShow","");
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
                                    "\nwidthDP= ${UIUtils.dip2px(activity, width)}" +
                                    "\nheight= $height" +
                                    "\nheightDP= ${UIUtils.dip2px(activity, height)}")
                            //返回view的宽高 单位 dp
                            mExpressContainer!!.removeAllViews()
//                val mExpressContainerParams: FrameLayout.LayoutParams = FrameLayout.LayoutParams(UIUtils.dip2px(activity, width).toInt(), UIUtils.dip2px(activity, height).toInt())
//                mExpressContainer!!.layoutParams = mExpressContainerParams
                            mExpressContainer!!.addView(view)
                        }

                        override fun onDismiss() {
                            TODO("Not yet implemented")
                        }
                    })
                    ad!!.render()
                }

            }
        })
    }

    override fun dispose() {
        if (mTTAd != null) {
            mTTAd!!.destroy()
        }
    }
}