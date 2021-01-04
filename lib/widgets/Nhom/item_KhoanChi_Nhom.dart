import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:room_financal_manager/models/KhoanChiNhom.dart';

import 'package:room_financal_manager/providers/group_providers.dart';
import 'file:///D:/My%20Code/Code%20Android/DoAn2/room_financal_manager/lib/screens/quanLyChiTieuCaNhan/xemChiTiet_KhoanChiCaNhan.dart';
import 'file:///D:/My%20Code/Code%20Android/DoAn2/room_financal_manager/lib/screens/quanLyChiTieuNhom/xemChiTiet_KhoanChiNhom.dart';

class ItemExpensesGroup extends StatefulWidget {
  // String idKhoanChi;
  Map<String, dynamic> khoanChi;
  List<ItemKhoanChiNhom> dsItem;
  String ngayMua;
  ItemExpensesGroup({this.khoanChi, this.dsItem, this.ngayMua });
  @override
  _ItemExpensesGroupState createState() => _ItemExpensesGroupState();
}

class _ItemExpensesGroupState extends State<ItemExpensesGroup> {
  List<Widget> _rowItemKhoanChi = List();

  double tongTien = 0;
  String ngayThang = "";
  String nam = "";
  String thu = "";
  void _loadData() async {
     _rowItemKhoanChi.clear();
     widget.dsItem.forEach((item) {
       _rowItemKhoanChi.add(rowImformations(item.iconLoai, item.tenLoai, item.noiDung,
           item.giaTien, item.nguoiMua));
       tongTien += double.parse(item.giaTien);
     });
    getDate(widget.ngayMua);
    setState(() {

    });
  }
  void getDate(String date){
    List<String> dates = [];
    dates = date.split("_");

    ngayThang = dates[0]+"/"+dates[1];
    nam = dates[2];
    double dd = double.parse(dates[0]);
    double mm = double.parse(dates[1]);
    double yyyy  =double.parse(dates[2]);
    int JMD = ((dd  + ((153 * (mm + 12 * ((14 - mm) / 12) - 3) + 2) / 5) +
        (365 * (yyyy + 4800 - ((14 - mm) / 12))) +
        ((yyyy + 4800 - ((14 - mm) / 12)) / 4) -
        ((yyyy + 4800 - ((14 - mm) / 12)) / 100) +
        ((yyyy + 4800 - ((14 - mm) / 12)) / 400)  - 32045) % 7).toInt();
    switch (JMD) {
      case 6:
        thu = "CN";
        break;
      case 0:
        thu = "2";
        break;
      case 1:
        thu = "3";
        break;
      case 2:
        thu = "4";
        break;
      case 3:
        thu = "5";
        break;
      case 4:
        thu = "6";
        break;
      case 5:
        thu = "7";
        break;
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadData();
  }
  @override
  Widget build(BuildContext context) {
    double height = (_rowItemKhoanChi.length*30+70).toDouble();
    final width = MediaQuery.of(context).size.width;

    return  Container(
      child:   Padding(
          padding: const EdgeInsets.only(left: 10,right: 10,top: 20),
          child: Container(
            height: height,
            width: width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,

            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //Ngày tháng
                Container(
                  width: width/6,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 0),
                    child: Container(
                      height: width/6,
                      width: width/6,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(width/12),
                          color: Colors.white,
                          border: Border.all(color: Colors.black)
                      ),
                      child: Column(children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 2),
                          child: RichText(
                            text: TextSpan(
                                text: thu!="CN"?"Thứ":"",
                                style: TextStyle(
                                    color:Colors.black, fontSize: 14),
                                children: <TextSpan>[
                                  TextSpan(
                                      text: thu,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 22,fontWeight: FontWeight.bold))
                                ]),
                          ),
                        ),
                        Text(ngayThang,style: TextStyle(fontSize: 14),),
                        Text(nam,style: TextStyle(fontSize: 14),)
                      ],),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 5,bottom: 5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width - 100,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [

                            Container(
                              height: 30,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                      width:width/7,
                                      alignment: Alignment.center,
                                      child: Text("Loại", style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),)),
                                  Container(
                                      width: width/7,
                                      alignment: Alignment.center,
                                      child: Text("Nội dung", style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),)),
                                  Container(
                                      width: width/7,
                                      alignment: Alignment.center,
                                      child: Text("Giá tiền", style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),)),
                                  Container(
                                      width: width/7,
                                      alignment: Alignment.center,
                                      child: Text("Người mua", style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),)),
                                ],),
                            ),

                            Column( children: _rowItemKhoanChi,),

                          ],),
                      ),
                      Container(
                        height: 30,
                        width: MediaQuery.of(context).size.width - 100,
                        padding: EdgeInsets.only(right: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(tongTien>=1000?"TÔNG CHI: ${(tongTien/1000).toString()}TR":"TÔNG CHI: ${tongTien.toString()}K",
                              style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold,fontSize: 16),),
                            Container(
                                decoration: BoxDecoration(
                                    border: Border(bottom: BorderSide(width: 1, color: Colors.blue))
                                ),
                                child: InkWell(
                                    onTap: (){
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (context) => XemChiTietKhoanChiNhom(dateTime: widget.ngayMua,dsItem: widget.dsItem,tongTien:tongTien,)));
                                    },
                                    child: Text("Xem chi tiết",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16,decorationStyle: TextDecorationStyle.dashed,color: Colors.blue),)))
                          ],),
                      )
                    ],),
                )
              ],
            ),
          )
      ),
    );
  }
  Widget rowImformations(icon, nameIcon, content, price, personBuy) {
    return Container(
      height: 30,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 65,
            child: Row(children: [
              Container(
                  height: 20,
                  width: 20,
                  child: Image.network(icon,fit: BoxFit.fill,)),
              Text(nameIcon.toString(),style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),),
            ],),
          ),

          Container(
            width: 60,
            alignment: Alignment.center,
            child: Text(content.toString(), style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),),
          ),
          Container(
            width: 60,
            alignment: Alignment.center,
            child: Text(double.parse(price.toString())>=1000?"${(double.parse(price.toString())/1000).toString()}TR":"${price}K",
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold,color: Colors.red),),
          ),
          Container(
              width: 60,
              alignment: Alignment.center,

              child: Text(personBuy.toString(), style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold,color: Colors.black),))
        ],),
    );
  }
}
