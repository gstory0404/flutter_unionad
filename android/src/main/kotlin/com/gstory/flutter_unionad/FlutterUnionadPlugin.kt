package com.gstory.flutter_unionad

import android.app.Activity
import android.content.Context
import android.content.Intent
import android.text.TextUtils
import android.util.Log
import androidx.annotation.NonNull
import com.gstory.flutter_unionad.fullscreenvideoAd.FullScreenVideoExpressAd
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
    private var mFlutterPluginBinding: FlutterPlugin.FlutterPluginBinding?  = null

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        mActivity = binding.activity
        Log.e("FlutterUnionadPlugin->","onAttachedToActivity")
        FlutterUnionadViewPlugin.registerWith(mFlutterPluginBinding!!,mActivity!!)
    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
        mActivity = binding.activity
        Log.e("FlutterUnionadPlugin->","onReattachedToActivityForConfigChanges")
    }

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        Log.e("FlutterUnionadPlugin->","onAttachedToEngine")
        channel = MethodChannel(flutterPluginBinding.getFlutterEngine().getDartExecutor(), channelName)
        channel.setMethodCallHandler(this)
        applicationContext = flutterPluginBinding.applicationContext
        mFlutterPluginBinding = flutterPluginBinding
        FlutterUnionadEventPlugin().onAttachedToEngine(flutterPluginBinding)
//        FlutterUnionadViewPlugin.registerWith(flutterPluginBinding,mActivity!!)
    }

    override fun onDetachedFromActivityForConfigChanges() {
        mActivity = null
        Log.e("FlutterUnionadPlugin->","onDetachedFromActivityForConfigChanges")
    }

    override fun onDetachedFromActivity() {
        mActivity = null
        Log.e("FlutterUnionadPlugin->","onDetachedFromActivity")
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
                result.error("500", "appId can't be null", null)
            } else {
                if (appName == null || appName.trim { it <= ' ' }.isEmpty()) {
                    result.error("600", "appName can't be null", null)
                } else {
                    TTAdManagerHolder.init(applicationContext!!, appId, useTextureView!!, appName, allowShowNotify!!, allowShowPageWhenScreenLock!!, debug!!, supportMultiProcess!!, directDownloadNetworkType)
                    result.success(true)
                }
            }
            //请求权限
        } else if (call.method == "requestPermissionIfNecessary") {
            val mTTAdManager = TTAdManagerHolder.get()
            mTTAdManager.requestPermissionIfNecessary(applicationContext)
            //获取sdk版本号
        } else if (call.method == "getSDKVersion") {
            var viersion = TTAdManagerHolder.get().sdkVersion
            if (TextUtils.isEmpty(viersion)) {
                result.error("0", "获取失败", null)
            } else {
                result.success(viersion)
            }
            //激励视频广告
        } else if (call.method == "loadRewardVideoAd") {
            RewardVideoAd.init(mActivity!!, mActivity!!, call.arguments as Map<String?, Any?>)
            //插屏广告
        } else if (call.method == "interactionAd") {
            val mCodeId = call.argument<String>("androidCodeId")
            val supportDeepLink = call.argument<Boolean>("supportDeepLink")
            var expressViewWidth = call.argument<Double>("expressViewWidth")
            var expressViewHeight = call.argument<Double>("expressViewHeight")
            InteractionExpressAd.init(mActivity!!,mActivity!!, mCodeId, supportDeepLink, expressViewWidth!!, expressViewHeight!!)
            result.success(true)
            //全屏广告
        } else if(call.method == "fullScreenVideoAd"){
            val mCodeId = call.argument<String>("androidCodeId")
            val supportDeepLink = call.argument<Boolean>("supportDeepLink")
            val orientation = call.argument<Int>("orientation")
            FullScreenVideoExpressAd.init(mActivity!!, mActivity!!, mCodeId, supportDeepLink, orientation!!)
            result.success(true)
        }
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }
}
