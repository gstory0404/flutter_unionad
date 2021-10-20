package com.gstory.flutter_unionad

import android.app.Activity
import android.content.Context
import android.text.TextUtils
import android.util.Log
import androidx.annotation.NonNull
import com.bytedance.sdk.openadsdk.TTAdSdk
import com.gstory.flutter_unionad.fullscreenvideoAd.FullScreenVideoExpressAd
import com.gstory.flutter_unionad.fullscreenvideoadinteraction.FullScreenVideoAdInteraction
import com.gstory.flutter_unionad.interactionad.InteractionExpressAd
import com.gstory.flutter_unionad.rewardvideoad.RewardVideoAd
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry.Registrar


/** FlutterUnionadPlugin */
public class FlutterUnionadPlugin : FlutterPlugin, MethodCallHandler, ActivityAware {

    private lateinit var channel: MethodChannel
    private var applicationContext: Context? = null
    private var mActivity: Activity? = null
    private var mFlutterPluginBinding: FlutterPlugin.FlutterPluginBinding? = null

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        mActivity = binding.activity
        Log.e("FlutterUnionadPlugin->", "onAttachedToActivity")
        FlutterUnionadViewPlugin.registerWith(mFlutterPluginBinding!!, mActivity!!)
    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
        mActivity = binding.activity
        Log.e("FlutterUnionadPlugin->", "onReattachedToActivityForConfigChanges")
    }

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        Log.e("FlutterUnionadPlugin->", "onAttachedToEngine")
        channel =
            MethodChannel(flutterPluginBinding.getFlutterEngine().getDartExecutor(), channelName)
        channel.setMethodCallHandler(this)
        applicationContext = flutterPluginBinding.applicationContext
        mFlutterPluginBinding = flutterPluginBinding
        FlutterUnionadEventPlugin().onAttachedToEngine(flutterPluginBinding)
//        FlutterUnionadViewPlugin.registerWith(flutterPluginBinding,mActivity!!)
    }

    override fun onDetachedFromActivityForConfigChanges() {
        mActivity = null
        Log.e("FlutterUnionadPlugin->", "onDetachedFromActivityForConfigChanges")
    }

    override fun onDetachedFromActivity() {
        mActivity = null
        Log.e("FlutterUnionadPlugin->", "onDetachedFromActivity")
    }


    companion object {
        private var channelName = "flutter_unionad"

        @JvmStatic
        fun registerWith(registrar: Registrar) {
            val channel = MethodChannel(registrar.messenger(), channelName)
            channel.setMethodCallHandler(FlutterUnionadPlugin())
        }
    }

    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
        //注册初始化
        if (call.method == "register") {
            val appId = call.argument<String>("androidAppId")
            val useTextureView = call.argument<Boolean>("useTextureView")
            val appName = call.argument<String>("appName")
            var allowShowNotify = call.argument<Boolean>("allowShowNotify")
            var allowShowPageWhenScreenLock = call.argument<Boolean>("allowShowPageWhenScreenLock")
            var debug = call.argument<Boolean>("debug")
            var supportMultiProcess = call.argument<Boolean>("supportMultiProcess")
            val directDownloadNetworkType = call.argument<List<Int>>("directDownloadNetworkType")!!
            if (appId == null || appId.trim { it <= ' ' }.isEmpty()) {
                Log.e("初始化", "appId can't be null")
                result.success(false)
            } else {
                if (appName == null || appName.trim { it <= ' ' }.isEmpty()) {
                    Log.e("初始化", "appName can't be null")
                    result.success(false)
                } else {
                    TTAdManagerHolder.init(applicationContext!!,
                        appId,
                        useTextureView!!,
                        appName,
                        allowShowNotify!!,
                        allowShowPageWhenScreenLock!!,
                        debug!!,
                        supportMultiProcess!!,
                        directDownloadNetworkType,
                        object : TTAdSdk.InitCallback {
                            override fun success() {
                                Log.e("初始化", "成功")
                                mActivity!!.runOnUiThread(Runnable {
                                    result.success(true)
                                })
                            }

                            override fun fail(p0: Int, p1: String?) {
                                Log.e("初始化", "失败 $p0  $p1")
                                mActivity!!.runOnUiThread(Runnable {
                                    result.success(false)
                                })
                            }
                        }
                    )
                }
            }
            //隐私信息控制开关
        } else if (call.method == "andridPrivacy") {
            var arguments = call.arguments as Map<String?, Any?>
            val isCanUseLocation = call.argument<Boolean>("isCanUseLocation")
            val lat = call.argument<Double>("lat")
            val lon = call.argument<Double>("lon")
            val isCanUsePhoneState = call.argument<Boolean>("isCanUsePhoneState")
            val imei = call.argument<String>("imei")
            val isCanUseWifiState = call.argument<Boolean>("isCanUseWifiState")
            val isCanUseWriteExternal = call.argument<Boolean>("isCanUseWriteExternal")
            val oaid = call.argument<String>("oaid")
            TTAdManagerHolder.privacyConfig(
                isCanUseLocation!!,
                lat!!,
                lon!!,
                isCanUsePhoneState!!,
                imei!!,
                isCanUseWifiState!!,
                isCanUseWriteExternal!!,
                oaid!!
            )
            //请求权限
        } else if (call.method == "requestPermissionIfNecessary") {
            val mTTAdManager = TTAdManagerHolder.get()
            mTTAdManager.requestPermissionIfNecessary(applicationContext)
            result.success(3)
            //获取sdk版本号
        } else if (call.method == "getSDKVersion") {
            var viersion = TTAdManagerHolder.get().sdkVersion
            if (TextUtils.isEmpty(viersion)) {
                result.error("0", "获取失败", null)
            } else {
                result.success(viersion)
            }
            //预激励视频广告
        } else if (call.method == "loadRewardVideoAd") {
            RewardVideoAd.init(mActivity!!, mActivity!!, call.arguments as Map<String?, Any?>)
            //显示激励广告
        } else if (call.method == "showRewardVideoAd") {
            RewardVideoAd.showAd()
            //插屏广告
        } else if (call.method == "interactionAd") {
            val mCodeId = call.argument<String>("androidCodeId")
            val supportDeepLink = call.argument<Boolean>("supportDeepLink")
            var expressViewWidth = call.argument<Double>("expressViewWidth")
            var expressViewHeight = call.argument<Double>("expressViewHeight")
            var expressNum = call.argument<Integer>("expressNum")
            InteractionExpressAd.init(
                mActivity!!,
                mActivity!!,
                mCodeId,
                supportDeepLink,
                expressViewWidth!!,
                expressViewHeight!!,
                expressNum!!
            )
            result.success(true)
            //全屏广告
        } else if (call.method == "fullScreenVideoAd") {
            val mCodeId = call.argument<String>("androidCodeId")
            val supportDeepLink = call.argument<Boolean>("supportDeepLink")
            val orientation = call.argument<Int>("orientation")
            FullScreenVideoExpressAd.init(
                mActivity!!,
                mActivity!!,
                mCodeId,
                supportDeepLink,
                orientation!!
            )
            result.success(true)
            //预加载插屏广告 全屏插屏二合一
        } else if (call.method == "loadFullScreenVideoAdInteraction") {
            val mCodeId = call.argument<String>("androidCodeId")
            val supportDeepLink = call.argument<Boolean>("supportDeepLink")
            val orientation = call.argument<Int>("orientation")
            FullScreenVideoAdInteraction.init(
                mActivity!!,
                mActivity!!,
                mCodeId,
                supportDeepLink,
                orientation!!
            )
            result.success(true)
            //显示插屏广告 全屏插屏二合一
        } else if (call.method == "showFullScreenVideoAdInteraction") {
            FullScreenVideoAdInteraction.showAd()
            result.success(true)
        }
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }
}
