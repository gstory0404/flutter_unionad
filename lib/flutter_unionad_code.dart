/// 描述：
/// @author guozi
/// @e-mail gstory0404@gmail.com
/// @time   2020/3/11

///网络类型
const int NETWORK_STATE_MOBILE = 1;
const int NETWORK_STATE_2G = 2;
const int NETWORK_STATE_3G = 3;
const int NETWORK_STATE_WIFI = 4;
const int NETWORK_STATE_4G = 5;

///激励视频方向
//竖屏
const int VideoVERTICAL = 1;
//横屏
const int VideoHORIZONTAL = 2;

///数据类型
const String adType = "adType";
//激励广告
const String rewardAd = "rewardAd";
//全屏视频广告
const String fullVideoAd = "fullVideoAd";

///开屏广告
//加载超时
const String onAplashTimeout = "onAplashTimeout";
//广告点击
const String onAplashClick = "onAplashClick";
//跳过广告
const String onAplashSkip = "onAplashSkip";
//广告结束
const String onAplashFinish = "onAplashFinish";

///激励广告相关
//是否观看成功
const String rewardVerify = "rewardVerify";
//奖励数量
const String rewardAmount = "rewardAmount";
//奖励名称
const String rewardName = "rewardName";

///全屏视频广告广告
const String fullVideoType = "fullVideoType";
//广告显示
const String onAdShow = "onAdShow";
//广告返回
const String onAdVideoBarClick = "onAdVideoBarClick";
//广告关闭
const String onAdClose = "onAdClose";
//广告继续
const String onVideoComplete = "onVideoComplete";
//跳过广告
const String onSkippedVideo = "onSkippedVideo";

///广告加载状态 view使用
//显示view
const String onShow = "onShow";
//加载失败
const String onFail = "onFail";
//不感兴趣
const String onDislike = "onDislike";
