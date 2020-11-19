import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:room_financal_manager/config/initialization.dart';
import 'package:room_financal_manager/models/expendituresGroup.dart';

class GroupProviders with ChangeNotifier {

  int _tongTien = 0;
  String _thu;
  String _ngay;
  String _nam;
  int _lenghtKhoanChi = 0;
 Status _status = Status.Loaded;
  int get lenghtKhoanChi => _lenghtKhoanChi;
  List<Map<String, dynamic>> listItemKhoanChi = [];
  List<ExpendituresGroup> list = [];
  Status get status => _status;

  set status(Status value) {
    _status = value;
  }
  Future<List<ExpendituresGroup>> getItemKhoanChi(String id) async {
    try{
      _status = Status.Loading;
      notifyListeners();
      await FirebaseFirestore.instance
          .collection('Groups/Penhouse/expenditures').doc(id)
          .get().then((item) {
        list.clear();
        _tongTien = 0;
        item.data()["data"].forEach((key, value) {
          list.add(ExpendituresGroup.fromJson(value));
          _tongTien += int.parse(value["giaTien"]);
        });
        notifyListeners();
        getDate(item.data()["ngayMua"]);
        notifyListeners();

      });
      _status = Status.Loaded;
      notifyListeners();
      return list;
    }catch(e){

    }
  }



  Map<String,String> listId = {};
  Future<List<Map<String, dynamic>>> getListKhoanChi(String idGroup) async {

      List<Map<String, dynamic>> listKhoanChi = [];
    try {
      await FirebaseFirestore.instance
          .collection('Groups/${idGroup}/expenditures').get().then((value) {
            for(int i = 0; i<value.docs.length;i++){
              listKhoanChi.add(value.docs[i].data());
              getDate(value.docs[i].data()["ngayMua"]);
            }
      });
    }
    catch (e) {
      print(e);
    }
      return listKhoanChi;
  }
  Future<String> getNameById(String id) async {
  String name = "";
  try{
    await FirebaseFirestore.instance.collection("Users").doc(id).get().then((value) {
      name = value.data()["name"];
      return name;
    });
  }catch(e){
    print(e);
  }
  return name;
  }

  Future<List<Map<String, dynamic>>> getListGroup() async{
    List<Map<String, dynamic>> listGroup = [];
      try{
        // _status = Status.Loading;
        // notifyListeners();
        await FirebaseFirestore.instance.collection("Groups").get().then((data) {
          data.docs.forEach((item) {
            print("run here: ${item.data()}");
            listGroup.add(item.data());
          });
          notifyListeners();
        });
        // _status = Status.Loaded;
        // notifyListeners();
        // print("run here 1: ${listGroup[0]}");
        return listGroup;
      }catch(e){
        print("error: $e");
      }
  }
  String get nam => _nam;

  String get ngay => _ngay;

  String get thu => _thu;

  int get tongTien => _tongTien;
  void getDate(String date){
    List<String> dates = [];
    dates = date.split("/");

    _ngay = dates[0]+"/"+dates[1];
    _nam = dates[2];
    double dd = double.parse(dates[0]);
    double mm = double.parse(dates[1]);
    double yyyy  =double.parse(dates[2]);
    int JMD = ((dd  + ((153 * (mm + 12 * ((14 - mm) / 12) - 3) + 2) / 5) +
        (365 * (yyyy + 4800 - ((14 - mm) / 12))) +
        ((yyyy + 4800 - ((14 - mm) / 12)) / 4) -
        ((yyyy + 4800 - ((14 - mm) / 12)) / 100) +
        ((yyyy + 4800 - ((14 - mm) / 12)) / 400)  - 32045) % 7).toInt();
    switch (JMD) {
      case 0:
       _thu = "CN";
       break;
      case 1:
        _thu = "2";
        break;
      case 2:
        _thu = "3";
        break;
      case 3:
        _thu = "4";
        break;
      case 4:
        _thu = "5";
        break;
      case 5:
        _thu = "6";
        break;
      case 6:
        _thu = "7";
        break;
    }
  }
}