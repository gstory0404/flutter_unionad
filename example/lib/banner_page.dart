import 'package:flutter/material.dart';
import 'package:flutter_unionad/flutter_unionad.dart';

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
    print("banner广告");
    return Scaffold(
      appBar: AppBar(
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
              //andrrid banner广告id 必填
              androidCodeId: "945410197",
              //ios banner广告id 必填
              iosCodeId: "945410197",
              //是否使用个性化模版
              mIsExpress: true,
              //是否支持 DeepLink 选填
              supportDeepLink: true,
              //一次请求广告数量 大于1小于3 必填
              expressAdNum: 3,
              //轮播间隔事件 30-120秒  选填
              expressTime: 30,
              // 期望view 宽度 dp 必填
              expressViewWidth: 600.5,
              //期望view高度 dp 必填
              expressViewHeight: 120.5,
              //控制下载APP前是否弹出二次确认弹窗
              downloadType: FlutterUnionadDownLoadType.DOWNLOAD_TYPE_POPUP,
              //用于标注此次的广告请求用途为预加载（当做缓存）还是实时加载，
              adLoadType: FlutterUnionadLoadType.LOAD,
              //是否启用点击
              isUserInteractionEnabled: true,
              //广告事件回调 选填
              callBack: FlutterUnionadBannerCallBack(onShow: () {
                print("banner广告加载完成");
              }, onDislike: (message) {
                print("banner不感兴趣 $message");
              }, onFail: (error) {
                print("banner广告加载失败 $error");
              }, onClick: () {
                print("banner广告点击");
              }),
            ),
            FlutterUnionad.bannerAdView(
              androidCodeId: "945481613",
              iosCodeId: "945481613",
              supportDeepLink: true,
              expressAdNum: 3,
              expressTime: 40,
              expressViewWidth: 600,
              expressViewHeight: 200,
              isUserInteractionEnabled: false,
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
              expressTime: 50,
              expressViewWidth: 600,
              expressViewHeight: 180,
            ),
          ],
        ),
      ),
    );
  }
}
