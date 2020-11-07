import 'package:cloud_firestore/cloud_firestore.dart';

class UserData {
  static const ID = 'uid';
  static const NAME = 'name';
  static const ACCOUNT = 'account';
  static const PHONE = 'phone';
  static const PASS = 'pass';
  static const URL_AVT = 'url_avt';
  static const URL_COVER = 'url_cover';
  String _id;
  String _name;
  String _account;
  String _phone;
  String _pass;
  String _urlAvt;
  String _urlCover;

  String get urlCover => _urlCover;

  set urlCover(String value) {
    _urlCover = value;
  }

  String get urlAvt => _urlAvt;

  set urlAvt(String value) {
    _urlAvt = value;
  }

  String get pass => _pass;

  set name(String value) {
    _name = value;
  }

  String get id => _id;

  String get name => _name;

  String get phone => _phone;


  UserData.formSnapShot(DocumentSnapshot snapshot) {
    Map data = snapshot.data();
    _id = data[ID];
    _name = data[NAME];
    _account = data[ACCOUNT];
    _phone = data[PHONE];
    _urlAvt = data[URL_AVT];
    _urlCover = data[URL_COVER];
  }

  String get account => _account;

  set account(String value) {
    _account = value;
  }

  set phone(String value) {
    _phone = value;
  }

  set pass(String value) {
    _pass = value;
  }

}