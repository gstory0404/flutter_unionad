package com.gstory.flutter_unionad.bannerad

import android.app.Activity
import android.content.Context
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.StandardMessageCodec
import io.flutter.plugin.platform.PlatformView
import io.flutter.plugin.platform.PlatformViewFactory

/**
 * @Description:
 * @Author: gstory0404@gmail
 * @CreateDate: 2020/8/7 10:41
 */
internal class BannerAdViewFactory(private val messenger: BinaryMessenger, private val activity: Activity) : PlatformViewFactory(StandardMessageCodec.INSTANCE) {
    override fun create(context: Context?, id: Int, args: Any?): PlatformView {
        val params = args as Map<String?, Any?>
        return BannerAdView(context!!, activity,messenger, id, params)
    }
}