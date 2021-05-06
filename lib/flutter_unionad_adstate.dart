import 'dart:core';

class FlutterUnionadState {
  String? _type;
  String? _params;

  String? get type => _type;

  String? get params => _params;

  FlutterUnionadState(String? type, String? params) {
    _type = type;
    _params = params;
  }

  FlutterUnionadState.fromjson(dynamic json) {
    _type = json["type"];
    _params = json["params"];
  }

  Map<String, dynamic> tojson() {
    var map = <String, dynamic>{};
    map["type"] = _type;
    map["params"] = _params;
    return map;
  }
}
