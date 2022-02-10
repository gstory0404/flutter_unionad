import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_unionad/flutter_unionad.dart';

class NativeAdView extends StatefulWidget {
  final bool mIsExpress;
  final String androidCodeId;
  final String iosCodeId;
  final bool supportDeepLink;
  final double expressViewWidth;
  final double expressViewHeight;
  final int expressNum;
  final int downloadType;
  final bool? iosIsUserInteractionEnabled;
  final FlutterUnionadNativeCallBack? callBack;

  const NativeAdView({Key? key,
    required this.mIsExpress,
    required this.androidCodeId,
    required this.iosCodeId,
    required this.supportDeepLink,
    required this.expressViewWidth,
    required this.expressViewHeight,
    required this.expressNum,
    required this.downloadType,
    this.iosIsUserInteractionEnabled,
    this.callBack,
  }) : super(key: key);

  @override
  _NativeAdViewState createState() => _NativeAdViewState();
}

class _NativeAdViewState extends State<NativeAdView> {
  String _viewType = "com.gstory.flutter_unionad/NativeAdView";

  MethodChannel? _channel;

  //广告是否显示
  bool _isShowAd = true;

  @override
  void initState() {
    super.initState();
    _isShowAd = true;
  }

  @override
  Widget build(BuildContext context) {
    if (!_isShowAd) {
      return Container();
    }
    if (defaultTargetPlatform == TargetPlatform.android) {
      return Container(
        width: widget.expressViewWidth,
        height: widget.expressViewHeight,
        child: AndroidView(
          viewType: _viewType,
          creationParams: {
            "mIsExpress": widget.mIsExpress,
            "androidCodeId": widget.androidCodeId,
            "supportDeepLink": widget.supportDeepLink,
            "expressViewWidth": widget.expressViewWidth,
            "expressViewHeight": widget.expressViewHeight,
            "expressNum":widget.expressNum,
            "downloadType":widget.downloadType,
          },
          onPlatformViewCreated: _registerChannel,
          creationParamsCodec: const StandardMessageCodec(),
        ),
      );
    } else if (defaultTargetPlatform == TargetPlatform.iOS) {
      Widget iosContainer = Container(
        width: widget.expressViewWidth,
        height: widget.expressViewHeight,
        child: UiKitView(
          viewType: _viewType,
          creationParams: {
            "mIsExpress": widget.mIsExpress,
            "iosCodeId": widget.iosCodeId,
            "supportDeepLink": widget.supportDeepLink,
            "expressViewWidth": widget.expressViewWidth,
            "expressViewHeight": widget.expressViewHeight,
            "expressNum":widget.expressNum,
            "downloadType":widget.downloadType,
          },
          onPlatformViewCreated: _registerChannel,
          creationParamsCodec: const StandardMessageCodec(),
        ),
      );

      if (widget.iosIsUserInteractionEnabled != null) {
        // 当广告所在页面被压入底层之后，调用尽管setState，UiKitView仍不会重新初始化，故发送消息更新一下，确保状态正常
        sendMsgToNative('iosIsUserInteractionEnabled', body: {
          'iosIsUserInteractionEnabled': widget.iosIsUserInteractionEnabled
        });
      }
      return iosContainer;
    } else {
      return Container();
    }
  }

  //注册cannel
  void _registerChannel(int id) {
    _channel = MethodChannel("${_viewType}_$id");
    _channel?.setMethodCallHandler(_platformCallHandler);
  }

  Future sendMsgToNative(String name, {Object? body}) async {
    try {
      var result = await _channel?.invokeMethod(name, body);
      return result;
    } on PlatformException catch (e) {
      Future fut = Future.error(e.toString());
      FlutterError.reportError(FlutterErrorDetails(exception: e));
      return fut;
    }
  }

  //监听原生view传值
  Future<dynamic> _platformCallHandler(MethodCall call) async {
    switch (call.method) {
    //显示广告
      case FlutterUnionadMethod.onShow:
        if (widget.callBack != null) {
          widget.callBack?.onShow!();
        }
        break;
    //广告加载失败
      case FlutterUnionadMethod.onFail:
        if (mounted) {
          setState(() {
            _isShowAd = false;
          });
        }
        if (widget.callBack != null) {
          widget.callBack?.onFail!(call.arguments);
        }
        break;
    //广告不感兴趣
      case FlutterUnionadMethod.onDislike:
        if (mounted) {
          setState(() {
            _isShowAd = false;
          });
        }
        if (widget.callBack != null) {
          widget.callBack?.onDislike!(call.arguments);
        }
        break;
        //点击
      case FlutterUnionadMethod.onClick:
        if (widget.callBack != null) {
          widget.callBack?.onClick!();
        }
        break;
    }
  }
}
