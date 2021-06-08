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

///广告奖励验证
typedef OnVerify = void Function(
    bool isVerify, int rewardAmount, String rewardName);

///banner广告回调
class BannerAdCallBack {
  OnShow? onShow;
  OnFail? onFail;
  OnDislike? onDislike;
  OnClick? onClick;

  BannerAdCallBack({this.onShow, this.onFail, this.onDislike, this.onClick});
}

///draw视频广告回调
class DrawFeedAdCallBack {
  OnShow? onShow;
  OnFail? onFail;
  OnClick? onClick;
  OnDislike? onDislike;
  OnVideoPlay? onVideoPlay;
  OnVideoPause? onVideoPause;
  OnVideoStop? onVideoStop;

  DrawFeedAdCallBack(
      {this.onShow,
      this.onFail,
      this.onClick,
      this.onDislike,
      this.onVideoPlay,
      this.onVideoPause,
      this.onVideoStop});
}

///信息流广告回调
class NativeAdCallBack {
  OnShow? onShow;
  OnFail? onFail;
  OnDislike? onDislike;
  OnClick? onClick;

  NativeAdCallBack({this.onShow, this.onFail, this.onDislike, this.onClick});
}

///开屏广告回调
class SplashAdCallBack {
  OnShow? onShow;
  OnFail? onFail;
  OnClick? onClick;
  OnFinish? onFinish;
  OnSkip? onSkip;
  OnTimeOut? onTimeOut;

  SplashAdCallBack(
      {this.onShow,
      this.onFail,
      this.onClick,
      this.onFinish,
      this.onSkip,
      this.onTimeOut});
}

///全屏广告回调
class FullVideoAdCallBack {
  OnShow? onShow;
  OnClick? onClick;
  OnSkip? onSkip;
  OnClose? onClose;
  OnFail? onFail;
  OnFinish? onFinish;

  FullVideoAdCallBack(
      {this.onShow,
      this.onClick,
      this.onSkip,
      this.onClose,
      this.onFail,
      this.onFinish});
}

/// 新模板渲染插屏
class FullScreenVideoAdInteractionCallBack {
  OnShow? onShow;
  OnClick? onClick;
  OnSkip? onSkip;
  OnClose? onClose;
  OnFail? onFail;
  OnFinish? onFinish;
  OnReady? onReady;
  OnUnReady? onUnReady;

  FullScreenVideoAdInteractionCallBack(
      {this.onShow,
      this.onClick,
      this.onSkip,
      this.onClose,
      this.onFail,
      this.onFinish,
      this.onReady,
      this.onUnReady});
}

///插屏广告回调
class InteractionAdCallBack {
  OnShow? onShow;
  OnClick? onClick;
  OnDislike? onDislike;
  OnClose? onClose;
  OnFail? onFail;

  InteractionAdCallBack(
      {this.onShow, this.onClick, this.onDislike, this.onClose, this.onFail});
}

///激励广告回调
class RewardAdCallBack {
  OnShow? onShow;
  OnClose? onClose;
  OnFail? onFail;
  OnSkip? onSkip;
  OnClick? onClick;
  OnVerify? onVerify;
  OnReady? onReady;
  OnUnReady? onUnReady;

  RewardAdCallBack(
      {this.onShow,
      this.onClick,
      this.onClose,
      this.onFail,
      this.onVerify,
      this.onSkip,
      this.onReady,
      this.onUnReady});
}
