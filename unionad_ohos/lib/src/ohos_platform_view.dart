import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'ohos_platform_view_io.dart' as impl;

/// 构建鸿蒙 PlatformView（依赖 OpenHarmony Flutter SDK 的 [OhosView]）
Widget buildOhosPlatformView({
  required String viewType,
  required Map<String, dynamic> creationParams,
  required PlatformViewCreatedCallback onPlatformViewCreated,
}) {
  return impl.createOhosPlatformView(
    viewType: viewType,
    creationParams: creationParams,
    onPlatformViewCreated: onPlatformViewCreated,
  );
}
