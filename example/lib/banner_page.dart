import 'package:flutter/material.dart';
import 'package:flutter_unionad/flutter_unionad.dart'as FlutterUnionad;

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
        child:  Column(
          children: [
            //banner广告
            Container(
              height: 90,
              color: Colors.red,
              child: FlutterUnionad.bannerAdView(
                mCodeId: "945410197",
                supportDeepLink: true,
                expressAdNum: 3,
                expressTime: 30,
                expressViewWidth: 600,
                expressViewHeight: 90,
              ),
            ),
            Container(
              height: 200,
              color: Colors.yellow,
              child: FlutterUnionad.bannerAdView(
                mCodeId: "945481613",
                supportDeepLink: true,
                expressAdNum: 3,
                expressTime: 30,
                expressViewWidth: 600,
                expressViewHeight: 200,
              ),
            ),
            Container(
              height: 150,
              child: FlutterUnionad.bannerAdView(
                mCodeId: "945410197",
                supportDeepLink: true,
                expressAdNum: 3,
                expressTime: 30,
                expressViewWidth: 500,
                expressViewHeight: 150,
              ),
            ),
            Container(
              height: 180,
              child: FlutterUnionad.bannerAdView(
                mCodeId: "945410197",
                supportDeepLink: true,
                expressAdNum: 3,
                expressTime: 30,
                expressViewWidth: 600,
                expressViewHeight: 180,
              ),
            ),
            Container(
              height: 200,
              child: FlutterUnionad.bannerAdView(
                mCodeId: "945410197",
                supportDeepLink: true,
                expressAdNum: 3,
                expressTime: 30,
                expressViewWidth: 1080,
                expressViewHeight: 400,
              ),
            ),
            Container(
              height: 200,
              child: FlutterUnionad.bannerAdView(
                mCodeId: "945410197",
                supportDeepLink: true,
                expressAdNum: 3,
                expressTime: 30,
                expressViewWidth: 1080,
                expressViewHeight: 400,
              ),
            ),
            Container(
              height: 200,
              child: FlutterUnionad.bannerAdView(
                mCodeId: "945410197",
                supportDeepLink: true,
                expressAdNum: 3,
                expressTime: 30,
                expressViewWidth: 1080,
                expressViewHeight: 400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
