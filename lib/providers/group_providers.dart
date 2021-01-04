import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:room_financal_manager/config/initialization.dart';
import 'package:room_financal_manager/models/KhoanChiNhom.dart';
import 'package:room_financal_manager/models/info_group.dart';
import 'package:room_financal_manager/models/user.dart';
import 'package:room_financal_manager/providers/user_provider.dart';
import 'package:smart_select/smart_select.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

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
      name = value.data()["displayName"];
      return name;
    });
  }catch(e){
    print(e);
  }
  return name;
  }


  Map<String, String> listName = {};
  void getListName( InformationGroup _selectedGroup) {
    Map<String, String> list = {};
   try{
     _selectedGroup.members.forEach((item)  {
       FirebaseFirestore.instance.collection("Users").doc(item).get().then((value) {
          list.putIfAbsent(item, () => value.data()["displayName"]);
          listName = list;
       });
     });
   }catch(e){

   }
  }
  void getListGroup(UserData user) {
      try{
        _status = Status.Loading;
        if(user.idGroup.isNotEmpty) {
          List<InformationGroup> _listGroup = [];
          user.idGroup.forEach((id)  {
             FirebaseFirestore.instance.collection("Groups").doc(id).get().then((data) {
              if(data.data() != null) {
                _listGroup.add(InformationGroup.fromJson(data.data()));
                notifyListeners();
              }
            });
          });
          dsNhom = _listGroup;
          notifyListeners();
        }
        _status = Status.Loaded;
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
                            String ngayMua, String nguoiMua, List<String> nguoiThamGia,File image, String ghiChu ) async {

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

      nguoiThamGia.forEach((item) {
         double currentMoney = double.parse(selectedGroup.detailMoney[item]);
         double sumMoney = currentMoney - split_money;
         sumMoney = num.parse(sumMoney.toStringAsFixed(1));
        FirebaseFirestore.instance.collection("Groups").doc(idGroup).update({
          "detail_money.$item": sumMoney.toString(),
          "group_funds":double.parse(selectedGroup.groupFunds) - double.parse(giaTien)
        });
      });

      await FirebaseFirestore.instance.collection("Groups/$idGroup/expenditures").doc(ngayMua).get().then((value){
        if(value.data()==null){
          FirebaseFirestore.instance.collection("Groups/$idGroup/expenditures").doc(ngayMua).set({
            "id":ngayMua,
            "ngayMua":ngayMua,

          }).then((_) {
            String id = value.reference.collection("data").doc().id;
            value.reference.collection("data").doc(id).set(data);
            if(image!=null){
              uploadImage(image, "Groups/$idGroup/expenditures/$ngayMua/data", id);
            }
          });
        }else {
          String id = FirebaseFirestore.instance.collection("Groups/$idGroup/expenditures/$ngayMua/data").doc().id;
           FirebaseFirestore.instance.collection("Groups/$idGroup/expenditures/$ngayMua/data").doc(id).set(data);
           if(image!=null){
             uploadImage(image, "Groups/$idGroup/expenditures/$ngayMua/data", id);
           }
        }
      });

    }catch(e){
      return false;
    }
  }
  void uploadImage(File image,String path, String id){
    firebase_storage.Reference firebaseStorageRef =
    firebase_storage.FirebaseStorage.instance.ref().child(image.path);
    firebase_storage.UploadTask uploadTask = firebaseStorageRef.putFile(
        image);
    uploadTask.whenComplete(() async {
      String url = await uploadTask.snapshot.ref.getDownloadURL();
      FirebaseFirestore.instance.collection(path).doc(id).update({
        "hoaDon": url
      });
    });
  }
Future<void> addNewGroup(String idGroup, File avatar, String nameGroup, List<String> members, UserData creator )async {

try{
  await FirebaseFirestore.instance.collection("Groups").doc(idGroup).set({
    "id": idGroup,
    "avatar":"",
    "name":nameGroup,
    "member":FieldValue.arrayUnion(members),
    "idCreator": creator.id,
  }).then((value) {
    FirebaseFirestore.instance.collection("Users").doc(creator.id).update({
      "idGroup":FieldValue.arrayUnion([idGroup]),
    });
    creator.idGroup.add(idGroup);
   getListGroup(creator);
   notifyListeners();
    firebase_storage.Reference firebaseStorageRef =
    firebase_storage.FirebaseStorage.instance.ref().child(avatar.path);
    firebase_storage.UploadTask uploadTask = firebaseStorageRef.putFile(avatar);
    uploadTask.whenComplete(() async {
      String url = await uploadTask.snapshot.ref.getDownloadURL();
      FirebaseFirestore.instance.collection("Groups").doc(idGroup).update({
        "avatar": url
      });
    });
  });
}catch(e){

}
}


  List<double> thongKeKhoanChi_Thang(List<KhoanChiNhom> dsKhoanChiNhom) {
    double priceMonth1 = 0;
    double priceMonth2 = 0;
    double priceMonth3 = 0;
    double priceMonth4 = 0;
    double priceMonth5 = 0;
    double priceMonth6 = 0;
    double priceMonth7 = 0;
    double priceMonth8 = 0;
    double priceMonth9 = 0;
    double priceMonth10 = 0;
    double priceMonth11 = 0;
    double priceMonth12 = 0;

    dsKhoanChiNhom.forEach((data) {
      int mm = int.parse(data.ngayMua.split("_")[1]);

      switch(mm){
        case 1:
          data.listItemKhoanChi.forEach((item) {
            priceMonth1 += double.parse(item.giaTien);
          });
          break;
        case 2:
          data.listItemKhoanChi.forEach((item) {
            priceMonth2 += double.parse(item.giaTien);
          });
          break;
        case 3:
          data.listItemKhoanChi.forEach((item) {
            priceMonth3 += double.parse(item.giaTien);
          });
          break;
        case 4:
          data.listItemKhoanChi.forEach((item) {
            priceMonth4 += double.parse(item.giaTien);
          });
          break;
        case 5:
          data.listItemKhoanChi.forEach((item) {
            priceMonth5 += double.parse(item.giaTien);
          });
          break;
        case 6:
          data.listItemKhoanChi.forEach((item) {
            priceMonth6 += double.parse(item.giaTien);
          });
          break;
        case 7:
          data.listItemKhoanChi.forEach((item) {
            priceMonth7 += double.parse(item.giaTien);
          });
          break;
        case 8:
          data.listItemKhoanChi.forEach((item) {
            priceMonth8 += double.parse(item.giaTien);
          });
          break;
        case 9:
          data.listItemKhoanChi.forEach((item) {
            priceMonth9 += double.parse(item.giaTien);
          });
          break;
        case 10:
          data.listItemKhoanChi.forEach((item) {
            priceMonth10 += double.parse(item.giaTien);
          });
          break;
        case 11:
          data.listItemKhoanChi.forEach((item) {
            priceMonth11 += double.parse(item.giaTien);
          });
          break;
        case 12:
          data.listItemKhoanChi.forEach((item) {
            priceMonth12 += double.parse(item.giaTien);
          });
          break;
      }

    });

    return [
      priceMonth1,
      priceMonth2,
      priceMonth3,
      priceMonth4,
      priceMonth5,
      priceMonth6,
      priceMonth7,
      priceMonth8,
      priceMonth9,
      priceMonth10,
      priceMonth11,
      priceMonth12];
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