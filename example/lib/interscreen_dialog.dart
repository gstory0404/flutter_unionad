import 'package:flutter/material.dart';
import 'package:flutter_unionad/flutter_unionad.dart';

/// 描述：
/// @author guozi
/// @e-mail gstory0404@gmail.com
/// @time   2020/3/11
class InterScreenDialog extends StatefulWidget {
  @override
  _InterScreenDialogState createState() => _InterScreenDialogState();
}

class _InterScreenDialogState extends State<InterScreenDialog> {
  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Center(
        child: Container(
          alignment: Alignment.center,
          color: Colors.red,
          height: 500,
          child: Center(
//            child: FlutterUnionad.interactionExpressAdView(
//              mCodeId: "945417892",
//              supportDeepLink: true,
//              expressViewWidth: 800,
//              expressViewHeight: 1200,
//            ),
          ),
        ),
      ),
    );
  }
}

