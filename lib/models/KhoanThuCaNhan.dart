

class ItemKhoanThuCaNhan {
  String id;
  String noiDung;
  String soTien;
  String hoaDon;
  String ghiChu;

  ItemKhoanThuCaNhan.fromJson(Map<String, dynamic> parsedJson){
    try{
      id = parsedJson["id"];
      noiDung = parsedJson["noiDung"];
      ghiChu = parsedJson["ghiChu"];
      hoaDon = parsedJson["hoaDon"];
      soTien = parsedJson["soTien"];

    }catch(e){

    }
  }
}

class KhoanThuCaNhan {
  String id;
  String ngayLap;
  List<ItemKhoanThuCaNhan> listItemKhoanThu = [];
  KhoanThuCaNhan.setData(String _id, String _ngayLap,  List<ItemKhoanThuCaNhan> _ds){
    id = _id;
    ngayLap = _ngayLap;
    listItemKhoanThu = _ds;
  }
}