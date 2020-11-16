import 'package:flutter/material.dart';
import 'package:flutter_sliding_up_panel/sliding_up_panel_widget.dart';

class ThemKhoanChiCaNhan extends StatefulWidget {
  ScrollController scrollController;
  SlidingUpPanelController panelController = SlidingUpPanelController();
  ThemKhoanChiCaNhan(this.panelController, this.scrollController);
  @override
  _ThemKhoanChiCaNhanState createState() => _ThemKhoanChiCaNhanState();
}

class _ThemKhoanChiCaNhanState extends State<ThemKhoanChiCaNhan> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          alignment: Alignment.center,
          child: Text("THÊM KHOẢN CHI TIÊU", style: TextStyle(fontSize: 28,fontWeight: FontWeight.bold, color: Colors.blue[900]),),
          height: 50.0,
        ),

        SizedBox(height: 10,),

        Flexible(
          child: Container(
            padding: EdgeInsets.only(left: 10,right: 10),
            child: ListView(
              controller: widget.scrollController,
              physics: ClampingScrollPhysics(),
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Loại chi", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                    Container(
                      height: 40,
                      width: 150,
                      decoration: BoxDecoration(
                        border: Border.all(
                            width: 1,
                            color: Colors.black
                        ),

                      ),
                    )

                  ],),
                SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Nội dung", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                    Container(
                      height: 80,
                      width: 220,
                      decoration: BoxDecoration(
                        border: Border.all(
                            width: 1,
                            color: Colors.black
                        ),

                      ),
                    )

                  ],),
                SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Giá tiền", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                    Container(
                      height: 40,
                      width: 220,
                      decoration: BoxDecoration(
                        border: Border.all(
                            width: 1,
                            color: Colors.black
                        ),

                      ),
                    )

                  ],),
                SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Ngày mua", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                    Container(
                      height: 40,
                      width: 220,
                      decoration: BoxDecoration(
                        border: Border.all(
                            width: 1,
                            color: Colors.black
                        ),

                      ),
                    )

                  ],),
                SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Hóa đơn", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                    Container(
                      height: 40,
                      width: 220,
                      decoration: BoxDecoration(
                        border: Border.all(
                            width: 1,
                            color: Colors.black
                        ),

                      ),
                    )

                  ],),
                SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Ghi chú", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                    Container(
                      height: 80,
                      width: 150,
                      decoration: BoxDecoration(
                        border: Border.all(
                            width: 1,
                            color: Colors.black
                        ),

                      ),
                    )

                  ],),
                SizedBox(height: 20,),
                Padding(
                  padding: const EdgeInsets.only(left: 20,right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        height: 40,
                        width: 110,
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(20))),
                          color: Color(0xFF1BAC98),
                          child: Text("THÊM", style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white),),
                          onPressed: (){},
                        ),
                      ),

                      SizedBox(
                        height: 40,
                        width: 110,
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(20))),
                          color: Colors.red,
                          child: Text("HỦY", style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white),),
                          onPressed: (){
                            widget.panelController.hide();
                          },
                        ),
                      ),
                    ],),
                ),
              ],
            ),
            color: Colors.white,
          ),
        ),
      ],
      mainAxisSize: MainAxisSize.min,
    );
  }
}
