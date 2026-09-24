import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_unionad/flutter_unionad.dart';
import 'package:unionad_interface/unionad_interface.dart';

class FlutterUnionadBannerView extends StatefulWidget {
  final String androidCodeId;
  final String iosCodeId;
  final String? ohosCodeId;
  final double width;
  final double height;
  final FlutterUnionadBannerCallBack? callBack;

  /// # banner广告
  ///
  /// [androidCodeId] android banner广告id 必填
  ///
  /// [iosCodeId] ios banner广告id 必填
  ///
  /// [ohosCodeId] 鸿蒙 banner广告id 选填
  ///
  /// [width] 期望view宽度 dp 必填
  ///
  /// [height] 期望view高度 dp 必填
  ///
  /// [FlutterUnionAdBannerCallBack]  banner广告回调
  ///
  FlutterUnionadBannerView(
      {Key? key,
      required this.androidCodeId,
      required this.iosCodeId,
      this.ohosCodeId,
      required this.width,
      required this.height,
      this.callBack})
      : super(key: key);

  @override
  _BannerAdViewState createState() => _BannerAdViewState();
}

class _BannerAdViewState extends State<FlutterUnionadBannerView> {
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
      child: UnionadPlatform.instance.buildBannerAdView(
        creationParams: {
          "androidCodeId": widget.androidCodeId,
          "iosCodeId": widget.iosCodeId,
          "ohosCodeId": widget.ohosCodeId,
          "width": widget.width,
          "height": widget.height,
        },
        width: _width,
        height: _height,
        onPlatformViewCreated: _registerChannel,
      ),
    );
  }

  void _registerChannel(int id) {
    _channel =
        MethodChannel("${UnionadConstants.bannerViewType}_$id");
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
