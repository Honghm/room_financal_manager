import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'file:///D:/My%20Code/Code%20Android/DoAn2/room_financal_manager/lib/models/expendituresGroup.dart';
import 'package:room_financal_manager/providers/group_providers.dart';

class ItemExpensesGroup extends StatefulWidget {
  @override
  _ItemExpensesGroupState createState() => _ItemExpensesGroupState();
}

class _ItemExpensesGroupState extends State<ItemExpensesGroup> {
  List<ExpendituresGroup> expGroup = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  loadData();
  }
Future<void> loadData() async {
  expGroup = await Provider.of<GroupProviders>(context,listen: false).getExpenditures();

  print("run here ");
  print(expGroup[0].noiDung);
}
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final expenditures = Provider.of<GroupProviders>(context);
    return  Container(
      child:   Padding(
          padding: const EdgeInsets.only(left: 10,right: 10,top: 20),
          child: Container(
            height: 200,
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
                                text: "Thứ",
                                style: TextStyle(
                                    color:Colors.black, fontSize: 14),
                                children: <TextSpan>[
                                  TextSpan(
                                      text: "2",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 22,fontWeight: FontWeight.bold))
                                ]),
                          ),
                        ),
                        Text("3/8",style: TextStyle(fontSize: 14),),
                        Text("2020",style: TextStyle(fontSize: 14),)
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
                        height: 140,
                        width: MediaQuery.of(context).size.width - 100,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [

                            Row(
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

                            //rowImformations(expenditures.expGroup.iconLoai, expenditures.expGroup.tenLoai, expenditures.expGroup.noiDung, expenditures.expGroup.giaTien,expenditures.expGroup.idUserBuy),

                          ],),
                      ),
                      Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width - 100,
                        padding: EdgeInsets.only(right: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("TÔNG CHI: 350k",style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold,fontSize: 16),),
                            Container(
                                decoration: BoxDecoration(
                                    border: Border(bottom: BorderSide(width: 1, color: Colors.blue))
                                ),
                                child: InkWell(
                                    onTap: (){


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
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: 65,
          child: Row(children: [
            Container(
                height: 20,
                width: 20,
                child: Image.network(icon,fit: BoxFit.fill,)),
            Text(nameIcon,style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),),
          ],),
        ),

        Container(
          width: 60,
          alignment: Alignment.center,
          child: Text(content, style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),),
        ),
        Container(
          width: 60,
          alignment: Alignment.center,
          child: Text(price, style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold,color: Colors.red),),
        ),
        Container(
            width: 60,
            alignment: Alignment.center,

            child: Text(personBuy, style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold,color: Colors.black),))
      ],);
  }
}
