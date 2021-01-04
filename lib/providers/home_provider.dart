import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
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
  File _image;

  File get image => _image;

  set image(File value) {
    _image = value;
  }

  final picker = ImagePicker();
  _imgFromCamera(Function success) async {
    final pickedFile = await picker.getImage(
        source: ImageSource.camera, imageQuality: 50
    );

    _image = File(pickedFile.path);
    success(_image);
    notifyListeners();
  }

  _imgFromGallery(Function success) async {
    final pickedFile = await picker.getImage(
        source: ImageSource.gallery, imageQuality: 50
    );

    _image = File(pickedFile.path);
    success(_image);
    notifyListeners();
  }
  Future<String> uploadImage(File image) async {
    firebase_storage.Reference firebaseStorageRef =
    firebase_storage.FirebaseStorage.instance.ref().child(image.path);
    firebase_storage.UploadTask uploadTask =  firebaseStorageRef.putFile(image);
   uploadTask.whenComplete(() async {
     String url = await uploadTask.snapshot.ref.getDownloadURL();
     return url;
   });

  }
  void showPicker({BuildContext context, Function success}) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Library'),
                      onTap: () {
                        _imgFromGallery(success);
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      _imgFromCamera(success);
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        }
    );
  }
}


class ItemLoaiKhoanChi {
  const ItemLoaiKhoanChi(this.name, this.icon);
  final String name;
  final String icon;
}