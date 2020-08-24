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
              child: FlutterUnionad.drawFeedExpressAdView(
                  mCodeId: "945426252",
                  supportDeepLink: true,
                  expressViewWidth: 1080,
                  expressViewHeight: 1920),
            );
          },
          childCount: 10,
        ),
      ),
    );
  }
}
