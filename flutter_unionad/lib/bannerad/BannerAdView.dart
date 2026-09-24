import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_unionad/flutter_unionad.dart';
import 'package:unionad_interface/unionad_interface.dart';

class FlutterUnionadBannerView extends StatefulWidget {
  /// 广告位 id（由调用方按当前平台传入对应 id）
  final String codeId;
  final double width;
  final double height;
  final FlutterUnionadBannerCallBack? callBack;

  /// # banner广告
  ///
  /// [codeId] 广告位 id 必填
  ///
  /// [width] 期望view宽度 dp 必填
  ///
  /// [height] 期望view高度 dp 必填
  ///
  /// [FlutterUnionAdBannerCallBack]  banner广告回调
  ///
  FlutterUnionadBannerView(
      {Key? key,
      required this.codeId,
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
          "codeId": widget.codeId,
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
