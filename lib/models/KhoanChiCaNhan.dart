

class ItemKhoanChiCaNhan {
  String id;
  String iconLoai;
  String tenLoai;
  String noiDung;
  String giaTien;
  String hoaDon;
  String ghiChu;

  ItemKhoanChiCaNhan.fromJson(Map<String, dynamic> parsedJson){
    try{
      id = parsedJson["id"];
      iconLoai = parsedJson["iconLoai"];
      tenLoai = parsedJson["tenLoai"];
      noiDung = parsedJson["noiDung"];
      hoaDon = parsedJson["hoaDon"];
      ghiChu = parsedJson["ghiChu"];
      giaTien = parsedJson["giaTien"];

    }catch(e){

    }
  }
}

class KhoanChiCaNhan {
  String id;
  String ngayMua;
  List<ItemKhoanChiCaNhan> listItemKhoanChi = [];
  KhoanChiCaNhan.setData(String _id, String _ngayMua,  List<ItemKhoanChiCaNhan> _ds){
    id = _id;
    ngayMua = _ngayMua;
    listItemKhoanChi = _ds;
  }
}