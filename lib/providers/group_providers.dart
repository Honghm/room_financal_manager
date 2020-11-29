import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:room_financal_manager/config/initialization.dart';
import 'package:room_financal_manager/models/KhoanChiNhom.dart';


class GroupProviders with ChangeNotifier {

  ///Variable definition
  int _tongTien = 0;
  String _thu;
  String _ngay;
  String _nam;
  int _lenghtKhoanChi = 0;
 Status _status = Status.Loaded;
  List<Map<String, dynamic>> listItemKhoanChi = [];
  Map<String,String> listId = {};
  bool _listGroupShow = true;
  String _idGroup = "";
  List<String> _listMember = [];
  Map<String, String> _listMembers = {};

  KhoanChiNhom khoanChiNhom;
  List<KhoanChiNhom> dsKhoanChiNhom = [];

  /// Getter&Setter
  int get lenghtKhoanChi => _lenghtKhoanChi;
  List<String> get listMember => _listMember;
  Status get status => _status;

  set status(Status value) {
    _status = value;
  }
  bool get listGroupShow => _listGroupShow;

  set listGroupShow(bool value) {
    _listGroupShow = value;
    notifyListeners();
  }

  String get nam => _nam;

  String get ngay => _ngay;

  String get thu => _thu;

  int get tongTien => _tongTien;

  String get idGroup => _idGroup;

  set idGroup(String value) {
    _idGroup = value;
    notifyListeners();
  }


  ///Handler function
  // Future<List<ExpendituresGroup>> getItemKhoanChi(String id) async {
  //   try{
  //     _status = Status.Loading;
  //     notifyListeners();
  //     await FirebaseFirestore.instance
  //         .collection('Groups/Penhouse/expenditures').doc(id)
  //         .get().then((item) {
  //       list.clear();
  //       _tongTien = 0;
  //       item.data()["data"].forEach((key, value) {
  //         list.add(ExpendituresGroup.fromJson(value));
  //         _tongTien += int.parse(value["giaTien"]);
  //       });
  //       notifyListeners();
  //       getDate(item.data()["ngayMua"]);
  //       notifyListeners();
  //
  //     });
  //     _status = Status.Loaded;
  //     notifyListeners();
  //     return list;
  //   }catch(e){
  //
  //   }
  // }

  Future<void> danhSachKhoanChi(String idGroup) async {

    try {
      print("alooo");
      List<KhoanChiNhom> ds = [];
      await FirebaseFirestore.instance
          .collection('Groups/$idGroup/expenditures').get().then((value) {
            KhoanChiNhom _kc;
        for(int i = 0; i<value.docs.length;i++){
          value.docs[i].reference.collection("data").get().then((value) {
            for(int i = 0; i<value.docs.length;i++){
               //print("Get data: ${value.docs[i].data()}");
              _kc.listItemKhoanChi.add(ItemKhoanChiNhom.fromJson(value.docs[i].data()));
            }
          });
          _kc.id =  value.docs[i].data()["id"];
          _kc.ngayMua = value.docs[i].data()["ngayMua"];
          // print("Get data: ${value.docs[i].data()["ngayMua"]}");
          ds.add(_kc);
        }
            dsKhoanChiNhom = ds;
        //print("Run here: ${dsKhoanChiNhom[0].listItemKhoanChi[0].noiDung}");
        notifyListeners();
      });
    }catch(e){

    }
  }
  Future<List<Map<String, dynamic>>> getListKhoanChi(String idGroup) async {


      List<Map<String, dynamic>> listKhoanChi = [];
    try {
      // danhSachKhoanChi(idGroup);
      // print("Run here: ${dsKhoanChiNhom[0].listItemKhoanChi[0].noiDung}");
      await FirebaseFirestore.instance
          .collection('Groups/$idGroup/expenditures').get().then((value) {
            for(int i = 0; i<value.docs.length;i++){
              value.docs[i].reference.collection("data").get().then((value) {
                for(int i = 0; i<value.docs.length;i++){

                }
              });
              listKhoanChi.add(value.docs[i].data());
              getDate(value.docs[i].data()["ngayMua"]);
            }
      }).then((value) {
        // FirebaseFirestore.instance
        //     .collection('Groups/$idGroup/expenditures').doc("06_11_2020").update()
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
            //print("run here: ${item.data()}");
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
  Future<void> getListMember(String idGroup) async{
    List<String> members = [];
    Map<String, String> _listMember = {};
    try {
      await FirebaseFirestore.instance
          .collection('Groups').doc(idGroup).get().then((value) {
        value.data()["member"].forEach((value) async {
           String name = await getNameById(value);
           members.add(name);
           notifyListeners();
           _listMembers[value] = name;
           notifyListeners();
          // _listMember[value] = name;
          //_listMember.putIfAbsent(value, () => name);
          // print("run here: $members");
        });
      });
    }
    catch (e) {
      print(e);
    }
  }

  Future<bool> themKhoanChi(String idGroup,String iconLoai, String tenLoai, String noiDung, String giaTien,
                            String ngayMua, String nguoiMua, List<String> nguoiThamGia, String ghiChu ) async {

    try{
      await FirebaseFirestore.instance.collection("Groups/$idGroup/expenditures").doc(ngayMua).get().then((value){
        if(value.data()==null){
          FirebaseFirestore.instance.collection("Groups/$idGroup/expenditures").doc(ngayMua).set({
            "data":{
              "0":{
                "iconLoai":iconLoai,
                "tenLoai":tenLoai,
                "noiDung":noiDung,
                "giaTien":giaTien,
                "nguoiMua":nguoiMua,
                "nguoiThamGia":nguoiThamGia,
                "ghiChu":ghiChu
              }
            },
            "ngayMua":ngayMua
          });
        }else {
          Map<String, dynamic> data = value.data()["data"];
          data["1"]={
            "iconLoai":iconLoai,
            "tenLoai":tenLoai,
            "noiDung":noiDung,
            "giaTien":giaTien,
            "nguoiMua":nguoiMua,
            "nguoiThamGia":nguoiThamGia,
            "ghiChu":ghiChu
          };
          print("run here: $data");
          String idData = value.data()["data"].lenght + 1;
          FirebaseFirestore.instance.collection("Groups/$idGroup/expenditures")
              .doc("$ngayMua").update(Map.of({"0.giaTien":"200"}));

        }
      });
    }catch(e){

    }
  }

  Map<String, String> get listMembers => _listMembers;

  set listMembers(Map<String, String> value) {
    _listMembers = value;
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
}