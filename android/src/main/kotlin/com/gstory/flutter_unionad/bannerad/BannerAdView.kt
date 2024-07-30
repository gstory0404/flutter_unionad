package com.gstory.flutter_unionad.bannerad

import android.app.Activity
import android.content.Context
import android.util.Log
import android.view.View
import android.widget.FrameLayout
import android.widget.TextView
import com.bytedance.sdk.openadsdk.*
import com.bytedance.sdk.openadsdk.TTAdNative.NativeExpressAdListener
import com.bytedance.sdk.openadsdk.TTNativeExpressAd.ExpressAdInteractionListener
import com.bytedance.sdk.openadsdk.mediation.ad.IMediationNativeAdInfo
import com.bytedance.sdk.openadsdk.mediation.ad.MediationAdSlot
import com.bytedance.sdk.openadsdk.mediation.ad.MediationNativeToBannerListener
import com.gstory.flutter_unionad.FlutterunionadViewConfig
import com.gstory.flutter_unionad.TTAdManagerHolder
import com.gstory.flutter_unionad.TTAdManagerHolder.get
import com.gstory.flutter_unionad.UIUtils
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.platform.PlatformView
import java.util.logging.Logger


/**
 * @Description: 个性化模板Banner广告
 * @Author: gstory0404@gmailh
 * @CreateDate: 2020/8/7 10:31
 */
internal class BannerAdView(
    var context: Context,
    var activity: Activity,
    messenger: BinaryMessenger,
    id: Int,
    params: Map<String?, Any?>
) : PlatformView {
    private val TAG = "BannerAdView"

    private var mBannerAd: TTNativeExpressAd? = null
    private var mContainer: FrameLayout

    //广告所需参数
    private var mCodeId: String?
    var viewWidth: Float
    var viewHeight: Float
    private var channel: MethodChannel?


    init {
        mCodeId = params["androidCodeId"] as String?
        var width = params["width"] as Double
        var height = params["height"] as Double
        viewWidth = width.toFloat()
        viewHeight = height.toFloat()
        mContainer = FrameLayout(activity)
        channel = MethodChannel(messenger, FlutterunionadViewConfig.bannerAdView + "_" + id)
        loadBannerAd()
    }

    override fun getView(): View {
        return mContainer
    }

    /**
     * 加载广告
     */
    private fun loadBannerAd() {
        val adSlot = AdSlot.Builder()
            .setCodeId(mCodeId) //广告位id
            .setUserID("")
            .setImageAcceptedSize(
                UIUtils.dip2px(context, viewWidth).toInt(),
                UIUtils.dip2px(context, viewHeight).toInt()
            )
            .setMediationAdSlot(
                MediationAdSlot.Builder()
                    .setMediationNativeToBannerListener(object : MediationNativeToBannerListener() {
                        // Banner混出自渲染信息流时使用，将信息流素材渲染成View返回
//                        override fun getMediationBannerViewFromNativeAd(p0: IMediationNativeAdInfo?): View? {
//                            return super.getMediationBannerViewFromNativeAd(p0)
//                        }
                    })
                    .build()
            )
            .build()
        val mTTAdNative = TTAdSdk.getAdManager().createAdNative(activity)
        mTTAdNative.loadBannerExpressAd(adSlot, object : NativeExpressAdListener {
            override fun onError(code: Int, message: String) {
                Log.e(TAG, "广告拉取失败 $code $message")
                mContainer.removeAllViews()
                channel?.invokeMethod("onFail", message)
            }

            override fun onNativeExpressAdLoad(ads: List<TTNativeExpressAd>) {
                if (ads.isEmpty()) {
                    channel?.invokeMethod("onFail", "ads is empty")
                    return
                }
                Log.e(TAG, "广告拉取成功 ${ads.size}")
                mBannerAd = ads[0]
                queryEcpm()
                showBannerAd()
            }
        })
    }

    /**
     * 广告加载成功后，设置监听器，展示广告
     */
    var bannerAdView: View? = null
    private fun showBannerAd() {
        //广告事件
        // TODO暂时有问题 设置setExpressInteractionListener onAdShow后会出现异常广告view为空
        bindAdListener()
        //dislike设置
        bindDislike()
        mContainer.removeAllViews()
        bannerAdView = mBannerAd?.expressAdView
        if (bannerAdView != null) mBannerAd?.render()
        mContainer.addView(bannerAdView)
    }

    private fun bindAdListener() {
        mBannerAd?.setExpressInteractionListener(object : TTNativeExpressAd.AdInteractionListener {
            override fun onAdClicked(p0: View?, p1: Int) {
                Log.e(TAG, "广告点击")
                channel?.invokeMethod("onClick", "")
            }

            override fun onAdShow(p0: View?, p1: Int) {
                Log.e(TAG, "广告显示${bannerAdView?.measuredWidth} = ${bannerAdView?.measuredHeight}")
                var width = bannerAdView?.measuredWidth?.toFloat()
                    ?.let { UIUtils.px2dip(context, it) } ?: viewWidth
                var height = bannerAdView?.measuredHeight?.toFloat()
                    ?.let { UIUtils.px2dip(context, it) } ?: viewHeight
                var map: MutableMap<String, Any?> =
                    mutableMapOf("width" to width, "height" to height)
                channel?.invokeMethod("onShow", map)
            }

            override fun onRenderFail(view: View, msg: String, code: Int) {
                Log.e(TAG, "render fail: $code   $msg")
                channel?.invokeMethod("onFail", msg)
            }

            override fun onRenderSuccess(p0: View?, p1: Float, p2: Float) {
                Log.e(TAG, "渲染成功 ${bannerAdView?.width} = ${bannerAdView?.height}")
            }

            override fun onAdDismiss() {
                Log.e(TAG, "关闭")
            }

        })
//        mBannerAd?.setExpressInteractionListener(object : ExpressAdInteractionListener {
//            override fun onAdClicked(view: View, type: Int) {
//                Log.e(TAG, "广告点击")
//                channel?.invokeMethod("onClick", "")
//            }
//
//            override fun onAdShow(view: View, type: Int) {
//                Log.e(TAG, "广告显示")
//                var map: MutableMap<String, Any?> =
//                    mutableMapOf("width" to viewWidth, "height" to viewHeight)
//                channel?.invokeMethod("onShow", map)
//            }
//
//            override fun onRenderFail(view: View, msg: String, code: Int) {
//                Log.e(TAG, "render fail: $code   $msg")
//                channel?.invokeMethod("onFail", msg)
//            }
//
//            override fun onRenderSuccess(view: View, width: Float, height: Float) {
//                Log.e(TAG, "渲染成功")
//            }
//        })
    }

    /**
     * 设置广告的不喜欢，开发者可自定义样式
     * @param ad
     */
    private fun bindDislike() {
        //使用默认个性化模板中默认dislike弹出样式
        mBannerAd?.setDislikeCallback(activity, object : TTAdDislike.DislikeInteractionCallback {

            override fun onSelected(p0: Int, p1: String?, p2: Boolean) {
                Log.e(TAG, "点击 $p1")
                //用户选择不喜欢原因后，移除广告展示
                mContainer.removeAllViews()
                channel?.invokeMethod("onDislike", p1)
            }

            override fun onCancel() {
                Log.e(TAG, "点击取消")
            }

            override fun onShow() {
                Log.e(TAG, "显示dislike弹窗")
            }
        })
    }

    /**
     * 获取ecpm
     */
    private fun queryEcpm() {
        val ecpmInfo = mBannerAd?.mediationManager?.showEcpm
        if (ecpmInfo != null) {
            Log.e(
                TAG, "信息流广告 ecpm: \n" +
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
        Log.e(TAG, "广告释放")
        mBannerAd?.destroy()
    }
}