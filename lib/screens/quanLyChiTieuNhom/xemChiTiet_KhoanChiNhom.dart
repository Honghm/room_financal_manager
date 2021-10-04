import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:room_financal_manager/models/KhoanChiCaNhan.dart';
import 'package:room_financal_manager/models/KhoanChiNhom.dart';
import 'package:room_financal_manager/providers/group_providers.dart';

class XemChiTietKhoanChiNhom extends StatefulWidget {
  final String dateTime;
  final List<ItemKhoanChiNhom> dsItem;
  final double tongTien;
  XemChiTietKhoanChiNhom({this.dateTime,this.dsItem, this.tongTien});
  @override
  _XemChiTietKhoanChiNhomState createState() => _XemChiTietKhoanChiNhomState();
}

class _XemChiTietKhoanChiNhomState extends State<XemChiTietKhoanChiNhom> {
  List<Widget> dsItemKhoanChi = [];

  loadData(){
    dsItemKhoanChi.clear();
    widget.dsItem.forEach((item) {
      List<String> listName = [];
      // item.nguoiThamGia.forEach((id) async {
      //   String name = Provider.of<GroupProviders>(context,listen: false).getNameById(id);
      //   listName.add(name);
      // });
      dsItemKhoanChi.add(ThongTinKhoanChi(item, listName));
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,

          alignment: Alignment.topCenter,
          margin: EdgeInsets.all(10),
          child: Column(
            children: [
              Text("THÔNG TIN CHI TIẾT", style: TextStyle(fontSize: 30, color: Colors.blue[900],fontWeight: FontWeight.bold ),),
              SizedBox(height: 5,),
              Text("Ngày mua: ${widget.dateTime}", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
              SizedBox(height: 10,),
              Text(widget.tongTien>=1000?"Tổng tiền: ${(widget.tongTien/1000).toString()}TR":"Tổng tiền: ${widget.tongTien.toString()}K",
                style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold,fontSize: 20),),
              SizedBox(height: 10,),
              Column(children: dsItemKhoanChi,)
            ],
          ),
        ),
      ),
    );
  }
  Widget ThongTinKhoanChi(ItemKhoanChiNhom item, List<String> listName){
    List<Widget> dsNguoiThamGia = [];
    print(listName);
    item.nguoiThamGia.forEach((name)  {
      dsNguoiThamGia.add(Text(name,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
      );
    });
    return Card(
      margin: EdgeInsets.all(10),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(left: 10,top: 10,bottom: 10),
            child: Row(
              children: [
                Container(
                  height: 20,
                  width: 20,
                  child: Image.network(item.iconLoai),
                ),
                Text(item.tenLoai, style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 40,right: 10,bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("- Nội dung: ",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
                Text(item.noiDung,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
              ],
            ),
          ),

          Container(
            margin: EdgeInsets.only(left: 40,right: 10,bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("- Giá tiền: ",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
                Text("${item.giaTien}K",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.red)),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 40,right: 10,bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("- Hóa đơn: ",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
                item.hoaDon ==null?Text("Không có",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)):Container(
                  height: 200,
                  width: 150,
                  child: Image.network(item.hoaDon,fit: BoxFit.fill,),
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 40,right: 10,bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("- Người mua: ",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
                Text(item.nguoiMua,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 40,right: 10,bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("- Người tham gia: ",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
                Column(children: dsNguoiThamGia,)
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 40,right: 10,bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("- Ghi chú: ",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
                Text(item.ghiChu==""?"Không có":item.ghiChu,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.black)),
              ],
            ),
          ),
          SizedBox(height: 10,)
        ],
      ),
    );
  }
}


