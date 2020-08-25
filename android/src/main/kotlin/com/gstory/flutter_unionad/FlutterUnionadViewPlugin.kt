package com.gstory.flutter_unionad

import android.app.Activity
import com.gstory.flutter_unionad.bannerexpressad.BannerExpressAdViewFactory
import com.gstory.flutter_unionad.drawfeedexpressad.DrawFeedExpressAdViewFactory
import com.gstory.flutter_unionad.interactionexpressad.InteractionExpressAdView
import com.gstory.flutter_unionad.interactionexpressad.InteractionExpressAdViewFactory
import com.gstory.flutter_unionad.nativeexpressad.NativeExpressAdFactory
import com.gstory.flutter_unionad.splashad.SplashAdViewFactory
import io.flutter.app.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.shim.ShimPluginRegistry
import io.flutter.plugin.common.PluginRegistry

/**
 * @Description:
 * @Author: gstory0404@gmail
 * @CreateDate: 2020/8/19 11:38
 */
object FlutterUnionadViewPlugin {
    fun registerWith(binding: FlutterPlugin.FlutterPluginBinding,activity :Activity) {
        //注册开屏广告
        binding.platformViewRegistry.registerViewFactory("com.gstory.flutter_unionad/SplashAdView", SplashAdViewFactory(binding.binaryMessenger))
        //注册banner广告
        binding.platformViewRegistry.registerViewFactory("com.gstory.flutter_unionad/BannerExpressAdView", BannerExpressAdViewFactory(binding.binaryMessenger,activity))
        //注册个性化模板信息流广告
        binding.platformViewRegistry.registerViewFactory("com.gstory.flutter_unionad/NativeExpressAdView", NativeExpressAdFactory(binding.binaryMessenger,activity))
        //注册个性化模板插屏广告
        binding.platformViewRegistry.registerViewFactory("com.gstory.flutter_unionad/InteractionExpressAdView", InteractionExpressAdViewFactory(binding.binaryMessenger,activity))
        //注册个性化模板draw视频广告
        binding.platformViewRegistry.registerViewFactory("com.gstory.flutter_unionad/DrawFeedExpressAdView", DrawFeedExpressAdViewFactory(binding.binaryMessenger,activity))
    }
}