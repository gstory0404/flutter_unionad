package com.gstory.flutter_unionad

import android.content.Context
import android.util.Log
import com.bytedance.sdk.openadsdk.*
import com.bytedance.sdk.openadsdk.mediation.init.IMediationPrivacyConfig
import com.bytedance.sdk.openadsdk.mediation.init.MediationPrivacyConfig

/**
 * @Description:
 * @Author: gstory0404@gmail
 * @CreateDate: 2020/8/18 15:05
 */
object TTAdManagerHolder {
    private var sInit = false

    fun get(): TTAdManager {
        if (!sInit) {
            throw RuntimeException("调用广告前，请先进行flutter_unionad初始化")
        }
        return TTAdSdk.getAdManager()
    }

    //step1:接入网盟广告sdk的初始化操作，详情见接入文档和穿山甲平台说明
    fun init(
        context: Context,
        arguments: Map<String?, Any?>,
        callback: TTAdSdk.Callback
    ) {
        val appId = arguments["androidAppId"] as String
        val appName = arguments["appName"] as String
        val useMediation = arguments["useMediation"] as Boolean
        val paid = arguments["paid"] as Boolean
        val keywords = arguments["keywords"] as String
        var allowShowNotify = arguments["allowShowNotify"] as Boolean
        var debug = arguments["debug"] as Boolean
        var supportMultiProcess = arguments["supportMultiProcess"] as Boolean
        val directDownloadNetworkType = arguments["directDownloadNetworkType"] as List<Int>
        val themeStatus = arguments["themeStatus"] as Int
        //隐私管理
        val androidPrivacy = arguments["androidPrivacy"] as Map<String?, Any?>

        val d = IntArray(directDownloadNetworkType.size)
        for (i in directDownloadNetworkType.indices) {
            d[i] = directDownloadNetworkType[i]
        }
        TTAdSdk.init(
            context,
            TTAdConfig.Builder()
                .appId(appId) //应用ID
                .appName(appName) //应用名称
                .useMediation(useMediation)//使用聚合功能一定要打开此开关，否则不会请求聚合广告，默认这个值为false
                .paid(paid)//是否为计费用户
                .keywords(keywords) //用户画像的关键词列表
                .allowShowNotify(allowShowNotify) //是否允许SDK弹出通知
                .debug(debug) //测试阶段打开，可以通过日志排查问题，上线时去除该调用
                .directDownloadNetworkType(*d) //允许直接下载的网络状态集合
                .supportMultiProcess(supportMultiProcess) //是否支持多进程
                .customController(object : TTCustomController() {
                    //是否允许SDK主动使用地理位置信息
                    override fun isCanUseLocation(): Boolean {
                        return androidPrivacy["isCanUseLocation"] as Boolean
                    }

                    //可传入地理位置信息
                    override fun getTTLocation(): TTLocation {
                        return TTLocation(
                            androidPrivacy["lat"] as Double,
                            androidPrivacy["lon"] as Double
                        )
                    }

                    //是否允许sdk上报手机app安装列表
                    override fun alist(): Boolean {
                        return androidPrivacy["alist"] as Boolean
                    }

                    //是否允许SDK主动使用手机硬件参数
                    override fun isCanUsePhoneState(): Boolean {
                        return androidPrivacy["isCanUsePhoneState"] as Boolean
                    }

                    //当isCanUsePhoneState=false时，可传入IME信息
                    override fun getDevImei(): String {
                        return androidPrivacy["imei"] as String
                    }

                    //是否允许SDK主动使用ACCESS_WIFI_STATE权限
                    override fun isCanUseWifiState(): Boolean {
                        return androidPrivacy["isCanUsePhoneState"] as Boolean
                    }

                    //当isCanUseWifiState=false时，可传入Mac地址信息
                    override fun getMacAddress(): String? {
                        return androidPrivacy["macAddress"] as String
                    }

                    //是否允许SDK主动使用WRITE_EXTERNAL_STORAGE权限
                    override fun isCanUseWriteExternal(): Boolean {
                        return androidPrivacy["isCanUseWriteExternal"] as Boolean
                    }

                    //开发者可以传入OAID
                    override fun getDevOaid(): String {
                        return androidPrivacy["oaid"] as String
                    }

                    //是否能获取android ID
                    override fun isCanUseAndroidId(): Boolean {
                        return androidPrivacy["isCanUseAndroidId"] as Boolean
                    }

                    //是否能获取android ID
                    override fun getAndroidId(): String {
                        return androidPrivacy["androidId"] as String
                    }

                    //是否允许SDK在申明和授权了的情况下使用录音权限
                    override fun isCanUsePermissionRecordAudio(): Boolean {
                        return androidPrivacy["isCanUsePermissionRecordAudio"] as Boolean
                    }

                    override fun getMediationPrivacyConfig(): IMediationPrivacyConfig {
                        return object : MediationPrivacyConfig() {
                            override fun isCanUseOaid(): Boolean {
                                return androidPrivacy["isCanUsePhoneState"] as Boolean
                            }

                            //是否限制个性化推荐接口
                            override fun isLimitPersonalAds(): Boolean {
                                return androidPrivacy["isLimitPersonalAds"] as Boolean
                            }

                            //是否启用程序化广告推荐 true启用 false不启用
                            override fun isProgrammaticRecommend(): Boolean {
                                return androidPrivacy["isProgrammaticRecommend"] as Boolean
                            }
                        }
                    }
                })
                .themeStatus(themeStatus)
                .build()
        )
        TTAdSdk.start(object : TTAdSdk.Callback {
            override fun success() {
                sInit = true
                callback.success()
            }

            override fun fail(code: Int, msg: String?) {
                sInit = false
                callback.fail(code, msg)
            }
        })
    }
}