import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_unionad/flutter_unionad.dart';

class FlutterUnionadDrawFeedAdView extends StatefulWidget {
  final String androidCodeId;
  final String iosCodeId;
  final double width;
  final double height;
  final bool isMuted;
  final FlutterUnionadDrawFeedCallBack? callBack;

  const FlutterUnionadDrawFeedAdView(
      {Key? key,
      required this.androidCodeId,
      required this.iosCodeId,
      required this.width,
      required this.height,
      this.isMuted = true,
      this.callBack})
      : super(key: key);

  @override
  _DrawFeedAdViewState createState() => _DrawFeedAdViewState();
}

class _DrawFeedAdViewState extends State<FlutterUnionadDrawFeedAdView> {
  String _viewType = "com.gstory.flutter_unionad/DrawFeedAdView";

  MethodChannel? _channel;

  //广告是否显示
  bool _isShowAd = true;

  //宽高
  double _width = 0;
  double _height = 0;

  @override
  void initState() {
    super.initState();
    _isShowAd = true;
    _width = widget.width;
    _height = widget.height;
  }

  @override
  Widget build(BuildContext context) {
    if (!_isShowAd) {
      return Container();
    }
    if (defaultTargetPlatform == TargetPlatform.android) {
      return Container(
        width: _width,
        height: _height,
        child: AndroidView(
          viewType: _viewType,
          creationParams: {
            "androidCodeId": widget.androidCodeId,
            "width": widget.width,
            "height": widget.height,
            "isMuted": widget.isMuted,
          },
          onPlatformViewCreated: _registerChannel,
          creationParamsCodec: const StandardMessageCodec(),
        ),
      );
    } else if (defaultTargetPlatform == TargetPlatform.iOS) {
      return Container(
        width: _width,
        height: _height,
        child: UiKitView(
          viewType: _viewType,
          creationParams: {
            "iosCodeId": widget.iosCodeId,
            "width": widget.width,
            "height": widget.height,
            "isMuted": widget.isMuted,
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
    switch (call.method) {
      //显示广告
      case FlutterUnionadMethod.onShow:
        Map map = call.arguments;
        if (mounted) {
          setState(() {
            _isShowAd = true;
            if(map["width"] > 0){
              _width = (map["width"]).toDouble();
              _height = (map["height"]).toDouble();
            }
          });
        }
        widget.callBack?.onShow?.call();
        break;
      //广告加载失败
      case FlutterUnionadMethod.onFail:
        widget.callBack?.onFail?.call(call.arguments);
        setState(() {
          _isShowAd = false;
        });
        break;
      case FlutterUnionadMethod.onClick:
        widget.callBack?.onClick?.call();
        break;
      case FlutterUnionadMethod.onVideoPlay:
        widget.callBack?.onVideoPlay?.call();
        break;
      case FlutterUnionadMethod.onVideoPause:
        widget.callBack?.onVideoPause?.call();
        break;
      case FlutterUnionadMethod.onVideoStop:
        widget.callBack?.onVideoStop?.call();
        break;
      case FlutterUnionadMethod.onEcpm:
        widget.callBack?.onEcpm?.call(call.arguments.cast<String, dynamic>());
        break;
    }
  }
}
