import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

/// 非 OHOS Flutter SDK 降级实现
Widget createOhosPlatformView({
  required String viewType,
  required Map<String, dynamic> creationParams,
  required PlatformViewCreatedCallback onPlatformViewCreated,
}) {
  return const SizedBox.shrink();
}
