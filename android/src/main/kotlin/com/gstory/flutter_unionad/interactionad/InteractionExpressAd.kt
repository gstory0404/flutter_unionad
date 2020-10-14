package com.gstory.flutter_unionad.interactionad

import android.app.Activity
import android.content.Context
import android.util.Log
import android.view.View
import com.bytedance.sdk.openadsdk.*
import com.gstory.flutter_unionad.TTAdManagerHolder
import com.gstory.flutter_unionad.UIUtils

/**
 * @Description:
 * @Author: gstory0404@gmail
 * @CreateDate: 2020/9/18 17:43
 */
object InteractionExpressAd {
    private var TAG = "InteractionExpressAd"
    var mContext: Context? = null
    var mActivity: Activity? = null
    lateinit var mTTAdNative: TTAdNative
    private var mTTAd: TTNativeExpressAd? = null

    //广告所需参数
    private var mCodeId: String? = null
    private var supportDeepLink: Boolean? = true
    private var expressViewWidth: Float = 0f
    private var expressViewHeight: Float = 0f

    fun init(context: Context, mActivity: Activity, mCodeId: String?, supportDeepLink: Boolean?, expressViewWidth: Double, expressViewHeight: Double){
        this.mContext = context
        this.mActivity = mActivity
        this.mCodeId = mCodeId
        this.supportDeepLink = supportDeepLink
        this.expressViewWidth = expressViewWidth.toFloat()
        this.expressViewHeight = expressViewHeight.toFloat()
        val mTTAdManager = TTAdManagerHolder.get()
        mTTAdNative = mTTAdManager.createAdNative(context.applicationContext)
        loadInteractionExpressAd()
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
        mTTAdNative.loadInteractionExpressAd(adSlot, object : TTAdNative.NativeExpressAdListener {
            override fun onError(code: Int, message: String) {
                Log.e(TAG, "load error : $code, $message")
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
                Log.e(TAG, "广告关闭")
            }

            override fun onAdClicked(view: View, type: Int) {
                Log.e(TAG, "广告被点击")
            }

            override fun onAdShow(view: View, type: Int) {
                Log.e(TAG, "广告展示")
            }

            override fun onRenderFail(view: View, msg: String, code: Int) {
                Log.e(TAG, "render fail: $code   $msg")
            }

            override fun onRenderSuccess(view: View, width: Float, height: Float) {
                //返回view的宽高 单位 dp
                Log.e(TAG, "渲染成功")
                //在渲染成功回调时展示广告，提升体验
                mTTAd!!.showInteractionExpressAd(mActivity)
            }
        })
        //dislike设置
        bindDislike(ad, false)
        Log.e(TAG,"广告类型${ad.interactionType}   ${TTAdConstant.INTERACTION_TYPE_DOWNLOAD}")
        if (ad.interactionType != TTAdConstant.INTERACTION_TYPE_DOWNLOAD) {
            return
        }
        //可选，下载监听设置
        ad.setDownloadListener(object : TTAppDownloadListener {
            override fun onIdle() {
                Log.e(TAG, "点击开始下载")
            }

            override fun onDownloadActive(totalBytes: Long, currBytes: Long, fileName: String, appName: String) {
                Log.e(TAG, "下载中，点击暂停")
            }

            override fun onDownloadPaused(totalBytes: Long, currBytes: Long, fileName: String, appName: String) {
                Log.e(TAG, "下载暂停，点击继续")
            }

            override fun onDownloadFailed(totalBytes: Long, currBytes: Long, fileName: String, appName: String) {
                Log.e(TAG, "下载失败，点击重新下载")
            }

            override fun onInstalled(fileName: String, appName: String) {
                Log.e(TAG, "安装完成，点击图片打开")
            }

            override fun onDownloadFinished(totalBytes: Long, fileName: String, appName: String) {
                Log.e(TAG, "点击安装")
            }
        })
    }

    /**
     * 设置广告的不喜欢，开发者可自定义样式
     * @param ad
     * @param customStyle 是否自定义样式，true:样式自定义
     */
    private fun bindDislike(ad: TTNativeExpressAd, customStyle: Boolean) {
        //使用默认个性化模板中默认dislike弹出样式
        ad.setDislikeCallback(mActivity, object : TTAdDislike.DislikeInteractionCallback {
            override fun onSelected(position: Int, value: String) {
                Log.e(TAG, "点击 $value")
                //用户选择不喜欢原因后，移除广告展示
            }

            override fun onCancel() {
                Log.e(TAG, "点击取消")
            }

            override fun onRefuse() {

            }
        })
    }

}