import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:room_financal_manager/config/initialization.dart';
import 'package:room_financal_manager/models/KhoanChiCaNhan.dart';
import 'package:room_financal_manager/models/KhoanThuCaNhan.dart';

class CaNhanProviders with ChangeNotifier {
  List<KhoanChiCaNhan> dsKhoanChiCaNhan = [];
  List<KhoanThuCaNhan> dsKhoanThuCaNhan = [];
  int _tongTien = 0;
  String _thu;
  String _ngay;
  String _nam;
  Status _status = Status.Loaded;

  Status get status => _status;

  set status(Status value) {
    _status = value;
  }

  int get tongTien => _tongTien;

  set tongTien(int value) {
    _tongTien = value;
  }

  Future<void> danhSachKhoanChi(String idCaNhan) async {
    try {
      List<KhoanChiCaNhan> ds = [];

      await FirebaseFirestore.instance
          .collection('Users/$idCaNhan/KhoanChi').get().then((value) {
        for(int i = 0; i<value.docs.length;i++){
          List<ItemKhoanChiCaNhan> dsItem = [];
          value.docs[i].reference.collection("data").get().then((item) {
            for(int j = 0; j<item.docs.length;j++){
              dsItem.add(ItemKhoanChiCaNhan.fromJson(item.docs[j].data()));
            }
            notifyListeners();
          });

          ds.add(KhoanChiCaNhan.setData(value.docs[i].data()["id"],
              value.docs[i].data()["ngayMua"],
              dsItem));
        }
        dsKhoanChiCaNhan = ds;
        notifyListeners();
      });
    }catch(e){

    }
  }
  Future<void> danhSachKhoanThu(String idCaNhan) async {
    try {
      List<KhoanThuCaNhan> ds = [];

      await FirebaseFirestore.instance
          .collection('Users/$idCaNhan/KhoanThu').get().then((value) {
        for(int i = 0; i<value.docs.length;i++){
          List<ItemKhoanThuCaNhan> dsItem = [];
          value.docs[i].reference.collection("data").get().then((item) {
            for(int j = 0; j<item.docs.length;j++){
              dsItem.add(ItemKhoanThuCaNhan.fromJson(item.docs[j].data()));
            }
            notifyListeners();
          });

          ds.add(KhoanThuCaNhan.setData(value.docs[i].data()["id"],
              value.docs[i].data()["ngayMua"],
              dsItem));
        }
        dsKhoanThuCaNhan = ds;
        notifyListeners();
      });
    }catch(e){

    }
  }
  void getDate(String date){
    List<String> dates = [];
    dates = date.split("_");

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
      case 6:
        _thu = "CN";
        break;
      case 0:
        _thu = "2";
        break;
      case 1:
        _thu = "3";
        break;
      case 2:
        _thu = "4";
        break;
      case 3:
        _thu = "5";
        break;
      case 4:
        _thu = "6";
        break;
      case 5:
        _thu = "7";
        break;
    }
  }

  String get thu => _thu;

  set thu(String value) {
    _thu = value;
  }

  String get ngay => _ngay;

  set ngay(String value) {
    _ngay = value;
  }

  String get nam => _nam;

  set nam(String value) {
    _nam = value;
  }
}
