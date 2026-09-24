import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_unionad/flutter_unionad.dart';
import 'package:unionad_interface/unionad_interface.dart';

class FlutterUnionadDrawFeedAdView extends StatefulWidget {
  final String androidCodeId;
  final String iosCodeId;
  final String? ohosCodeId;
  final double width;
  final double height;
  final bool isMuted;
  final FlutterUnionadDrawFeedCallBack? callBack;

  const FlutterUnionadDrawFeedAdView(
      {Key? key,
      required this.androidCodeId,
      required this.iosCodeId,
      this.ohosCodeId,
      required this.width,
      required this.height,
      this.isMuted = true,
      this.callBack})
      : super(key: key);

  @override
  _DrawFeedAdViewState createState() => _DrawFeedAdViewState();
}

class _DrawFeedAdViewState extends State<FlutterUnionadDrawFeedAdView> {
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
    return Container(
      width: _width,
      height: _height,
      child: UnionadPlatform.instance.buildDrawFeedAdView(
        creationParams: {
          "androidCodeId": widget.androidCodeId,
          "iosCodeId": widget.iosCodeId,
          "ohosCodeId": widget.ohosCodeId,
          "width": widget.width,
          "height": widget.height,
          "isMuted": widget.isMuted,
        },
        width: _width,
        height: _height,
        onPlatformViewCreated: _registerChannel,
      ),
    );
  }

  void _registerChannel(int id) {
    _channel =
        MethodChannel("${UnionadConstants.drawFeedViewType}_$id");
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
