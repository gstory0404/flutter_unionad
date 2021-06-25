package com.gstory.flutter_unionad.interactionad

import android.app.Activity
import android.content.Context
import android.util.Log
import android.view.View
import com.bykv.vk.openvk.*
import com.gstory.flutter_unionad.FlutterUnionadEventPlugin
import com.gstory.flutter_unionad.TTAdManagerHolder

/**
 * @Description:
 * @Author: gstory0404@gmail
 * @CreateDate: 2020/9/18 17:43
 */
object InteractionExpressAd {
    private var TAG = "InteractionExpressAd"
    var mContext: Context? = null
    var mActivity: Activity? = null
    lateinit var mTTAdNative: TTVfNative
    private var mTTAd: TTNtExpressObject? = null

    //广告所需参数
    private var mCodeId: String? = null
    private var supportDeepLink: Boolean? = true
    private var expressViewWidth: Float = 0f
    private var expressViewHeight: Float = 0f
    private var expressNum: Integer = Integer(1)

    fun init(context: Context, mActivity: Activity, mCodeId: String?, supportDeepLink: Boolean?, expressViewWidth: Double, expressViewHeight: Double,expressNum: Integer) {
        this.mContext = context
        this.mActivity = mActivity
        this.mCodeId = mCodeId
        this.supportDeepLink = supportDeepLink
        this.expressViewWidth = expressViewWidth.toFloat()
        this.expressViewHeight = expressViewHeight.toFloat()
        this.expressNum = expressNum
        val mTTAdManager = TTAdManagerHolder.get()
        mTTAdNative = mTTAdManager.createVfNative(context.applicationContext)
        loadInteractionExpressAd()
    }

    private fun loadInteractionExpressAd() {
        //设置广告参数
        val adSlot = VfSlot.Builder()
                .setCodeId(mCodeId) //广告位id
                .setSupportDeepLink(supportDeepLink!!)
                .setAdCount(expressNum.toInt()) //请求广告数量为1到3条
                .setExpressViewAcceptedSize(expressViewWidth, expressViewHeight)//期望个性化模板广告view的size,单位dp
                .setImageAcceptedSize(640, 320) //这个参数设置即可，不影响个性化模板广告的size
                .build()
        //加载广告
        mTTAdNative.loadItExpressVi(adSlot, object : TTVfNative.NtExpressVfListener {
            override fun onError(code: Int, message: String) {
                Log.e(TAG, "load error : $code, $message")
            }

            override fun onNtExpressVnLoad(ads: List<TTNtExpressObject>) {
                if (ads == null || ads.size == 0) {
                    return
                }
                mTTAd = ads[(0..ads.size - 1).random()]
                Log.e("插屏广告拉去到的数量",ads.size.toString())
                bindAdListener(mTTAd!!)
                mTTAd!!.render() //调用render开始渲染广告
            }
        })
    }

    //绑定广告行为
    private fun bindAdListener(ad: TTNtExpressObject) {
        ad.setExpressInteractionListener(object : TTNtExpressObject.NtInteractionListener {

            override fun onDismiss() {
                Log.e(TAG, "广告关闭")
                var map: MutableMap<String, Any?> = mutableMapOf("adType" to "interactionAd","onAdMethod" to "onClose")
                FlutterUnionadEventPlugin.sendContent(map)
            }

            override fun onClicked(view: View, type: Int) {
                Log.e(TAG, "广告被点击")
                var map: MutableMap<String, Any?> = mutableMapOf("adType" to "interactionAd","onAdMethod" to "onClick")
                FlutterUnionadEventPlugin.sendContent(map)
            }

            override fun onShow(view: View, type: Int) {
                Log.e(TAG, "广告展示")
                var map: MutableMap<String, Any?> = mutableMapOf("adType" to "interactionAd","onAdMethod" to "onShow")
                FlutterUnionadEventPlugin.sendContent(map)
            }

            override fun onRenderFail(view: View, msg: String, code: Int) {
                Log.e(TAG, "render fail: $code   $msg")
                var map: MutableMap<String, Any?> = mutableMapOf("adType" to "interactionAd","onAdMethod" to "onFail", "error" to "$code , $msg")
                FlutterUnionadEventPlugin.sendContent(map)
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
        Log.e(TAG, "广告类型${ad.interactionType}   ${TTVfConstant.INTERACTION_TYPE_DOWNLOAD}")
        if (ad.interactionType != TTVfConstant.INTERACTION_TYPE_DOWNLOAD) {
            return
        }
        //可选，下载监听设置
//        ad.setDownloadListener(object : TTAppDownloadListener {
//            override fun onIdle() {
//                Log.e(TAG, "点击开始下载")
//            }
//
//            override fun onDownloadActive(totalBytes: Long, currBytes: Long, fileName: String, appName: String) {
//                Log.e(TAG, "下载中，点击暂停")
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
    private fun bindDislike(ad: TTNtExpressObject, customStyle: Boolean) {
        //使用默认个性化模板中默认dislike弹出样式
        ad.setDislikeCallback(mActivity, object : TTVfDislike.DislikeInteractionCallback {
            
            override fun onSelected(p0: Int, p1: String?, p2: Boolean) {
                Log.e(TAG, "点击 $p1")
                //用户选择不喜欢原因后，移除广告展示
                var map: MutableMap<String, Any?> = mutableMapOf("adType" to "interactionAd","onDislike" to "onShow","message" to p1)
                FlutterUnionadEventPlugin.sendContent(map)
            }

            override fun onCancel() {
                Log.e(TAG, "点击取消")
            }

            override fun onShow() {

            }

        })
    }

}