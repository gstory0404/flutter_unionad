import 'package:flutter/material.dart';
import 'package:flutter_unionad/flutter_unionad.dart'as FlutterUnionad;

/// 描述：个性化模板信息流广告
/// @author guozi
/// @e-mail gstory0404@gmail.com
/// @time   2020/3/11
class NativeExpressAdPage extends StatefulWidget {
  @override
  _nativeExpressAdPageState createState() => _nativeExpressAdPageState();
}

class _nativeExpressAdPageState extends State<NativeExpressAdPage> {
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
            Container(
              height: 300,
              child: FlutterUnionad.nativeAdView(
                mCodeId: "945417699",
                supportDeepLink: true,
                expressViewWidth: 800,
                expressViewHeight: 600,
              ),
            ), //个性化模板信息流广告
            Container(
              height: 300,
              child: FlutterUnionad.nativeAdView(
                mCodeId: "945417487",
                supportDeepLink: true,
                expressViewWidth: 800,
                expressViewHeight: 600,
              ),
            ),//个性化模板信息流广告
            Container(
              height: 300,
              child: FlutterUnionad.nativeAdView(
                mCodeId: "945407034",
                supportDeepLink: true,
                expressViewWidth: 800,
                expressViewHeight: 600,
              ),
            ),//个性化模板信息流广告
            Container(
              height: 300,
              child: FlutterUnionad.nativeAdView(
                mCodeId: "945417487",
                supportDeepLink: true,
                expressViewWidth: 800,
                expressViewHeight: 600,
              ),
            ),//个性化模板信息流广告
            Container(
              height: 300,
              child: FlutterUnionad.nativeAdView(
                mCodeId: "945417487",
                supportDeepLink: true,
                expressViewWidth: 800,
                expressViewHeight: 600,
              ),
            ),//个性化模板信息流广告
            Container(
              height: 300,
              child: FlutterUnionad.nativeAdView(
                mCodeId: "945417487",
                supportDeepLink: true,
                expressViewWidth: 800,
                expressViewHeight: 600,
              ),
            ),//个性化模板信息流广告
            Container(
              height: 300,
              child: FlutterUnionad.nativeAdView(
                mCodeId: "945417487",
                supportDeepLink: true,
                expressViewWidth: 800,
                expressViewHeight: 600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
