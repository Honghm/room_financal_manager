import 'package:cloud_firestore/cloud_firestore.dart';

class ExpendituresGroup{

  String _idUserBuy;
  String _iconLoai;
  String _tenLoai;
  String _noiDung;
  String _giaTien;
  String _ngayMua;
  String _ghiChu;
  List<String> _nguoiThamGia = [];


  List<String> get nguoiThamGia => _nguoiThamGia;

  set nguoiThamGia(List<String> value) {
    _nguoiThamGia = value;
  }

  String get idUserBuy => _idUserBuy;

  set idUserBuy(String value) {
    _idUserBuy = value;
  }

  String get iconLoai => _iconLoai;

  String get ghiChu => _ghiChu;

  set ghiChu(String value) {
    _ghiChu = value;
  }

  String get ngayMua => _ngayMua;

  set ngayMua(String value) {
    _ngayMua = value;
  }

  String get giaTien => _giaTien;

  set giaTien(String value) {
    _giaTien = value;
  }

  String get noiDung => _noiDung;

  set noiDung(String value) {
    _noiDung = value;
  }

  String get tenLoai => _tenLoai;

  set tenLoai(String value) {
    _tenLoai = value;
  }

  set iconLoai(String value) {
    _iconLoai = value;
  }

  ExpendituresGroup.fromJson(Map<String, dynamic> parsedJson){
    try{
      _iconLoai = parsedJson['iconLoai'];
      _tenLoai = parsedJson['tenLoai'];
      _noiDung = parsedJson['noiDung'];
      _giaTien = parsedJson['giaTien'];
      _idUserBuy = parsedJson['nguoiMua'];
     parsedJson['nguoiThamGia'].forEach((key,item){
       _nguoiThamGia.add(item);
     });
    }catch(e){
      print(e);
    }
  }
}