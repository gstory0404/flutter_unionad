part of 'flutter_unionad.dart';

/// @Author: gstory
/// @CreateDate: 2024/3/21 15:42
/// @Email gstory0404@gmail.com
/// @Description: 流量分组参数

class UnionadUserInfo {
  final String? userId;
  final int? age;
  final int? gender;
  final String? channel;
  final String? subChannel;
  final String? userValueGroup;
  final Map<String, String>? customInfos;

  /// 流量分组参数
  ///
  /// [userId] 设备ID。由开发者定义并传入聚合SDK，后续M支持基于设备ID维度统计数据、或针对个别设备进行测试
  ///
  /// [age] 年龄
  ///
  /// [gender] 性别 0女 1男 2未知 3不使用
  ///
  /// [channel] 渠道。建议使用以下字符规则：大小写字母数字和下划线[A-Za-z0-9_]
  ///
  /// [subChannel] 子渠道。建议使用以下字符规则：大小写字母数字和下划线[A-Za-z0-9_]
  ///
  /// [userValueGroup] 分组
  ///
  /// [customInfos] 自定义参数 Map<String, String>
  UnionadUserInfo({
    this.userId,
    this.age,
    this.gender,
    this.channel,
    this.subChannel,
    this.userValueGroup,
    this.customInfos,
  });

  Map<String, dynamic> toMap() => {
        'userId': userId ?? "",
        'age': age ?? 0,
        'gender': gender ?? 3,
        'channel': channel ?? "",
        'subChannel': subChannel ?? "",
        'userValueGroup': userValueGroup ?? "",
        'customInfos': customInfos ?? {},
      };
}
