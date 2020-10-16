import 'dart:core';

import 'dart:core';

class FlutterUnionadState {
  String type;
  dynamic params;

  FlutterUnionadState(this.type, this.params);

  FlutterUnionadState.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    params = json['params'];
  }

  Map<String, dynamic> tojson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["type"] = type;
    data["params"] = params;
    return data;
  }
}
