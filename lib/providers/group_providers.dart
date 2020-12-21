import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:room_financal_manager/config/initialization.dart';
import 'package:room_financal_manager/models/KhoanChiNhom.dart';
import 'package:room_financal_manager/models/info_group.dart';
import 'package:room_financal_manager/models/user.dart';
import 'package:smart_select/smart_select.dart';


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

  bool haveNewGroup = false;
  List<S2Choice<String>> listMembers = [];

  KhoanChiNhom khoanChiNhom;
  List<KhoanChiNhom> dsKhoanChiNhom = [];
  List<InformationGroup> dsNhom = [];
  InformationGroup _selectedGroup;



  /// Getter&Setter

  InformationGroup get selectedGroup => _selectedGroup;

  set selectedGroup(InformationGroup value) {
    _selectedGroup = value;
    notifyListeners();
  }
  
  int get lenghtKhoanChi => _lenghtKhoanChi;

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
  Future<void> danhSachKhoanChi(String idGroup) async {
    try {
      List<KhoanChiNhom> ds = [];

      await FirebaseFirestore.instance
          .collection('Groups/$idGroup/expenditures').get().then((value) {
        for(int i = 0; i<value.docs.length;i++){
          List<ItemKhoanChiNhom> dsItem = [];
          value.docs[i].reference.collection("data").get().then((item) {
            for(int j = 0; j<item.docs.length;j++){
              dsItem.add(ItemKhoanChiNhom.fromJson(item.docs[j].data()));
              notifyListeners();
            }
          });

          ds.add(KhoanChiNhom.setData(value.docs[i].data()["id"],
              value.docs[i].data()["ngayMua"],
              dsItem));
        }

        dsKhoanChiNhom = ds;

        notifyListeners();
      });
    }catch(e){

    }
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


  Map<String, String> listName = {};
  Map<String, String> getListName() {
    Map<String, String> list = {};
   try{
     selectedGroup.members.forEach((item)  {
       FirebaseFirestore.instance.collection("Users").doc(item).get().then((value) {
          list.putIfAbsent(item, () => value.data()["name"]);
          listName = list;
       });

     });
      return listName;
   }catch(e){

   }
  }
  Future<void> getListGroup(UserData user) async{
    // List<Map<String, dynamic>> listGroup = [];
    List<InformationGroup> _listGroup = [];
      try{
        if(user.idGroup.isNotEmpty) {
          user.idGroup.forEach((id) {
            FirebaseFirestore.instance.collection("Groups").doc(id).get().then((data) {
              if(data.data() != null) {
                _listGroup.add(InformationGroup.fromJson(data.data()));
                notifyListeners();
              }
            });
          });
          dsNhom = _listGroup;
        }
      }catch(e){
        print("error: $e");
      }
  }
  Future<void> getListMember(String idGroup) async{
    List<S2Choice<String>> members = [];
    try {
      if(listMembers.isEmpty){
        await FirebaseFirestore.instance
            .collection('Groups').doc(idGroup).get().then((value) {
          value.data()["member"].forEach((value) async {
            String name = await getNameById(value);
            // members.add(name);
            members.add(new S2Choice<String>(value: value,title: name));
          });
          listMembers = members;
          notifyListeners();
        });
      }
    }
    catch (e) {
      print(e);
    }
  }

  Future<void> themKhoanChi(String idGroup,String iconLoai, String tenLoai, String noiDung, String giaTien,
                            String ngayMua, String nguoiMua, List<String> nguoiThamGia, String ghiChu ) async {
    try{
      double split_money = 0;
      split_money  = (double.parse(giaTien))/(nguoiThamGia.length);

      Map<String,dynamic> data = {
        "iconLoai":iconLoai,
        "tenLoai":tenLoai,
        "noiDung":noiDung,
        "giaTien":giaTien,
        "nguoiMua":nguoiMua,
        "nguoiThamGia":FieldValue.arrayUnion(nguoiThamGia),
        "ghiChu":ghiChu
      };
      print(nguoiThamGia);
      nguoiThamGia.forEach((item) {
        print(selectedGroup.detailMoney[item]);
         double currentMoney = double.parse(selectedGroup.detailMoney[item]);
         double sumMoney = currentMoney - split_money;
         sumMoney = num.parse(sumMoney.toStringAsFixed(1));
        FirebaseFirestore.instance.collection("Groups").doc(idGroup).update({
          "detail_money.$item": sumMoney.toString(),
        });
      });

      await FirebaseFirestore.instance.collection("Groups/$idGroup/expenditures").doc(ngayMua).get().then((value){
        print("run here:$data");
        if(value.data()==null){
          FirebaseFirestore.instance.collection("Groups/$idGroup/expenditures").doc(ngayMua).set({
            "id":ngayMua,
            "ngayMua":ngayMua,

          }).then((_) {
            value.reference.collection("data").add(data);
          });
        }else {
           FirebaseFirestore.instance.collection("Groups/$idGroup/expenditures").doc(ngayMua).collection("data").add(data);

        }
      });

    }catch(e){
      return false;
    }
  }

Future<void> addNewGroup(String avatar, String nameGroup, List<String> members, String idCreator )async {
    String id =  FirebaseFirestore.instance.collection("Groups").doc().id;
  await FirebaseFirestore.instance.collection("Groups").doc(id).set({
    "id": id,
    "avatar":avatar,
    "name":nameGroup,
    "member":FieldValue.arrayUnion(members),
    "idCreator": idCreator,
  }).then((value) {

    FirebaseFirestore.instance.collection("Users").doc(idCreator).update({
      "idGroup":FieldValue.arrayUnion([id]),
    });
    haveNewGroup = true;
    notifyListeners();
  });
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