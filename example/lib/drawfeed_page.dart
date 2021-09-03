import 'package:flutter/material.dart';
import 'package:flutter_unionad/flutter_unionad.dart';

/// 描述：draw视频广告
/// @author guozi
/// @e-mail gstory0404@gmail.com
/// @time   2020/3/11

class DrawFeedPage extends StatefulWidget {
  @override
  _DrawFeedPageState createState() => _DrawFeedPageState();
}

class _DrawFeedPageState extends State<DrawFeedPage> {
  bool _offstage = true;

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
              child: Offstage(
                offstage: _offstage,
                child: FlutterUnionad.drawFeedAdView(
                  androidCodeId: "945426252",
                  // Android draw视屏广告id 必填
                  iosCodeId: "945426252",
                  //ios draw视屏广告id 必填
                  supportDeepLink: true,
                  //是否支持 DeepLink 选填
                  expressViewWidth: 600.5,
                  // 期望view 宽度 dp 必填
                  expressViewHeight: 800.5,
                  //期望view高度 dp 必填
                  callBack: FlutterUnionadDrawFeedCallBack(
                    onShow: () {
                      print("draw广告显示");
                      setState(() => _offstage = false);
                    },
                    onFail: (error) {
                      print("draw广告加载失败 $error");
                    },
                    onClick: () {
                      print("draw广告点击");
                    },
                    onDislike: (message) {
                      print("draw点击不喜欢 $message");
                    },
                    onVideoPlay: () {
                      print("draw视频播放");
                    },
                    onVideoPause: () {
                      print("draw视频暂停");
                    },
                    onVideoStop: () {
                      print("draw视频结束");
                    },
                  ),
                ),
              ),
            );
          },
          childCount: 3,
        ),
      ),
    );
  }
}
