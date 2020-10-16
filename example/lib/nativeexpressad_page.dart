import 'package:flutter/material.dart';
import 'package:flutter_unionad/flutter_unionad.dart' as FlutterUnionad;

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
              androidCodeId: "945410197", //android banner广告id 必填
              iosCodeId: "945410197", //ios banner广告id 必填
              supportDeepLink: true, //是否支持 DeepLink 选填
              expressViewWidth: 600.5, // 期望view 宽度 dp 必填
              expressViewHeight: 120.5, //期望view高度 dp 必填
              callBack: (FlutterUnionad.FlutterUnionadState state) { //广告事件回调 选填
                //广告事件回调 选填
                //type onShow广告成功显示 onDislike不感兴趣 onFail广告加载失败
                //params 详细说明
                switch (state.type) {
                  case FlutterUnionad.onShow:
                    print(state.tojson());
                    break;
                  case FlutterUnionad.onFail:
                    print(state.tojson());
                    break;
                  case FlutterUnionad.onDislike:
                    print(state.tojson());
                    break;
                }
              },
            ), //个性化模板信息流广告
            FlutterUnionad.nativeAdView(
              androidCodeId: "945417487",
              iosCodeId: "945417487",
              supportDeepLink: true,
              expressViewWidth: 375.5,
              expressViewHeight: 284.5,
              callBack: (FlutterUnionad.FlutterUnionadState state) {
                //广告事件回调 选填
                //type onShow广告成功显示 onDislike不感兴趣 onFail广告加载失败
                //params 详细说明
                print("到这里 ${state.tojson()}");
                switch (state.type) {
                  case FlutterUnionad.onShow:
                    print(state.tojson());
                    break;
                  case FlutterUnionad.onFail:
                    print(state.tojson());
                    break;
                  case FlutterUnionad.onDislike:
                    print(state.tojson());
                    break;
                }
              },
            ), //个性化模板信息流广告
            FlutterUnionad.nativeAdView(
              androidCodeId: "945407034",
              iosCodeId: "945407034",
              supportDeepLink: true,
              expressViewWidth: 270,
              expressViewHeight: 480,
              callBack: (FlutterUnionad.FlutterUnionadState state) {
                //广告事件回调 选填
                //type onShow广告成功显示 onDislike不感兴趣 onFail广告加载失败
                //params 详细说明
                print("到这里 ${state.tojson()}");
                switch (state.type) {
                  case FlutterUnionad.onShow:
                    print(state.tojson());
                    break;
                  case FlutterUnionad.onFail:
                    print(state.tojson());
                    break;
                  case FlutterUnionad.onDislike:
                    print(state.tojson());
                    break;
                }
              },
            ), //个性化模板信息流广告
          ],
        ),
      ),
    );
  }
}
