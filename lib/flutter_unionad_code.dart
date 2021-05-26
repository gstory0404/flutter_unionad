/// 描述：
/// @author guozi
/// @e-mail gstory0404@gmail.com
/// @time   2020/3/11

///网络类型
class NetCode {
  static const int NETWORK_STATE_MOBILE = 1;
  static const int NETWORK_STATE_2G = 2;
  static const int NETWORK_STATE_3G = 3;
  static const int NETWORK_STATE_WIFI = 4;
  static const int NETWORK_STATE_4G = 5;
}

///激励视频方向
class AdOrientation {
  ///竖屏
  static const int VERTICAL = 1;

  ///横屏
  static const int HORIZONTAL = 2;
}

///数据类型
class AdType {
  static const String adType = "adType";

  ///激励广告
  static const String rewardAd = "rewardAd";

  ///全屏视频广告
  static const String fullVideoAd = "fullVideoAd";

  ///插屏广告
  static const String interactAd = "interactionAd";
}

class OnAdMethod {
  ///stream中 广告方法
  static const String onAdMethod = "onAdMethod";

  ///广告加载状态 view使用
  ///显示view
  static const String onShow = "onShow";

  ///加载失败
  static const String onFail = "onFail";

  ///不感兴趣
  static const String onDislike = "onDislike";

  ///点击
  static const String onClick = "onClick";

  ///视频播放
  static const String onVideoPlay = "onVideoPlay";

  ///视频暂停
  static const String onVideoPause = "onVideoPause";

  ///视频结束
  static const String onVideoStop = "onVideoStop";

  ///跳过
  static const String onSkip = "onSkip";

  ///倒计时结束
  static const String onFinish = "onFinish";

  ///加载超时
  static const String onTimeOut = "onTimeOut";

  ///广告关闭
  static const String onClose = "onClose";

  ///广告奖励校验
  static const String onVerify = "onVerify";
}

///权限请求结果
class PermissionCode {
  ///未确定
  static const int notDetermined = 0;

  ///限制
  static const int restricted = 1;

  ///拒绝
  static const int denied = 2;

  ///同意
  static const int authorized = 3;
}
