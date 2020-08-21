package com.gstory.flutter_unionad

import android.content.Context
import com.bytedance.sdk.openadsdk.TTAdConfig
import com.bytedance.sdk.openadsdk.TTAdConstant
import com.bytedance.sdk.openadsdk.TTAdManager
import com.bytedance.sdk.openadsdk.TTAdSdk

/**
 * @Description:
 * @Author: gstory0404@gmail
 * @CreateDate: 2020/8/18 15:05
 */
object TTAdManagerHolder {
    private var sInit = false
    fun get(): TTAdManager {
        if (!sInit) {
            throw RuntimeException("TTAdSdk is not init, please check.")
        }
        return TTAdSdk.getAdManager()
    }

    fun init(context: Context, appId: String, useTextureView: Boolean, appName: String, allowShowNotify: Boolean, allowShowPageWhenScreenLock: Boolean, debug: Boolean, supportMultiProcess: Boolean, directDownloadNetworkType: List<Int>) {
        doInit(context, appId, useTextureView, appName, allowShowNotify, allowShowPageWhenScreenLock, debug, supportMultiProcess, directDownloadNetworkType)
    }

    //step1:接入网盟广告sdk的初始化操作，详情见接入文档和穿山甲平台说明
    private fun doInit(context: Context, appId: String, useTextureView: Boolean, appName: String, allowShowNotify: Boolean, allowShowPageWhenScreenLock: Boolean, debug: Boolean, supportMultiProcess: Boolean, directDownloadNetworkType: List<Int>) {
        if (!sInit) {
            TTAdSdk.init(context, buildConfig(context, appId, useTextureView, appName, allowShowNotify, allowShowPageWhenScreenLock, debug, supportMultiProcess, directDownloadNetworkType))
            sInit = true
        }
    }

    private fun buildConfig(context: Context, appId: String, useTextureView: Boolean, appName: String, allowShowNotify: Boolean, allowShowPageWhenScreenLock: Boolean, debug: Boolean, supportMultiProcess: Boolean, directDownloadNetworkType: List<Int>): TTAdConfig {
        val d = IntArray(directDownloadNetworkType.size)
        for (i in directDownloadNetworkType.indices) {
            d[i] = directDownloadNetworkType[i]
        }
        return TTAdConfig.Builder()
                .appId(appId)
                .useTextureView(useTextureView) //使用TextureView控件播放视频,默认为SurfaceView,当有SurfaceView冲突的场景，可以使用TextureView
                .appName(appName)
                .titleBarTheme(TTAdConstant.TITLE_BAR_THEME_DARK)
                .allowShowNotify(allowShowNotify) //是否允许sdk展示通知栏提示
                .allowShowPageWhenScreenLock(allowShowPageWhenScreenLock) //是否在锁屏场景支持展示广告落地页
                .debug(debug) //测试阶段打开，可以通过日志排查问题，上线时去除该调用
                .directDownloadNetworkType(1) //允许直接下载的网络状态集合
                .supportMultiProcess(supportMultiProcess) //是否支持多进程
                .needClearTaskReset() //.httpStack(new MyOkStack3())//自定义网络库，demo中给出了okhttp3版本的样例，其余请自行开发或者咨询工作人员。
                .build()
    }
}