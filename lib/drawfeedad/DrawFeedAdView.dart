import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_unionad/flutter_unionad.dart';
import 'package:flutter_unionad/flutter_unionad_adstate.dart';
import 'package:flutter_unionad/flutter_unionad_code.dart';

class DrawFeedAdView extends StatefulWidget {
  final bool mIsExpress;
  final String androidCodeId;
  final String iosCodeId;
  final bool supportDeepLink;
  final double expressViewWidth;
  final double expressViewHeight;
  final DrawFeedAdCallBack? callBack;

  const DrawFeedAdView(
      {Key? key,
      required this.mIsExpress,
      required this.androidCodeId,
      required this.iosCodeId,
      required this.supportDeepLink,
      required this.expressViewWidth,
      required this.expressViewHeight,
      this.callBack})
      : super(key: key);

  @override
  _DrawFeedAdViewState createState() => _DrawFeedAdViewState();
}

class _DrawFeedAdViewState extends State<DrawFeedAdView> {
  String _viewType = "com.gstory.flutter_unionad/DrawFeedAdView";

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
          },
          onPlatformViewCreated: _registerChannel,
          creationParamsCodec: const StandardMessageCodec(),
        ),
      );
    } else if (defaultTargetPlatform == TargetPlatform.iOS) {
      return Container(
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
          },
          onPlatformViewCreated: _registerChannel,
          creationParamsCodec: const StandardMessageCodec(),
        ),
      );
    } else {
      return Container();
    }
  }

  //注册cannel
  void _registerChannel(int id) {
    _channel = MethodChannel("${_viewType}_$id");
    _channel?.setMethodCallHandler(_platformCallHandler);
  }

  //监听原生view传值
  Future<dynamic> _platformCallHandler(MethodCall call) async {
    print("====> ${call.method}   ${call.arguments}");
    switch (call.method) {
      //显示广告
      case OnAdMethod.onShow:
        if (widget.callBack != null) {
          widget.callBack?.onShow!();
        }
        break;
      //广告加载失败
      case OnAdMethod.onFail:
        if (widget.callBack != null) {
          widget.callBack?.onFail!(call.arguments);
        }
        setState(() {
          _isShowAd = false;
        });
        break;
      case OnAdMethod.onClick:
        widget.callBack?.onClick!();
        break;
      case OnAdMethod.onVideoPlay:
        widget.callBack?.onVideoPlay!();
        break;
      case OnAdMethod.onVideoPause:
        widget.callBack?.onVideoPause!();
        break;
      case OnAdMethod.onVideoStop:
        widget.callBack?.onVideoStop!();
        break;
    }
  }
}
