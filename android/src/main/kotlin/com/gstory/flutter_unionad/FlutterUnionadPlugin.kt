package com.gstory.flutter_unionad

import android.app.Activity
import android.content.Context
import android.content.Intent
import android.text.TextUtils
import android.util.Log
import androidx.annotation.NonNull
import com.gstory.flutter_unionad.interactionexpressad.InteractionExpressAdDialog
import com.gstory.flutter_unionad.nativeexpressad.NativeExpressAdFactory
import com.gstory.flutter_unionad.rewardvideoad.RewardVideoAdActivity
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.BinaryMessenger
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
            val appId = call.argument<String>("appId")
            var useTextureView = call.argument<Boolean>("useTextureView")
            val appName = call.argument<String>("appName")
            var allowShowNotify = call.argument<Boolean>("allowShowNotify")
            var allowShowPageWhenScreenLock = call.argument<Boolean>("allowShowPageWhenScreenLock")
            var debug = call.argument<Boolean>("debug")
            var supportMultiProcess = call.argument<Boolean>("supportMultiProcess")
            val directDownloadNetworkType = call.argument<List<Int>>("directDownloadNetworkType")!!
            if (useTextureView == null) {
                useTextureView = false
            }
            if (allowShowNotify == null) {
                allowShowNotify = true
            }
            if (allowShowPageWhenScreenLock == null) {
                allowShowPageWhenScreenLock = true
            }
            if (debug == null) {
                debug = true
            }
            if (supportMultiProcess == null) {
                supportMultiProcess = false
            }
            if (appId == null || appId.trim { it <= ' ' }.isEmpty()) {
                result.error("500", "appId can't be null", null)
            } else {
                if (appName == null || appName.trim { it <= ' ' }.isEmpty()) {
                    result.error("600", "appName can't be null", null)
                } else {
                    TTAdManagerHolder.init(applicationContext!!, appId, useTextureView, appName, allowShowNotify, allowShowPageWhenScreenLock, debug, supportMultiProcess, directDownloadNetworkType)
                    result.success(true)
                }
            }
        } else if (call.method == "loadRewardVideoAd") {
            val mIsExpress = call.argument<Boolean>("mIsExpress")
            val mCodeId = call.argument<String>("mCodeId")
            val supportDeepLink = call.argument<Boolean>("supportDeepLink")
            var width = call.argument<Double>("expressViewWidth")
            var height = call.argument<Double>("expressViewHeight")
            val rewardName = call.argument<String>("rewardName")
            val rewardAmount = call.argument<Int>("rewardAmount")
            val userID = call.argument<String>("userID")
            var orientation = call.argument<Int>("orientation")
            val mediaExtra = call.argument<String>("mediaExtra")
            if (orientation == null) {
                orientation = 0
            }
            if (width == null) {
                width = UIUtils.dip2px(applicationContext!!, UIUtils.getScreenWidthDp(applicationContext!!)).toDouble()
            }
            if (height == null) {
                height = UIUtils.getRealHeight(applicationContext!!).toFloat().toDouble()
            }
            var expressViewWidth = width.toFloat()
            var expressViewHeight = height.toFloat()
            var intent = Intent()
            intent.putExtra("mIsExpress", mIsExpress)
            intent.putExtra("mCodeId", mCodeId)
            intent.putExtra("supportDeepLink", supportDeepLink)
            intent.putExtra("expressViewWidth", expressViewWidth)
            intent.putExtra("expressViewHeight", expressViewHeight)
            intent.putExtra("rewardName", rewardName)
            intent.putExtra("rewardAmount", rewardAmount)
            intent.putExtra("userID", userID)
            intent.putExtra("orientation", orientation)
            intent.putExtra("mediaExtra", mediaExtra)
            intent.setClass(applicationContext!!, RewardVideoAdActivity().javaClass)
            intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
            applicationContext!!.startActivity(intent)
            //请求权限
        } else if (call.method == "requestPermissionIfNecessary") {
            val mTTAdManager = TTAdManagerHolder.get()
            mTTAdManager.requestPermissionIfNecessary(applicationContext)
            //获取sdk版本号
        } else if (call.method == "getSDKVersion") {
            var viersion = TTAdManagerHolder.get().sdkVersion
            if (TextUtils.isEmpty(viersion)) {
                result.error("0", "获取失败", null);
            } else {
                result.success(viersion)
            }
            //插屏广告
        } else if (call.method == "interactionExpressAd") {
            val mCodeId = call.argument<String>("mCodeId")
            val supportDeepLink = call.argument<Boolean>("supportDeepLink")
            var expressViewWidth = call.argument<Double>("expressViewWidth")
            var expressViewHeight = call.argument<Double>("expressViewHeight")
            var dialog = InteractionExpressAdDialog(mActivity!!, R.style.FlutterUnionadDialog, mActivity!!, mCodeId, supportDeepLink, expressViewWidth!!, expressViewHeight!!)
            if (dialog.isShowing) {
                result.error("0", "插屏广告正在显示", null)
                return
            }
            dialog.show()
            result.success(true)
        }
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }
}
