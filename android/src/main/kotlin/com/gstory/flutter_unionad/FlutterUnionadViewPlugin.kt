package com.gstory.flutter_unionad

import com.gstory.flutter_unionad.bannerexpressad.BannerExpressAdViewFactory
import com.gstory.flutter_unionad.interactionexpressad.InteractionExpressAdView
import com.gstory.flutter_unionad.interactionexpressad.InteractionExpressAdViewFactory
import com.gstory.flutter_unionad.nativeexpressad.NativeExpressAdFactory
import com.gstory.flutter_unionad.splashad.SplashAdViewFactory
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.engine.plugins.shim.ShimPluginRegistry
import io.flutter.plugin.common.PluginRegistry

/**
 * @Description:
 * @Author: gstory0404@gmail
 * @CreateDate: 2020/8/19 11:38
 */
object FlutterUnionadViewPlugin {
    fun registerWith(flutterEngine: FlutterEngine) {
        val key: String = FlutterUnionadViewPlugin::class.java.canonicalName
        val shimPluginRegistry = ShimPluginRegistry(flutterEngine)
        if (shimPluginRegistry.hasPlugin(key)) return;
        val registrar: PluginRegistry.Registrar = shimPluginRegistry.registrarFor(key)
        val platformViewRegistry = registrar.platformViewRegistry()
        //注册开屏广告
        platformViewRegistry.registerViewFactory("com.gstory.flutter_unionad/SplashAdView", SplashAdViewFactory(registrar.messenger()))
        //注册banner广告
        platformViewRegistry.registerViewFactory("com.gstory.flutter_unionad/BannerExpressAdView", BannerExpressAdViewFactory(registrar.messenger(),registrar.activity()))
        //注册个性化模板信息流广告
        platformViewRegistry.registerViewFactory("com.gstory.flutter_unionad/NativeExpressAdView", NativeExpressAdFactory(registrar.messenger(),registrar.activity()))
        //注册个性化模板插屏广告
        platformViewRegistry.registerViewFactory("com.gstory.flutter_unionad/InteractionExpressAdView", InteractionExpressAdViewFactory(registrar.messenger(),registrar.activity()))
    }
}