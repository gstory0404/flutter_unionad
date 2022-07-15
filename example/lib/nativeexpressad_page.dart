import 'package:flutter/material.dart';
import 'package:flutter_unionad/flutter_unionad.dart';

/// 描述：个性化模板信息流广告
/// @author guozi
/// @e-mail gstory0404@gmail.com
/// @time   2020/3/11
class NativeExpressAdPage extends StatefulWidget {
  @override
  _NativeExpressAdPageState createState() => _NativeExpressAdPageState();
}

class _NativeExpressAdPageState extends State<NativeExpressAdPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.dark,
        centerTitle: true,
        title: Text(
          "个性化模板信息流广告",
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        reverse: false,
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            //个性化模板信息流广告
            FlutterUnionad.nativeAdView(
              //android 信息流广告id 必填
              androidCodeId: "945417699",
              //ios banner广告id 必填
              iosCodeId: "945417699",
              //是否支持 DeepLink 选填
              supportDeepLink: true,
              // 期望view 宽度 dp 必填
              expressViewWidth: 375.5,
              //期望view高度 dp 必填
              expressViewHeight: 0,
              //一次请求广告数量 大于1小于3 必填
              expressNum: 2,
              mIsExpress: true,
              //控制下载APP前是否弹出二次确认弹窗
              downloadType: FlutterUnionadDownLoadType.DOWNLOAD_TYPE_POPUP,
              //是否启用点击 仅ios生效 默认启用
              isUserInteractionEnabled: true,
              //用于标注此次的广告请求用途为预加载（当做缓存）还是实时加载，
              adLoadType: FlutterUnionadLoadType.LOAD,
              callBack: FlutterUnionadNativeCallBack(
                onShow: () {
                  print("信息流广告显示");
                },
                onFail: (error) {
                  print("信息流广告失败 $error");
                },
                onDislike: (message) {
                  print("信息流广告不感兴趣 $message");
                },
                onClick: () {
                  print("信息流广告点击");
                },
              ),
            ), //个性化模板信息流广告
            FlutterUnionad.nativeAdView(
              androidCodeId: "945417487",
              iosCodeId: "945417487",
              supportDeepLink: true,
              expressViewWidth: 375.5,
              expressViewHeight: 0,
              expressNum: 3,
              isUserInteractionEnabled: false,
            ), //个性化模板信息流广告
            FlutterUnionad.nativeAdView(
              androidCodeId: "945407034",
              iosCodeId: "945407034",
              supportDeepLink: true,
              expressViewWidth: 270,
              expressViewHeight:0,
              expressNum: 3,
            ), //个性化模板信息流广告
            FlutterUnionad.nativeAdView(
              androidCodeId: "945407034",
              iosCodeId: "945407034",
              supportDeepLink: true,
              expressViewWidth: 270,
              expressViewHeight: 0,
              expressNum: 3,
            ),
          ],
        ),
      ),
    );
  }
}
