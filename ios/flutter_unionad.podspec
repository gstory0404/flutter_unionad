#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint flutter_unionad.podspec' to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'flutter_unionad'
  s.version          = '0.0.1'
  s.summary          = 'A new flutter plugin project.'
  s.description      = <<-DESC
A new flutter plugin project.
                       DESC
  s.homepage         = 'https://github.com/gstory0404/flutter_unionad'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'gstory' => 'https://github.com/gstory0404' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.static_framework = true
  s.dependency 'Flutter'
  s.platform = :ios, '9.0'
  s.dependency 'Ads-CN-Beta/BUAdSDK','7.2.0.0'
#   s.dependency 'Ads-CN-Beta/CSJMediation','7.2.0.0
  # 仅加入聚合广告 不需要直播 不集成TTSDK
  s.dependency 'Ads-CN-Beta/CSJMediation-Only','7.2.0.0'
# 引入融合Adapters(推荐使用自动拉取adapter工具，此处无需引入)
# pod 'GMGdtAdapter-Beta', '4.15.10.1'
# pod 'GMBaiduAdapter-Beta', '5.370.2'
# pod 'GMKsAdapter-Beta', '3.3.71.1'
# pod 'GMSigmobAdapter-Beta', '4.15.3.1'
# pod 'GMMintegralAdapter-Beta', '7.7.3.1'
# pod 'GMAdmobAdapter-Beta', '10.0.0.0'
# pod 'GMUnityAdapter-Beta', '4.3.0.0'
# # 引入使用到的ADN SDK，开发者请按需引入
# pod 'GDTMobSDK', '4.15.10'
# pod 'BaiduMobAdSDK', '5.370'
# pod 'KSAdSDK', '3.3.71'
# pod 'SigmobAd-iOS', '4.15.3'
# pod 'MintegralAdSDK', '7.7.3', :subspecs => [
#   'SplashAd',
#   'InterstitialAd',
#   'NewInterstitialAd',
#   'InterstitialVideoAd',
#   'RewardVideoAd',
#   'NativeAd',
#   'NativeAdvancedAd',
#   'BannerAd',
#   'BidNativeAd',
#   'BidNewInterstitialAd',
#   'BidInterstitialVideoAd',
#   'BidRewardVideoAd'
# ]
#                 pod 'Google-Mobile-Ads-SDK', '10.0.0'
# pod 'UnityAds', '4.3.0'

# .framework文件
#  s.vendored_frameworks = 'SDK/BUAdSDK.framework','SDK/BURelyFoundation.framework','SDK/CSJAdSDK.framework'
# .a文件
#  s.vendored_libraries =''
# .bundle文件
#  s.resource='SDK/CSJAdSDK.bundle'

  # Flutter.framework does not contain a i386 slice. Only x86_64 simulators are supported.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'VALID_ARCHS[sdk=iphonesimulator*]' => 'x86_64' }
  s.swift_version = '5.0'
end
