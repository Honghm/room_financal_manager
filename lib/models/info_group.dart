

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:room_financal_manager/models/user.dart';

class InformationGroup{
  String id;
  String idCreator;
  String nameGroup;
  String avatar;
  String groupFunds;
  List<String> members = [];
  Map<String, dynamic> detailMoney = {};

  InformationGroup.fromJson(Map<String, dynamic> parsedJson){
    id = parsedJson["id"];
    idCreator = parsedJson["idCreator"];
    nameGroup = parsedJson["name"];
    avatar = parsedJson["avatar"];
    groupFunds = parsedJson["group_funds"].toString();
    members =  List.castFrom(parsedJson["member"]);
    detailMoney = parsedJson["detail_money"];
  }
}