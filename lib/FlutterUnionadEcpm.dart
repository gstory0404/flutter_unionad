/// @Author: gstory
/// @CreateDate: 2025/3/12 15:43
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述

class FlutterUnionadEcpm {
  String? adnName;
  String? customAdnName;
  String? slotID;
  String? levelTag;
  String? ecpm;
  int? biddingType;
  String? errorMsg;
  String? requestID;
  String? creativeID;
  String? adRitType;
  String? segmentId;
  String? abtestId;
  String? channel;
  String? subChannel;
  String? scenarioId;
  String? subRitType;

  FlutterUnionadEcpm(
      {this.adnName,
        this.customAdnName,
        this.slotID,
        this.levelTag,
        this.ecpm,
        this.biddingType,
        this.errorMsg,
        this.requestID,
        this.creativeID,
        this.adRitType,
        this.segmentId,
        this.abtestId,
        this.channel,
        this.subChannel,
        this.scenarioId,
        this.subRitType});

  FlutterUnionadEcpm.fromJson(Map<String, dynamic> json) {
    adnName = json['adnName'];
    customAdnName = json['customAdnName'];
    slotID = json['slotID'];
    levelTag = json['levelTag'];
    ecpm = json['ecpm'];
    biddingType = json['biddingType'];
    errorMsg = json['errorMsg'];
    requestID = json['requestID'];
    creativeID = json['creativeID'];
    adRitType = json['adRitType'];
    segmentId = json['segmentId'];
    abtestId = json['abtestId'];
    channel = json['channel'];
    subChannel = json['sub_channel'];
    scenarioId = json['scenarioId'];
    subRitType = json['subRitType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['adnName'] = this.adnName;
    data['customAdnName'] = this.customAdnName;
    data['slotID'] = this.slotID;
    data['levelTag'] = this.levelTag;
    data['ecpm'] = this.ecpm;
    data['biddingType'] = this.biddingType;
    data['errorMsg'] = this.errorMsg;
    data['requestID'] = this.requestID;
    data['creativeID'] = this.creativeID;
    data['adRitType'] = this.adRitType;
    data['segmentId'] = this.segmentId;
    data['abtestId'] = this.abtestId;
    data['channel'] = this.channel;
    data['sub_channel'] = this.subChannel;
    data['scenarioId'] = this.scenarioId;
    data['subRitType'] = this.subRitType;
    return data;
  }
}