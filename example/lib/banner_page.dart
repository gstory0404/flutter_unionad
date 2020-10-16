import 'package:flutter/material.dart';
import 'package:flutter_unionad/flutter_unionad.dart' as FlutterUnionad;

/// 描述：
/// @author guozi
/// @e-mail gstory0404@gmail.com
/// @time   2020/3/11

class BannerPage extends StatefulWidget {
  @override
  _BannerPageState createState() => _BannerPageState();
}

class _BannerPageState extends State<BannerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.dark,
        centerTitle: true,
        title: Text(
          "banner广告",
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        reverse: false,
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            //banner广告
            FlutterUnionad.bannerAdView(
                androidCodeId: "945410197", //andrrid banner广告id 必填
                iosCodeId: "945410197", //ios banner广告id 必填
                supportDeepLink: true, //是否支持 DeepLink 选填
                expressAdNum: 3, //一次请求广告数量 大于1小于3 选填
                expressTime: 30, //轮播间隔事件 秒  选填
                expressViewWidth: 600.5, // 期望view 宽度 dp 必填
                expressViewHeight: 120.5, //期望view高度 dp 必填
                callBack: (FlutterUnionad.FlutterUnionadState state) { //广告事件回调 选填
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
                }),
            FlutterUnionad.bannerAdView(
                androidCodeId: "945481613",
                iosCodeId: "945481613",
                supportDeepLink: true,
                expressAdNum: 3,
                expressTime: 30,
                expressViewWidth: 600,
                expressViewHeight: 200,
            ),
            FlutterUnionad.bannerAdView(
                androidCodeId: "945410197",
                iosCodeId: "945410197",
                supportDeepLink: true,
                expressAdNum: 3,
                expressTime: 30,
                expressViewWidth: 500,
                expressViewHeight: 150,
            ),
            FlutterUnionad.bannerAdView(
              androidCodeId: "945410197",
              iosCodeId: "945410197",
              supportDeepLink: true,
              expressAdNum: 3,
              expressTime: 30,
              expressViewWidth: 600,
              expressViewHeight: 180,
            ),
          ],
        ),
      ),
    );
  }
}
