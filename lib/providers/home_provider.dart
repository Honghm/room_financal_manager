import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomeProviders with ChangeNotifier {
  ///define screen:
  ///1: khoản chi cá nhân
  ///2: khoản thu cá nhân
  ///3: thống kê cá nhân
  ///4: khoản chi nhóm
  ///5: tổng quan nhóm
  ///6: thông kê nhóm
  ///7: danh sách nhóm
  int _screen = 1;

  int get screen => _screen;

  set screen(int value) {
    _screen = value;
    notifyListeners();
  }

  List<ItemLoaiKhoanChi> dsLoaiKhoanChi =[];
//List<Map<String, dynamic>> dsLoaiKhoanChi = [];
  Future<void> getListLoaiKhoanChi() async {
  try{
    List<ItemLoaiKhoanChi> ds = [];
    await FirebaseFirestore.instance
        .collection('typeExpense').get().then((value) {
        value.docs.forEach((item) {
          ds.add(new ItemLoaiKhoanChi(item.data()["nameExpense"],item.data()["iconExpense"]));
        });
        dsLoaiKhoanChi = ds;
        notifyListeners();
    });
  }catch(e){

  }
}
}

class ItemLoaiKhoanChi {
  const ItemLoaiKhoanChi(this.name, this.icon);
  final String name;
  final String icon;
}