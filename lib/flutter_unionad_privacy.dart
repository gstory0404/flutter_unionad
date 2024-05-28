part of 'flutter_unionad.dart';

/// @Author: gstory
/// @CreateDate: 2024/3/21 15:42
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述

class AndroidPrivacy {
  bool? isCanUseLocation;
  double? lat;
  double? lon;
  bool? isCanUsePhoneState;
  String? imei;
  bool? isCanUseWifiState;
  String? macAddress;
  bool? isCanUseWriteExternal;
  String? oaid;
  bool? alist;
  bool? isCanUseAndroidId;
  String? androidId;
  bool? isCanUsePermissionRecordAudio;
  bool? isLimitPersonalAds;
  bool? isProgrammaticRecommend;

  ///
  ///Android隐私信息控制配置
  ///
  ///isCanUseLocation 是否允许SDK主动使用地理位置信息 true可以获取，false禁止获取。默认为true
  ///
  ///lat 当isCanUseLocation=false时，可传入地理位置信息，穿山甲sdk使用您传入的地理位置信息lat
  ///
  ///lon 当isCanUseLocation=false时，可传入地理位置信息，穿山甲sdk使用您传入的地理位置信息lon
  ///
  ///isCanUsePhoneState 是否允许SDK主动使用手机硬件参数，如：imei
  ///
  ///imei 当isCanUsePhoneState=false时，可传入imei信息，穿山甲sdk使用您传入的imei信息
  ///
  ///isCanUseWifiState 是否允许SDK主动使用ACCESS_WIFI_STATE权限
  ///
  ///macAddress 当isCanUseWifiState=false时，可传入Mac地址信息
  ///
  ///isCanUseWriteExternal 是否允许SDK主动使用WRITE_EXTERNAL_STORAGE权限
  ///
  ///oaid 开发者可以传入oaid
  ///
  ///alist 是否允许SDK主动获取设备上应用安装列表的采集权限
  ///
  ///isCanUseAndroidId 是否能获取android ID
  ///
  ///androidId 开发者可以传入android ID
  ///
  ///isCanUsePermissionRecordAudio 是否允许SDK在申明和授权了的情况下使用录音权限
  ///
  ///isLimitPersonalAds 是否限制个性化推荐接口
  ///
  ///isProgrammaticRecommend 是否启用程序化广告推荐 true启用 false不启用
  ///
  AndroidPrivacy({
    this.isCanUseLocation,
    this.lat,
    this.lon,
    this.isCanUsePhoneState,
    this.imei,
    this.isCanUseWifiState,
    this.macAddress,
    this.isCanUseWriteExternal,
    this.oaid,
    this.alist,
    this.isCanUseAndroidId,
    this.androidId,
    this.isCanUsePermissionRecordAudio,
    this.isLimitPersonalAds,
    this.isProgrammaticRecommend,
  });

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['isCanUseLocation'] = this.isCanUseLocation ?? false;
    data['lat'] = this.lat ?? 0.0;
    data['lon'] = this.lon ?? 0.0;
    data['isCanUsePhoneState'] = this.isCanUsePhoneState ?? false;
    data['imei'] = this.imei ?? "";
    data['isCanUseWifiState'] = this.isCanUseWifiState ?? false;
    data['macAddress'] = this.macAddress ?? "";
    data['isCanUseWriteExternal'] = this.isCanUseWriteExternal ?? false;
    data['oaid'] = this.oaid ?? "";
    data['alist'] = this.alist ?? false;
    data['isCanUseAndroidId'] = this.isCanUseAndroidId ?? false;
    data['androidId'] = this.androidId ?? "";
    data['isCanUsePermissionRecordAudio'] =
        this.isCanUsePermissionRecordAudio ?? false;
    data['isLimitPersonalAds'] = this.isLimitPersonalAds ?? false;
    data['isProgrammaticRecommend'] = this.isProgrammaticRecommend ?? false;
    return data;
  }
}

class IOSPrivacy {
  bool? limitPersonalAds;
  bool? limitProgrammaticAds;
  bool? forbiddenCAID;

  ///
  /// IOS隐私信息控制配置
  ///
  /// [limitPersonalAds] 允许个性化广告
  ///
  /// [limitProgrammaticAds] 允许程序化广告
  ///
  /// [forbiddenCAID] 允许CAID
  IOSPrivacy({
    this.limitPersonalAds,
    this.limitProgrammaticAds,
    this.forbiddenCAID,
  });

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['limitPersonalAds'] = this.limitPersonalAds ?? false;
    data['limitProgrammaticAds'] = this.limitProgrammaticAds ?? false;
    data['forbiddenCAID'] = this.forbiddenCAID ?? false;
    return data;
  }
}
