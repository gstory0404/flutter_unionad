import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_unionad/flutter_unionad.dart';
import 'package:unionad_interface/unionad_interface.dart';

class FlutterUnionadNativeAdView extends StatefulWidget {
  String androidCodeId;
  String iosCodeId;
  String? ohosCodeId;
  bool? supportDeepLink;
  double width;
  double height;
  final bool isMuted;
  FlutterUnionadNativeCallBack? callBack;

  /// # 信息流广告
  FlutterUnionadNativeAdView(
      {Key? key,
      required this.androidCodeId,
      required this.iosCodeId,
      this.ohosCodeId,
      required this.supportDeepLink,
      required this.width,
      required this.height,
      this.isMuted = true,
      this.callBack})
      : super(key: key);

  @override
  _NativeAdViewState createState() {
    supportDeepLink = supportDeepLink ?? true;
    return _NativeAdViewState();
  }
}

class _NativeAdViewState extends State<FlutterUnionadNativeAdView> {
  MethodChannel? _channel;

  bool _isShowAd = true;
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
    final double viewHeight = _height == 0 ? 0.5 : _height;
    return Container(
      width: _width,
      height: viewHeight,
      child: UnionadPlatform.instance.buildNativeAdView(
        creationParams: {
          "androidCodeId": widget.androidCodeId,
          "iosCodeId": widget.iosCodeId,
          "ohosCodeId": widget.ohosCodeId,
          "supportDeepLink": widget.supportDeepLink,
          "width": widget.width,
          "height": widget.height,
          "isMuted": widget.isMuted,
        },
        width: _width,
        height: viewHeight,
        onPlatformViewCreated: _registerChannel,
      ),
    );
  }

  void _registerChannel(int id) {
    _channel =
        MethodChannel("${UnionadConstants.nativeViewType}_$id");
    _channel?.setMethodCallHandler(_platformCallHandler);
  }

  Future<dynamic> _platformCallHandler(MethodCall call) async {
    switch (call.method) {
      case FlutterUnionadMethod.onShow:
        Map map = call.arguments;
        if (mounted) {
          setState(() {
            _isShowAd = true;
            if (map["width"] > 0) {
              _width = (map["width"]).toDouble();
              _height = (map["height"]).toDouble();
            }
          });
        }
        widget.callBack?.onShow?.call();
        break;
      case FlutterUnionadMethod.onFail:
        if (mounted) {
          setState(() {
            _isShowAd = false;
          });
        }
        widget.callBack?.onFail?.call(call.arguments);
        break;
      case FlutterUnionadMethod.onDislike:
        if (mounted) {
          setState(() {
            _isShowAd = false;
          });
        }
        widget.callBack?.onDislike?.call(call.arguments);
        break;
      case FlutterUnionadMethod.onClick:
        widget.callBack?.onClick?.call();
        break;
      case FlutterUnionadMethod.onEcpm:
        widget.callBack?.onEcpm?.call(call.arguments.cast<String, dynamic>());
        break;
    }
  }
}
