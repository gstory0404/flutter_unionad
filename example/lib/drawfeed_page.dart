import 'package:flutter/material.dart';
import 'package:flutter_unionad/flutter_unionad.dart' as FlutterUnionad;

/// 描述：draw视频广告
/// @author guozi
/// @e-mail gstory0404@gmail.com
/// @time   2020/3/11

class DrawFeedPage extends StatefulWidget {
  @override
  _DrawFeedPageState createState() => _DrawFeedPageState();
}

class _DrawFeedPageState extends State<DrawFeedPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.dark,
        centerTitle: true,
        title: Text(
          "draw视频广告",
        ),
      ),
      body: PageView.custom(
        scrollDirection: Axis.vertical,
        childrenDelegate: SliverChildBuilderDelegate(
          (context, index) {
            return Center(
              child: FlutterUnionad.drawFeedAdView(
                androidCodeId: "945426252", // Android draw视屏广告id 必填
                iosCodeId: "945426252", //ios draw视屏广告id 必填
                supportDeepLink: true, //是否支持 DeepLink 选填
                expressViewWidth: 600.5, // 期望view 宽度 dp 必填
                expressViewHeight: 800.5, //期望view高度 dp 必填
                callBack: (FlutterUnionad.FlutterUnionadState state) { //广告事件回调 选填
                  //type onShow显示广告 onFail广告加载失败
                  //params 详细说明
                  switch (state.type) {
                    case FlutterUnionad.onShow:
                      print(state.tojson());
                      break;
                    case FlutterUnionad.onFail:
                      print(state.tojson());
                      break;
                  }
                },
              ),
            );
          },
          childCount: 3,
        ),
      ),
    );
  }
}
