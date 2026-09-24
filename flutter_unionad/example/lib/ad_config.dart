import 'package:flutter/foundation.dart';

/// 示例广告配置（按当前平台返回对应 id）
class AdConfig {
  /// appid
  static String get appId {
    switch (defaultTargetPlatform) {
      case TargetPlatform.iOS:
        return "5750023";
      case TargetPlatform.android:
        return "5750023";
      default:
        // OpenHarmony 等
        return "5638354";
    }
  }

  /// 激励视频广告位
  static String get rewardVideoCodeId {
    switch (defaultTargetPlatform) {
      case TargetPlatform.iOS:
        return "103685185";
      case TargetPlatform.android:
        return "103685185";
      default:
        return "962519282";
    }
  }

  /// 插屏广告位
  static String get fullScreenVideoCodeId {
    switch (defaultTargetPlatform) {
      case TargetPlatform.iOS:
        return "103687132";
      case TargetPlatform.android:
        return "103687132";
      default:
        return "963135369";
    }
  }

  /// 横幅广告位
  static String get bannerCodeId {
    switch (defaultTargetPlatform) {
      case TargetPlatform.iOS:
        return "103686668";
      case TargetPlatform.android:
        return "103686668";
      default:
        return "102735527";
    }
  }

  /// Draw 视频广告位
  static String get drawFeedCodeId {
    switch (defaultTargetPlatform) {
      case TargetPlatform.iOS:
        return "103687068";
      case TargetPlatform.android:
        return "103687068";
      default:
        return "102734241";
    }
  }

  /// 信息流广告位
  static String get nativeCodeId {
    switch (defaultTargetPlatform) {
      case TargetPlatform.iOS:
        return "103686791";
      case TargetPlatform.android:
        return "103686791";
      default:
        return "102730271";
    }
  }

  /// 开屏广告位
  static String get splashCodeId {
    switch (defaultTargetPlatform) {
      case TargetPlatform.iOS:
        return "103687131";
      case TargetPlatform.android:
        return "103687131";
      default:
        return "102729400";
    }
  }
}
