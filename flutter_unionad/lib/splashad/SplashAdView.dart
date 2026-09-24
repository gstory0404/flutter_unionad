part of 'package:flutter_unionad/flutter_unionad.dart';

class FlutterUnionadSplashAdView extends StatefulWidget {
  String androidCodeId;
  String iosCodeId;
  String? ohosCodeId;
  bool? supportDeepLink;
  double? width;
  double? height;
  int? timeout;
  bool? hideSkip;
  bool? isShake;
  FlutterUnionadSplashCallBack? callBack;

  /// # 开屏广告
  FlutterUnionadSplashAdView({
    Key? key,
    required this.androidCodeId,
    required this.iosCodeId,
    this.ohosCodeId,
    this.supportDeepLink,
    this.width,
    this.height,
    this.timeout,
    this.hideSkip,
    this.callBack,
    this.isShake = false,
  }) : super(key: key);

  @override
  _SplashAdViewState createState() {
    supportDeepLink = supportDeepLink ?? true;
    timeout = timeout ?? 3000;
    hideSkip = hideSkip ?? false;
    return _SplashAdViewState();
  }
}

class _SplashAdViewState extends State<FlutterUnionadSplashAdView> {
  MethodChannel? _channel;

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
    final double width = widget.width ?? MediaQuery.of(context).size.width;
    final double height = widget.height ?? MediaQuery.of(context).size.height;
    return Container(
      width: width,
      height: height,
      child: UnionadPlatform.instance.buildSplashAdView(
        creationParams: {
          "androidCodeId": widget.androidCodeId,
          "iosCodeId": widget.iosCodeId,
          "ohosCodeId": widget.ohosCodeId,
          "supportDeepLink": widget.supportDeepLink,
          "width": width,
          "height": height,
          "timeout": widget.timeout,
          "hideSkip": widget.hideSkip,
          "isShake": widget.isShake,
        },
        width: width,
        height: height,
        onPlatformViewCreated: _registerChannel,
      ),
    );
  }

  void _registerChannel(int id) {
    _channel =
        MethodChannel("${UnionadConstants.splashViewType}_$id");
    _channel?.setMethodCallHandler(_platformCallHandler);
  }

  Future<dynamic> _platformCallHandler(MethodCall call) async {
    switch (call.method) {
      case FlutterUnionadMethod.onShow:
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
      case FlutterUnionadMethod.onClick:
        widget.callBack?.onClick?.call();
        break;
      case FlutterUnionadMethod.onSkip:
        widget.callBack?.onSkip?.call();
        break;
      case FlutterUnionadMethod.onFinish:
        widget.callBack?.onFinish?.call();
        break;
      case FlutterUnionadMethod.onTimeOut:
        if (mounted) {
          setState(() {
            _isShowAd = false;
          });
        }
        widget.callBack?.onTimeOut?.call();
        break;
      case FlutterUnionadMethod.onEcpm:
        widget.callBack?.onEcpm?.call(call.arguments.cast<String, dynamic>());
        break;
    }
  }
}
