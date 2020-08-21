package com.gstory.flutter_unionad.interactionexpressad

import android.app.Activity
import android.app.Dialog
import android.content.Context
import android.os.Bundle
import android.util.Log
import android.view.ActionMode
import android.view.Gravity
import android.view.View
import android.view.WindowManager
import android.widget.FrameLayout
import android.widget.ImageView
import android.widget.TextView
import com.bytedance.sdk.openadsdk.*
import com.gstory.flutter_unionad.R
import com.gstory.flutter_unionad.TTAdManagerHolder
import com.gstory.flutter_unionad.UIUtils

/**
 * @Description:
 * @Author: gstory0404@gmail
 * @CreateDate: 2020/8/21 15:48
 */
class InteractionExpressAdDialog : Dialog {
    private var TAG = "InteractionExpressAdDialog"
    var mContext: Context
    var mActivity: Activity
    private var mExpressContainer: FrameLayout? = null
    lateinit var mTTAdNative: TTAdNative
    private var mTTAd: TTNativeExpressAd? = null

    //广告所需参数
    private var mCodeId: String? = null
    private var supportDeepLink: Boolean? = true
    private var expressViewWidth: Float = 0f
    private var expressViewHeight: Float = 0f


    constructor(context: Context, themeResId: Int, mActivity: Activity, mCodeId: String?, supportDeepLink: Boolean?, expressViewWidth: Double, expressViewHeight: Double) : super(context, themeResId) {
        this.mContext = context
        this.mActivity = mActivity
        this.mCodeId = mCodeId
        this.supportDeepLink = supportDeepLink
        this.expressViewWidth = expressViewWidth.toFloat()
        this.expressViewHeight = expressViewHeight.toFloat()
    }


    override fun onStart() {
        super.onStart()
        window.addFlags(WindowManager.LayoutParams.FLAG_FULLSCREEN)
        window.decorView.systemUiVisibility = (View.SYSTEM_UI_FLAG_LAYOUT_STABLE or View.SYSTEM_UI_FLAG_LAYOUT_HIDE_NAVIGATION
                or View.SYSTEM_UI_FLAG_LAYOUT_FULLSCREEN or View.SYSTEM_UI_FLAG_HIDE_NAVIGATION
                or View.SYSTEM_UI_FLAG_FULLSCREEN or View.SYSTEM_UI_FLAG_IMMERSIVE_STICKY)

    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        var dialogWindow = window
        dialogWindow.setGravity(Gravity.CENTER)
        setContentView(R.layout.dialog_interactionexpressad)
        mExpressContainer = findViewById(R.id.native_insert_ad_img)
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
                .setExpressViewAcceptedSize(UIUtils.px2dip(context, expressViewWidth), UIUtils.px2dip(context, expressViewHeight))//期望个性化模板广告view的size,单位dp
                .setImageAcceptedSize(640, 320) //这个参数设置即可，不影响个性化模板广告的size
                .build()
        //加载广告
        mTTAdNative.loadInteractionExpressAd(adSlot, object : TTAdNative.NativeExpressAdListener {
            override fun onError(code: Int, message: String) {
                Log.e(TAG, "load error : $code, $message")
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
                mExpressContainer!!.removeAllViews()
//                val mExpressContainerParams: FrameLayout.LayoutParams = FrameLayout.LayoutParams(UIUtils.dip2px(context, width).toInt(), UIUtils.dip2px(context, height).toInt())
//                mExpressContainerParams.gravity = Gravity.CENTER
//                mExpressContainer!!.layoutParams = mExpressContainerParams
                mExpressContainer!!.addView(view)
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
                mExpressContainer!!.removeAllViews()
            }

            override fun onCancel() {
                Log.e(TAG, "点击取消")
            }

            override fun onRefuse() {

            }
        })
    }

}