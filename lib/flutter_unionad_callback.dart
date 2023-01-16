part of 'flutter_unionad.dart';

/// @Author: gstory
/// @CreateDate: 2021/5/24 6:47 下午
/// @Description: dart类作用描述

///显示
typedef OnShow = void Function();

///失败
typedef OnFail = void Function(dynamic message);

///不喜欢
typedef OnDislike = void Function(dynamic message);

///点击
typedef OnClick = void Function();

///视频播放
typedef OnVideoPlay = void Function();

///视频暂停
typedef OnVideoPause = void Function();

///视频播放结束
typedef OnVideoStop = void Function();

///跳过
typedef OnSkip = void Function();

///倒计时结束
typedef OnFinish = void Function();

///加载超时
typedef OnTimeOut = void Function();

///关闭
typedef OnClose = void Function();

///广告预加载完成
typedef OnReady = void Function();

///广告预加载未完成
typedef OnUnReady = void Function();

///广告物料缓存成功
typedef OnCache = void Function();

///广告奖励验证
/// [isVerify] 是否成功
/// [rewardAmount]奖励数量
/// [rewardName]奖励名称
/// [errorCode]错误码
/// [message]错误信息
typedef OnVerify = void Function(bool isVerify, int rewardAmount,
    String rewardName, int errorCode, String message);

///激励广告广告进阶奖励回调参数
/// [isVerify] 是否成功
/// [rewardType]奖励类型
/// [rewardAmount]奖励数量
/// [rewardName]奖励名称
/// [errorCode]错误码
/// [error]错误信息
/// [propose] 建议奖励数量
typedef OnRewardArrived = void Function(
    bool isVerify,
    int rewardType,
    int rewardAmount,
    String rewardName,
    int errorCode,
    String error,
    double propose);

///未确定
typedef NotDetermined = void Function();

///限制
typedef Restricted = void Function();

///拒绝
typedef Denied = void Function();

///同意
typedef Authorized = void Function();

///
///banner广告回调
///
class FlutterUnionadBannerCallBack {
  OnShow? onShow;
  OnFail? onFail;
  OnDislike? onDislike;
  OnClick? onClick;

  FlutterUnionadBannerCallBack(
      {this.onShow, this.onFail, this.onDislike, this.onClick});
}

///
///draw视频广告回调
///
class FlutterUnionadDrawFeedCallBack {
  OnShow? onShow;
  OnFail? onFail;
  OnClick? onClick;
  OnDislike? onDislike;
  OnVideoPlay? onVideoPlay;
  OnVideoPause? onVideoPause;
  OnVideoStop? onVideoStop;

  FlutterUnionadDrawFeedCallBack(
      {this.onShow,
      this.onFail,
      this.onClick,
      this.onDislike,
      this.onVideoPlay,
      this.onVideoPause,
      this.onVideoStop});
}

///
///信息流广告回调
///
class FlutterUnionadNativeCallBack {
  OnShow? onShow;
  OnFail? onFail;
  OnDislike? onDislike;
  OnClick? onClick;

  FlutterUnionadNativeCallBack(
      {this.onShow, this.onFail, this.onDislike, this.onClick});
}

///
///开屏广告回调
///
class FlutterUnionadSplashCallBack {
  OnShow? onShow;
  OnFail? onFail;
  OnClick? onClick;
  OnFinish? onFinish;
  OnSkip? onSkip;
  OnTimeOut? onTimeOut;

  FlutterUnionadSplashCallBack(
      {this.onShow,
      this.onFail,
      this.onClick,
      this.onFinish,
      this.onSkip,
      this.onTimeOut});
}

///
///全屏广告回调
///
class FlutterUnionadFullVideoCallBack {
  OnShow? onShow;
  OnClick? onClick;
  OnSkip? onSkip;
  OnClose? onClose;
  OnFail? onFail;
  OnFinish? onFinish;

  FlutterUnionadFullVideoCallBack(
      {this.onShow,
      this.onClick,
      this.onSkip,
      this.onClose,
      this.onFail,
      this.onFinish});
}

///
/// 新模板渲染插屏
///
class FlutterUnionadNewInteractionCallBack {
  OnShow? onShow;
  OnClick? onClick;
  OnSkip? onSkip;
  OnClose? onClose;
  OnFail? onFail;
  OnFinish? onFinish;
  OnReady? onReady;
  OnUnReady? onUnReady;

  FlutterUnionadNewInteractionCallBack(
      {this.onShow,
      this.onClick,
      this.onSkip,
      this.onClose,
      this.onFail,
      this.onFinish,
      this.onReady,
      this.onUnReady});
}

///
///插屏广告回调
///
class FlutterUnionadInteractionCallBack {
  OnShow? onShow;
  OnClick? onClick;
  OnDislike? onDislike;
  OnClose? onClose;
  OnFail? onFail;

  FlutterUnionadInteractionCallBack(
      {this.onShow, this.onClick, this.onDislike, this.onClose, this.onFail});
}

///
///激励广告回调
///
class FlutterUnionadRewardAdCallBack {
  OnShow? onShow;
  OnClose? onClose;
  OnFail? onFail;
  OnSkip? onSkip;
  OnClick? onClick;
  OnVerify? onVerify;
  OnRewardArrived? onRewardArrived;
  OnReady? onReady;
  OnUnReady? onUnReady;
  OnCache? onCache;

  FlutterUnionadRewardAdCallBack(
      {this.onShow,
      this.onClick,
      this.onClose,
      this.onFail,
      this.onVerify,
      this.onRewardArrived,
      this.onSkip,
      this.onReady,
      this.onUnReady,
      this.onCache});
}

///
///权限申请回调
///
class FlutterUnionadPermissionCallBack {
  NotDetermined? notDetermined;
  Restricted? restricted;
  Denied? denied;
  Authorized? authorized;

  FlutterUnionadPermissionCallBack({
    this.notDetermined,
    this.restricted,
    this.denied,
    this.authorized,
  });
}
