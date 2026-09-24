import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

/// OHOS Flutter SDK 实现（依赖 [OhosView]）
Widget createOhosPlatformView({
  required String viewType,
  required Map<String, dynamic> creationParams,
  required PlatformViewCreatedCallback onPlatformViewCreated,
}) {
  return OhosView(
    viewType: viewType,
    creationParams: creationParams,
    onPlatformViewCreated: onPlatformViewCreated,
    creationParamsCodec: const StandardMessageCodec(),
  );
}
