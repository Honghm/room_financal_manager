import 'package:cloud_firestore/cloud_firestore.dart';

class UserData {
  String _id;
  String _displayName;
  String _phoneNumber;
  String _password;
  String _urlAvt;
  List<String> _idGroup = [];

  List<String> get idGroup => _idGroup;

  set idGroup(List<String> value) {
    _idGroup = value;
  }

  String get id => _id;

  set id(String value) {
    _id = value;
  }

  String _urlCover;




  UserData.formSnapShot(DocumentSnapshot snapshot) {
    Map data = snapshot.data();
    _id = data["uid"];
    _displayName = data["displayName"];
    _phoneNumber = data["phoneNumber"];
    _urlAvt = data["avatar"];
    _urlCover = data["cover"];
    _idGroup = List.castFrom(data["idGroup"]);

  }

  String get displayName => _displayName;

  set displayName(String value) {
    _displayName = value;
  }

  String get phoneNumber => _phoneNumber;

  set phoneNumber(String value) {
    _phoneNumber = value;
  }

  String get password => _password;

  set password(String value) {
    _password = value;
  }

  String get urlAvt => _urlAvt;

  set urlAvt(String value) {
    _urlAvt = value;
  }

  String get urlCover => _urlCover;

  set urlCover(String value) {
    _urlCover = value;
  }
}