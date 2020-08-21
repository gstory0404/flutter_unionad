package com.gstory.flutter_unionad.splashad

import android.content.Context
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.StandardMessageCodec
import io.flutter.plugin.platform.PlatformView
import io.flutter.plugin.platform.PlatformViewFactory

/**
 * @Description:
 * @Author: gstory0404@gmail
 * @CreateDate: 2020/8/19 11:37
 */
class SplashAdViewFactory(private val messenger: BinaryMessenger) : PlatformViewFactory(StandardMessageCodec.INSTANCE) {
    override fun create(context: Context, id: Int, args: Any): PlatformView {
        val params = args as Map<String?, Any?>
        return SplashAdView(context, messenger, id, params)
    }
}