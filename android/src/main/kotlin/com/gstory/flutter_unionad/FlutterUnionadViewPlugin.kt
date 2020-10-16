package com.gstory.flutter_unionad

import android.app.Activity
import com.gstory.flutter_unionad.bannerad.BannerExpressAdViewFactory
import com.gstory.flutter_unionad.drawfeedad.DrawFeedExpressAdViewFactory
import com.gstory.flutter_unionad.interactionad.InteractionExpressAdViewFactory
import com.gstory.flutter_unionad.nativead.NativeExpressAdFactory
import com.gstory.flutter_unionad.splashad.SplashAdViewFactory
import io.flutter.embedding.engine.plugins.FlutterPlugin

/**
 * @Description:
 * @Author: gstory0404@gmail
 * @CreateDate: 2020/8/19 11:38
 */
object FlutterUnionadViewPlugin {
    fun registerWith(binding: FlutterPlugin.FlutterPluginBinding,activity :Activity) {
        //注册开屏广告
        binding.platformViewRegistry.registerViewFactory(FlutterunionadViewConfig.splashAdView, SplashAdViewFactory(binding.binaryMessenger))
        //注册banner广告
        binding.platformViewRegistry.registerViewFactory(FlutterunionadViewConfig.bannerAdView, BannerExpressAdViewFactory(binding.binaryMessenger,activity))
        //注册个性化模板信息流广告
        binding.platformViewRegistry.registerViewFactory(FlutterunionadViewConfig.nativeAdView, NativeExpressAdFactory(binding.binaryMessenger,activity))
        //注册个性化模板插屏广告
        binding.platformViewRegistry.registerViewFactory(FlutterunionadViewConfig.interactionAdVie, InteractionExpressAdViewFactory(binding.binaryMessenger,activity))
        //注册个性化模板draw视频广告
        binding.platformViewRegistry.registerViewFactory(FlutterunionadViewConfig.drawFeedAdView, DrawFeedExpressAdViewFactory(binding.binaryMessenger,activity))
    }
}