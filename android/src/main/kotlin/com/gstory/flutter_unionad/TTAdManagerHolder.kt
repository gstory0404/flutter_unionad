package com.gstory.flutter_unionad

import android.content.Context
import android.util.Log
import com.bytedance.sdk.openadsdk.*

/**
 * @Description:
 * @Author: gstory0404@gmail
 * @CreateDate: 2020/8/18 15:05
 */
object TTAdManagerHolder {
    private var sInit = false
    private var controller: TTCustomController? = null

    fun get(): TTAdManager {
        if (!sInit) {
            throw RuntimeException("flutter_unionad is not init, please check.")
        }
        return TTAdSdk.getAdManager()
    }

    //step1:接入网盟广告sdk的初始化操作，详情见接入文档和穿山甲平台说明
    fun init(
        context: Context,
        appId: String,
        useTextureView: Boolean,
        appName: String,
        allowShowNotify: Boolean,
        allowShowPageWhenScreenLock: Boolean,
        debug: Boolean,
        supportMultiProcess: Boolean,
        directDownloadNetworkType: List<Int>,
        callback: TTAdSdk.InitCallback
    ) {
        if (!sInit) {
            TTAdSdk.init(
                context,
                buildConfig(
                    context,
                    appId,
                    useTextureView,
                    appName,
                    allowShowNotify,
                    allowShowPageWhenScreenLock,
                    debug,
                    supportMultiProcess,
                    directDownloadNetworkType
                ),
                object : TTAdSdk.InitCallback {
                    override fun success() {
                        sInit = true
                        callback.success()
                    }

                    override fun fail(p0: Int, p1: String?) {
                        sInit = false
                        callback.fail(p0, p1)
                    }

                }

            )
        }else{
            callback.success()
        }
    }

    private fun buildConfig(
        context: Context,
        appId: String,
        useTextureView: Boolean,
        appName: String,
        allowShowNotify: Boolean,
        allowShowPageWhenScreenLock: Boolean,
        debug: Boolean,
        supportMultiProcess: Boolean,
        directDownloadNetworkType: List<Int>
    ): TTAdConfig {
        val d = IntArray(directDownloadNetworkType.size)
        for (i in directDownloadNetworkType.indices) {
            d[i] = directDownloadNetworkType[i]
        }
        return TTAdConfig.Builder()
            .appId(appId)
            .useTextureView(useTextureView) //使用TextureView控件播放视频,默认为SurfaceView,当有SurfaceView冲突的场景，可以使用TextureView
            .appName(appName)
            .allowShowNotify(allowShowNotify) //是否允许sdk展示通知栏提示
//            .allowShowPageWhenScreenLock(allowShowPageWhenScreenLock) //是否在锁屏场景支持展示广告落地页
            .debug(debug) //测试阶段打开，可以通过日志排查问题，上线时去除该调用
            .directDownloadNetworkType(*d) //允许直接下载的网络状态集合
            .supportMultiProcess(supportMultiProcess) //是否支持多进程
            .needClearTaskReset() //.httpStack(new MyOkStack3())//自定义网络库，demo中给出了okhttp3版本的样例，其余请自行开发或者咨询工作人员。
            .customController(controller)
            .build()
    }

    //隐私权限控制
    fun privacyConfig(
        isCanUseLocation: Boolean,
        lat: Double,
        lon: Double,
        isCanUsePhoneState: Boolean,
        imei: String,
        isCanUseWifiState: Boolean,
        isCanUseWriteExternal: Boolean,
        oaid: String
    ) {
        Log.e("===>","${TTAdConstant.IS_P}")
//        Log.e(
//            "隐私控制", "isCanUseLocation=$isCanUseLocation\n" +
//                    "lat=$lat\n" +
//                    "lon=$lon\n" +
//                    "isCanUsePhoneState=$isCanUsePhoneState\n" +
//                    "imei=$imei\n" +
//                    "isCanUseWifiState=$isCanUseWifiState\n" +
//                    "isCanUseWriteExternal=$isCanUseWriteExternal\n" +
//                    "oaid=$oaid\n"
//        )
        controller = object : TTCustomController() {
            override fun isCanUseLocation(): Boolean {
                return isCanUseLocation
            }

            override fun getTTLocation(): TTLocation {
                return TTLocation(lat, lon)
            }

            override fun isCanUsePhoneState(): Boolean {
                return isCanUsePhoneState
            }

            override fun getDevImei(): String {
                return imei
            }

            override fun isCanUseWifiState(): Boolean {
                return isCanUseWifiState
            }

            override fun isCanUseWriteExternal(): Boolean {
                return isCanUseWriteExternal
            }

            override fun getDevOaid(): String {
                return oaid
            }
        }
    }
}