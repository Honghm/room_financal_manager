import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:room_financal_manager/config/initialization.dart';
import 'package:room_financal_manager/models/KhoanChiCaNhan.dart';
import 'package:room_financal_manager/models/KhoanThuCaNhan.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'dart:io';
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


  ///Lấy danh sách khoản chi cá nhân
  Future<void> danhSachKhoanChi(String idCaNhan) async {
    _status = Status.Loading;
    //notifyListeners();
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
      }).then((value) {
        _status = Status.Loaded;
        //notifyListeners();
      });
    }catch(e){

    }
  }

  ///Lấy danh sách khoản thu cá nhân
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
              value.docs[i].data()["ngayLap"],
              dsItem));
        }
        dsKhoanThuCaNhan = ds;
        notifyListeners();
      });
    }catch(e){

    }
  }

  List<double> thongKeKhoanChi_Thang(List<KhoanChiCaNhan> dsKhoanChiCaNhan) {
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

      dsKhoanChiCaNhan.forEach((data) {
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

  List<double> thongKeKhoanThu_Thang(List<KhoanThuCaNhan> dsKhoanThuCaNhan) {
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

    dsKhoanThuCaNhan.forEach((data) {
      int mm = int.parse(data.ngayLap.split("_")[1]);

      switch(mm){
        case 1:
          data.listItemKhoanThu.forEach((item) {
            priceMonth1 += double.parse(item.soTien);
          });
          break;
        case 2:
          data.listItemKhoanThu.forEach((item) {
            priceMonth2 += double.parse(item.soTien);
          });
          break;
        case 3:
          data.listItemKhoanThu.forEach((item) {
            priceMonth3 += double.parse(item.soTien);
          });
          break;
        case 4:
          data.listItemKhoanThu.forEach((item) {
            priceMonth4 += double.parse(item.soTien);
          });
          break;
        case 5:
          data.listItemKhoanThu.forEach((item) {
            priceMonth5 += double.parse(item.soTien);
          });
          break;
        case 6:
          data.listItemKhoanThu.forEach((item) {
            priceMonth6 += double.parse(item.soTien);
          });
          break;
        case 7:
          data.listItemKhoanThu.forEach((item) {
            priceMonth7 += double.parse(item.soTien);
          });
          break;
        case 8:
          data.listItemKhoanThu.forEach((item) {
            priceMonth8 += double.parse(item.soTien);
          });
          break;
        case 9:
          data.listItemKhoanThu.forEach((item) {
            priceMonth9 += double.parse(item.soTien);
          });
          break;
        case 10:
          data.listItemKhoanThu.forEach((item) {
            priceMonth10 += double.parse(item.soTien);
          });
          break;
        case 11:
          data.listItemKhoanThu.forEach((item) {
            priceMonth11 += double.parse(item.soTien);
          });
          break;
        case 12:
          data.listItemKhoanThu.forEach((item) {
            priceMonth12 += double.parse(item.soTien);
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


  ///Thêm khoản chi cá nhân
  Future<void> themKhoanChi(String idUser,String iconLoai, String tenLoai, String noiDung, String giaTien,
      String ngayMua,File image, String ghiChu ) async {
    try{


        Map<String,dynamic> data = {
          "iconLoai":iconLoai,
          "tenLoai":tenLoai,
          "noiDung":noiDung,
          "giaTien":giaTien,
          "hoaDon":"",
          "ghiChu":ghiChu
        };

      await FirebaseFirestore.instance.collection("Users/$idUser/KhoanChi").doc(ngayMua).get().then((value){

        if(value.data()==null){
          FirebaseFirestore.instance.collection("Users/$idUser/KhoanChi").doc(ngayMua).set({
            "id":ngayMua,
            "ngayMua":ngayMua,

          }).then((_) {
            String id = value.reference.collection("data").doc().id;
            value.reference.collection("data").doc(id).set(data);
            if(image!=null){
              uploadImage(image,"Users/$idUser/KhoanChi/$ngayMua/data", id);
            }

          });
        }else {
          String id = FirebaseFirestore.instance.collection("Users/$idUser/KhoanChi/$ngayMua/data").doc().id;
          FirebaseFirestore.instance.collection("Users/$idUser/KhoanChi/$ngayMua/data").doc(id).set(data);

          if(image!=null){
            uploadImage(image,"Users/$idUser/KhoanChi/$ngayMua/data", id);
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
  ///Thêm khoản thu cá nhân
  Future<void> themKhoanThu(String idUser, String noiDung, String soTien,
      String ngayLap,File image, String ghiChu ) async {
    try{
      String url = "";
      Map<String,dynamic> data = {
        "noiDung":noiDung,
        "soTien":soTien,
        "hoaHon":url,
        "ghiChu":ghiChu
      };
      await FirebaseFirestore.instance.collection("Users/$idUser/KhoanThu").doc(ngayLap).get().then((value){

        if(value.data()==null){
          FirebaseFirestore.instance.collection("Users/$idUser/KhoanThu").doc(ngayLap).set({
            "id":ngayLap,
            "ngayLap":ngayLap,

          }).then((_) {
            String id = value.reference.collection("data").doc().id;
            value.reference.collection("data").doc(id).set(data);
            if(image!=null){
              uploadImage(image, "Users/$idUser/KhoanThu/$ngayLap/data", id);
            }

          });
        }else {
          String id = FirebaseFirestore.instance.collection("Users/$idUser/KhoanThu/$ngayLap/data").doc().id;
          FirebaseFirestore.instance.collection("Users/$idUser/KhoanThu/$ngayLap/data").doc(id).set(data);
          if(image!=null){
            uploadImage(image, "Users/$idUser/KhoanThu/$ngayLap/data", id);
          }
        }
      });

    }catch(e){
      return false;
    }
  }




  ///Lấy ngày tháng năm
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
