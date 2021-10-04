import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:room_financal_manager/models/KhoanChiCaNhan.dart';

class XemChiTietKhoanChiCaNhan extends StatefulWidget {
final String dateTime;
final List<ItemKhoanChiCaNhan> dsItem;
final double tongTien;
XemChiTietKhoanChiCaNhan({this.dateTime,this.dsItem, this.tongTien});
  @override
  _XemChiTietKhoanChiCaNhanState createState() => _XemChiTietKhoanChiCaNhanState();
}

class _XemChiTietKhoanChiCaNhanState extends State<XemChiTietKhoanChiCaNhan> {
  List<Widget> dsItemKhoanChi = [];

  loadData(){
    dsItemKhoanChi.clear();
    widget.dsItem.forEach((item) {
      dsItemKhoanChi.add(ThongTinKhoanChi(item));
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
  Widget ThongTinKhoanChi(ItemKhoanChiCaNhan item){
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


