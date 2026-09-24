import { Any, EventChannel, FlutterPlugin, FlutterPluginBinding, StandardMessageCodec } from '@ohos/flutter_ohos';

import FlutterunionadViewConfig from './FlutterunionadViewConfig';

import SplashAdViewFactory from './splash/SplashAdViewFactory';
import BannerAdViewFactory from './banner/BannerAdViewFactory';
import { UIAbility } from '@kit.AbilityKit';

export default class FlutterUnionadViewPlugin {
  static register(binding: FlutterPluginBinding, uIAbility: UIAbility) {
    binding.getPlatformViewRegistry().registerViewFactory(FlutterunionadViewConfig.view.splashAdView, new SplashAdViewFactory(binding, uIAbility))
    binding.getPlatformViewRegistry().registerViewFactory(FlutterunionadViewConfig.view.bannerAdView, new BannerAdViewFactory(binding, uIAbility))
  }
}