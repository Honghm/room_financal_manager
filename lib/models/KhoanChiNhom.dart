

class ItemKhoanChiNhom {
  String id;
  String iconLoai;
  String tenLoai;
  String noiDung;
  String giaTien;
  String nguoiMua;
  String hoaDon;
  List<String> nguoiThamGia;
  String ghiChu;

ItemKhoanChiNhom.fromJson(Map<String, dynamic> parsedJson){
  try{
    id = parsedJson["id"];
    iconLoai = parsedJson["iconLoai"];
    tenLoai = parsedJson["tenLoai"];
    noiDung = parsedJson["noiDung"];
    nguoiMua = parsedJson["nguoiMua"];
    giaTien = parsedJson["giaTien"];
    hoaDon = parsedJson["hoaDon"];
    List<String> list = [];
    if (parsedJson["nguoiThamGia"] != null) {
      for (var item in parsedJson["nguoiThamGia"]) {
        if (item != null) list.add(item);
      }
    }
    nguoiThamGia = list;
    ghiChu = parsedJson["ghiChu"];

  }catch(e){

  }
}
}

class KhoanChiNhom {
  String id;
  String ngayMua;
  List<ItemKhoanChiNhom> listItemKhoanChi = [];
  KhoanChiNhom.setData(String _id, String _ngayMua,  List<ItemKhoanChiNhom> _ds){
    id = _id;
    ngayMua = _ngayMua;
    listItemKhoanChi = _ds;
  }
}