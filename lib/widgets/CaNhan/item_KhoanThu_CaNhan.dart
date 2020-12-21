import 'package:flutter/material.dart';
import 'package:room_financal_manager/models/KhoanChiCaNhan.dart';
import 'package:room_financal_manager/models/KhoanThuCaNhan.dart';

class ItemRevenuePerson extends StatefulWidget {
  Map<String, dynamic> khoanThu;
  List<ItemKhoanThuCaNhan> dsItem;
  String ngayMua;
  ItemRevenuePerson({this.khoanThu, this.dsItem, this.ngayMua });
  @override
  _ItemRevenuePersonState createState() => _ItemRevenuePersonState();
}


class _ItemRevenuePersonState extends State<ItemRevenuePerson> {
  List<Widget> _rowItemKhoanThu = List();
  int tongTien = 0;
  String ngayThang = "";
  String nam = "";
  String thu = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadData();
  }
  void _loadData() async {
    _rowItemKhoanThu.clear();
    widget.dsItem.forEach((item) {
      _rowItemKhoanThu.add(rowImformations(item.noiDung, item.soTien));
      tongTien += int.parse(item.soTien);
    });
    getDate(widget.ngayMua);

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
  Widget build(BuildContext context) {
    double height = (_rowItemKhoanThu.length*30+70).toDouble();
    final width = MediaQuery.of(context).size.width;
    return Container(
      child:   Padding(
          padding: const EdgeInsets.only(left: 10,right: 10, top: 20),
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
                  child:Container(
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
                                      width: width/3,
                                      alignment: Alignment.center,
                                      child: Text("Nội dung", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),)),
                                  Container(
                                      width: width/5,
                                      alignment: Alignment.center,
                                      child: Text("Số tiền", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),)),
                                ],),
                            ),

                            Column( children: _rowItemKhoanThu,),
                          ],),
                      ),
                      Container(
                        height: 30,
                        width: MediaQuery.of(context).size.width - 100,
                        padding: EdgeInsets.only(right: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("TÔNG THU: ${tongTien.toString()}K",style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold,fontSize: 16),),
                            Container(
                                decoration: BoxDecoration(
                                    border: Border(bottom: BorderSide(width: 1, color: Colors.blue))
                                ),
                                child: InkWell(
                                    onTap: (){
                                      print("xem chi tiết");
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

  Widget rowImformations(content, price) {
    return Container(
      height: 30,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 120,
            alignment: Alignment.center,
            child: Text(content, style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),),
          ),
          Container(
            width: 70,
            alignment: Alignment.center,
            child: Text(price, style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold,color: Colors.red),),
          ),

        ],),
    );
  }
}
