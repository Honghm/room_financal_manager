

class ItemKhoanThuCaNhan {
  String id;
  String noiDung;
  String soTien;
  String ghiChu;

  ItemKhoanThuCaNhan.fromJson(Map<String, dynamic> parsedJson){
    try{
      id = parsedJson["id"];
      noiDung = parsedJson["noiDung"];
      ghiChu = parsedJson["ghiChu"];
      soTien = parsedJson["soTien"];

    }catch(e){

    }
  }
}

class KhoanThuCaNhan {
  String id;
  String ngayMua;
  List<ItemKhoanThuCaNhan> listItemKhoanChi = [];
  KhoanThuCaNhan.setData(String _id, String _ngayMua,  List<ItemKhoanThuCaNhan> _ds){
    id = _id;
    ngayMua = _ngayMua;
    listItemKhoanChi = _ds;
  }
}