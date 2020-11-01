import 'package:flutter/material.dart';

class ItemExpensesPerson extends StatefulWidget {
  @override
  _ItemExpensesPersonState createState() => _ItemExpensesPersonState();
}

class _ItemExpensesPersonState extends State<ItemExpensesPerson> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child:   Padding(
          padding: const EdgeInsets.only(left: 10,right: 10),
          child: Container(
            height: 200,
            width: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,

            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //Ngày tháng
                Container(
                  width: 65,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
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
                            Padding(
                              padding: const EdgeInsets.only(left: 30,right: 0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Loại", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
                                  Text("Nội dung", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 5),
                                    child: Text("Giá tiền", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
                                  )
                                ],),
                            ),
                            rowImformations("icon-an-uong.png", "Ăn uống", "Đi chợ", "100k"),
                            rowImformations("icon-mua-sam.png", "Mua sắm", "Quạt", "200k"),
                            rowImformations("icon-suc-khoe.png", "Sức khỏe", "thuốc ho", "50k"),
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
                            Text("Xem chi tiết",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16,decorationStyle: TextDecorationStyle.dashed,color: Colors.blue),)
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

  Widget rowImformations(icon, nameIcon, content, price) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(children: [
            Container(
                height: 20,
                width: 20,
                child: Image.asset(icon,fit: BoxFit.fill,)),
            Padding(
              padding: const EdgeInsets.only(left: 2),
              child: Text(nameIcon,style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
            )
          ],),
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Text(content, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
          ),
          Text(price, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold,color: Colors.red),)
        ],),
    );
  }

}
