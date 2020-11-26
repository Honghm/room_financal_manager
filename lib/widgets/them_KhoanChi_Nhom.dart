import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sliding_up_panel/sliding_up_panel_widget.dart';

class ThemKhoanChiNhom extends StatefulWidget {
  ScrollController scrollController;
  SlidingUpPanelController panelController = SlidingUpPanelController();
  ThemKhoanChiNhom(this.panelController, this.scrollController);

  @override
  _ThemKhoanChiNhomState createState() => _ThemKhoanChiNhomState();
}

class _ThemKhoanChiNhomState extends State<ThemKhoanChiNhom> {
  ItemLoaiKhoanChi selectedItem;
  List<ItemLoaiKhoanChi> itemLoaiKhoanChis = <ItemLoaiKhoanChi>[
    const ItemLoaiKhoanChi("Ăn uống",
        "https://firebasestorage.googleapis.com/v0/b/room-financal-manager.appspot.com/o/icon-an-uong.png?alt=media&token=d5415192-8a9c-4088-9577-e8cd03c7e8c8"),
    const ItemLoaiKhoanChi("Mua sắm",
        "https://firebasestorage.googleapis.com/v0/b/room-financal-manager.appspot.com/o/icon-mua-sam.png?alt=media&token=f778a7a7-d0cd-4e08-9331-c38f1fffd308"),
    const ItemLoaiKhoanChi("Sức khỏe",
        "https://firebasestorage.googleapis.com/v0/b/room-financal-manager.appspot.com/o/icon-suc-khoe.png?alt=media&token=7b5bc360-cc3e-4f45-9c85-853d07a38a3e"),
    const ItemLoaiKhoanChi("Di chuyển",
        "https://firebasestorage.googleapis.com/v0/b/room-financal-manager.appspot.com/o/icon-xe.png?alt=media&token=634b1165-1087-4435-919f-783a7c5b8b54"),
    const ItemLoaiKhoanChi("Khác",
        "https://firebasestorage.googleapis.com/v0/b/room-financal-manager.appspot.com/o/icon-khac.png?alt=media&token=1deb819a-4974-4e5c-a2a4-b0b5f841d8b0"),
  ];
  List<String> dsThanhVien = <String>[
    "Minh Hồng",
    "Thanh Huyền",
    "Cẩm Tuyên",
    "Diệu Chi",
    "Văn Thuận",
    "Thanh Chinh",
    "Thái Nguyên"
  ];

  final _noiDungController = TextEditingController();
  final _giaTienController = TextEditingController();
  String _ngayMua = "11/16/2020";
  String _nguoiMua = "Minh Hồng";

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          alignment: Alignment.center,
          child: Text(
            "THÊM KHOẢN CHI TIÊU",
            style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.blue[900]),
          ),
          height: 50.0,
        ),
        SizedBox(
          height: 10,
        ),
        Flexible(
          child: Container(
            padding: EdgeInsets.only(left: 10, right: 10),
            child: ListView(
              controller: widget.scrollController,
              physics: ClampingScrollPhysics(),
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Loại chi",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Container(
                      height: 40,
                      width: 150,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        border: Border.all(width: 1, color: Colors.black),
                      ),
                      child: DropdownButton<ItemLoaiKhoanChi>(
                        hint: Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text(
                            "Chọn loại",
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                        isExpanded: true,
                        elevation: 0,
                        underline: Container(
                          height: 1,
                        ),
                        value: selectedItem,
                        onChanged: (ItemLoaiKhoanChi newValue) {
                          setState(() {
                            selectedItem = newValue;
                          });
                        },
                        items: itemLoaiKhoanChis.map((ItemLoaiKhoanChi value) {
                          return DropdownMenuItem<ItemLoaiKhoanChi>(
                              value: value,
                              child: Container(
                                margin: EdgeInsets.only(left: 10),
                                child: Row(
                                  children: [
                                    Container(
                                      height: 25,
                                      width: 25,
                                      child: Image.network(value.icon),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(value.name,
                                        style: TextStyle(fontSize: 18)),
                                  ],
                                ),
                              ));
                        }).toList(),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Nội dung",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Container(
                      height: 80,
                      width: 200,
                      padding: EdgeInsets.only(left: 10),
                      decoration: BoxDecoration(
                        border: Border.all(width: 1, color: Colors.black),
                      ),
                      child: TextField(
                        decoration: InputDecoration(
                            hintText: "Nhập nội dung",
                            hintStyle: TextStyle(fontSize: 18),
                            labelStyle: TextStyle(fontSize: 18)),
                        maxLines: 4,
                        controller: _noiDungController,
                        onChanged: (val) {
                          _noiDungController.text = val;
                        },
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Giá tiền",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Container(
                      height: 40,
                      width: 200,
                      padding: EdgeInsets.only(left: 10),
                      decoration: BoxDecoration(
                        border: Border.all(width: 1, color: Colors.black),
                      ),
                      child: TextField(
                        decoration: InputDecoration(
                            hintText: "Nhập giá tiền",
                            hintStyle: TextStyle(fontSize: 18),
                            labelStyle: TextStyle(fontSize: 18)),
                        keyboardType: TextInputType.number,
                        maxLines: 1,
                        controller: _giaTienController,
                        onChanged: (val) {
                          _giaTienController.text = val;
                        },
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Ngày mua",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Container(
                      height: 40,
                      width: 200,
                      padding: EdgeInsets.only(left: 10),
                      decoration: BoxDecoration(
                        border: Border.all(width: 1, color: Colors.black),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Chọn ngày mua",
                            style: TextStyle(
                                color: Colors.grey[600], fontSize: 18),
                          ),
                          IconButton(
                              icon: Icon(Icons.date_range), onPressed: () {})
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Hóa đơn",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Container(
                      height: 40,
                      width: 200,
                      padding: EdgeInsets.only(left: 10),
                      decoration: BoxDecoration(
                        border: Border.all(width: 1, color: Colors.black),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Chụp hóa đơn",
                            style: TextStyle(
                                color: Colors.grey[600], fontSize: 18),
                          ),
                          IconButton(
                              icon: Icon(Icons.camera_alt), onPressed: () {})
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Người mua",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Container(
                      height: 40,
                      width: 200,
                      decoration: BoxDecoration(
                        border: Border.all(width: 1, color: Colors.black),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Người tham gia",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Container(
                      height: 40,
                      width: 200,
                      padding: EdgeInsets.only(left: 10),
                      decoration: BoxDecoration(
                        border: Border.all(width: 1, color: Colors.black),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Chọn thành viên",
                            style: TextStyle(
                                color: Colors.grey[600], fontSize: 18),
                          ),
                          IconButton(
                              icon: Icon(Icons.arrow_drop_down),
                              onPressed: () {})
                        ],
                      ),
                      // child: DropdownButton<ItemLoaiKhoanChi>(
                      //   hint: Text("nguoiThamGia"),
                      //   isExpanded: true,
                      //   elevation: 0,
                      //   underline: Container(
                      //     height: 1,
                      //   ),
                      //   value: selectedItem,
                      //   onChanged: (ItemLoaiKhoanChi newValue) {
                      //     setState(() {
                      //       selectedItem = newValue;
                      //     });
                      //   },
                      //   items: itemLoaiKhoanChis.map((ItemLoaiKhoanChi value){
                      //     return DropdownMenuItem<ItemLoaiKhoanChi>(
                      //         value: value,
                      //         child: Container(
                      //           margin: EdgeInsets.only(left: 10),
                      //           child: Row(
                      //             children: [
                      //               Container(
                      //                 height: 25,
                      //                 width: 25,
                      //                 child: Image.network(value.icon),
                      //               ),
                      //               SizedBox(width: 10,),
                      //               Text(value.name),
                      //             ],
                      //           ),
                      //         ));
                      //   }).toList(),
                      // ),
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Ghi chú",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Container(
                      height: 80,
                      width: 200,
                      decoration: BoxDecoration(
                        border: Border.all(width: 1, color: Colors.black),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        height: 40,
                        width: 110,
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          color: Color(0xFF1BAC98),
                          child: Text(
                            "THÊM",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          onPressed: () {},
                        ),
                      ),
                      SizedBox(
                        height: 40,
                        width: 110,
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          color: Colors.red,
                          child: Text(
                            "HỦY",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          onPressed: () {
                            widget.panelController.hide();
                          },
                        ),
                      ),
                    ],
                  ),
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

class ItemLoaiKhoanChi {
  const ItemLoaiKhoanChi(this.name, this.icon);
  final String name;
  final String icon;
}
