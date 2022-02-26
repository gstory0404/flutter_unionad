import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_unionad/flutter_unionad.dart';

class BannerAdView extends StatefulWidget {
  final bool mIsExpress;
  final String androidCodeId;
  final String iosCodeId;
  final bool supportDeepLink;
  final int expressAdNum;
  final int expressTime;
  final double expressViewWidth;
  final double expressViewHeight;
  final int downloadType;
  final FlutterUnionadBannerCallBack? callBack;

  const BannerAdView(
      {Key? key,
      required this.mIsExpress,
      required this.androidCodeId,
      required this.iosCodeId,
      required this.supportDeepLink,
      required this.expressAdNum,
      required this.expressTime,
      required this.expressViewWidth,
      required this.expressViewHeight,
      required this.downloadType,
      this.callBack})
      : super(key: key);

  @override
  _BannerAdViewState createState() => _BannerAdViewState();
}

class _BannerAdViewState extends State<BannerAdView> {
  String _viewType = "com.gstory.flutter_unionad/BannerAdView";

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
    _width = widget.expressViewWidth;
    _height = widget.expressViewHeight;
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
            "mIsExpress": widget.mIsExpress,
            "androidCodeId": widget.androidCodeId,
            "supportDeepLink": widget.supportDeepLink,
            "expressViewWidth": widget.expressViewWidth,
            "expressViewHeight": widget.expressViewHeight,
            "expressAdNum": widget.expressAdNum,
            "expressTime": widget.expressTime,
            "downloadType":widget.downloadType,
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
            "mIsExpress": widget.mIsExpress,
            "iosCodeId": widget.iosCodeId,
            "supportDeepLink": widget.supportDeepLink,
            "expressViewWidth": widget.expressViewWidth,
            "expressViewHeight": widget.expressViewHeight,
            "expressAdNum": widget.expressAdNum,
            "expressTime": widget.expressTime,
            "downloadType":widget.downloadType,
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
            _width = (map["width"]).toDouble();
            _height = (map["height"]).toDouble();
          });
        }
        widget.callBack?.onShow!();
        break;
      //广告加载失败
      case FlutterUnionadMethod.onFail:
        if (mounted) {
          setState(() {
            _isShowAd = false;
          });
        }
        widget.callBack?.onFail!(call.arguments);
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
      case FlutterUnionadMethod.onClick:
        widget.callBack?.onClick!();
        break;
    }
  }
}
