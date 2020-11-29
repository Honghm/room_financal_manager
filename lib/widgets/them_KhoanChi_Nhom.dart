import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rounded_date_picker/rounded_picker.dart';
import 'package:flutter_sliding_up_panel/sliding_up_panel_widget.dart';
import 'package:intl/intl.dart';
import 'package:flutter_rounded_date_picker/src/material_rounded_date_picker_style.dart';
import 'package:flutter_rounded_date_picker/src/material_rounded_year_picker_style.dart';
import 'package:provider/provider.dart';
import 'package:room_financal_manager/providers/group_providers.dart';
import 'package:smart_select/smart_select.dart';
// import 'package:smart_select/smart_select.dart' as choices;
import 'package:smart_select/smart_select.dart' show S2Choice;
class ThemKhoanChiNhom extends StatefulWidget {
  SlidingUpPanelController panelController;

  ThemKhoanChiNhom(this.panelController,);

  @override
  _ThemKhoanChiNhomState createState() => _ThemKhoanChiNhomState();
}

class _ThemKhoanChiNhomState extends State<ThemKhoanChiNhom> {

  ItemLoaiKhoanChi selectedItem;
  List<ItemLoaiKhoanChi> itemLoaiKhoanChis = <ItemLoaiKhoanChi>[
    const ItemLoaiKhoanChi("Ăn uống", "https://firebasestorage.googleapis.com/v0/b/room-financal-manager.appspot.com/o/icon-an-uong.png?alt=media&token=d5415192-8a9c-4088-9577-e8cd03c7e8c8"),
    const ItemLoaiKhoanChi("Mua sắm", "https://firebasestorage.googleapis.com/v0/b/room-financal-manager.appspot.com/o/icon-mua-sam.png?alt=media&token=f778a7a7-d0cd-4e08-9331-c38f1fffd308"),
    const ItemLoaiKhoanChi("Sức khỏe", "https://firebasestorage.googleapis.com/v0/b/room-financal-manager.appspot.com/o/icon-suc-khoe.png?alt=media&token=7b5bc360-cc3e-4f45-9c85-853d07a38a3e"),
    const ItemLoaiKhoanChi("Di chuyển", "https://firebasestorage.googleapis.com/v0/b/room-financal-manager.appspot.com/o/icon-xe.png?alt=media&token=634b1165-1087-4435-919f-783a7c5b8b54"),
    const ItemLoaiKhoanChi("Khác", "https://firebasestorage.googleapis.com/v0/b/room-financal-manager.appspot.com/o/icon-khac.png?alt=media&token=1deb819a-4974-4e5c-a2a4-b0b5f841d8b0"),
  ];

  final _noiDungController = TextEditingController();
  final _giaTienController = TextEditingController();
  final _ghiChuController = TextEditingController();
  final format = DateFormat("yyyy-MM-dd");
  DateTime dateTime;
  Duration duration;
  String ngayMua;
  List<String> _framework = [];
  List<String> _listMember = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dateTime = DateTime.now();
    ngayMua = dateTime.day.toString()+"-"+dateTime.month.toString()+"-"+dateTime.year.toString();
    duration = Duration(minutes: 10);

    // if(widget.idGroup!="")
    //   loadData();
  }
  Future<void> loadData() async {
    _listMember = Provider.of<GroupProviders>(context,listen: false).listMember;
  }
  @override
  Widget build(BuildContext context) {
    GroupProviders _groups = Provider.of<GroupProviders>(context);
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
              //physics: ClampingScrollPhysics(),
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Loại chi", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                    Container(
                      height: 40,
                      width: 150,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        border: Border.all(
                            width: 1,
                            color: Colors.black
                        ),
                      ),
                      child: DropdownButton<ItemLoaiKhoanChi>(
                        hint: Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text("Chọn loại", style: TextStyle(fontSize: 18),),
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
                        items: itemLoaiKhoanChis.map((ItemLoaiKhoanChi value){
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
                                    SizedBox(width: 10,),
                                    Text(value.name, style: TextStyle(fontSize: 18)),
                                  ],
                                ),
                              ));
                        }).toList(),
                      ),
                    )

                  ],),
                SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Nội dung", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                    Container(
                      height: 80,
                      width: 200,
                      padding: EdgeInsets.only(left: 10),
                      decoration: BoxDecoration(
                        border: Border.all(
                            width: 1,
                            color: Colors.black
                        ),
                      ),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: "Nhập nội dung",
                          hintStyle: TextStyle(fontSize: 18),
                          labelStyle: TextStyle(fontSize: 18)
                        ),
                        maxLines: 4,
                        controller: _noiDungController,
                        // onChanged: (val){
                        //   _noiDungController.text = val;
                        // },

                      ),
                    )

                  ],),
                SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Giá tiền", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                    Container(
                      height: 40,
                      width: 200,
                      padding: EdgeInsets.only(left: 10),
                      decoration: BoxDecoration(
                        border: Border.all(
                            width: 1,
                            color: Colors.black
                        ),
                      ),
                      child: TextFormField(
                        decoration: InputDecoration(
                            hintText: "Nhập giá tiền",
                            hintStyle: TextStyle(fontSize: 18),
                            labelStyle: TextStyle(fontSize: 18)
                        ),
                        keyboardType: TextInputType.number,
                        maxLines: 1,
                        controller: _giaTienController,
                        // onChanged: (val){
                        //   _giaTienController.text = val;
                        // },
                      ),
                    )

                  ],),
                SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Ngày mua", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                    Container(
                      height: 40,
                      width: 200,
                      padding: EdgeInsets.only(left: 10),
                      decoration: BoxDecoration(
                        border: Border.all(
                            width: 1,
                            color: Colors.black
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(ngayMua, style: TextStyle(color: Colors.grey[600], fontSize: 18),),
                          IconButton(icon: Icon(Icons.date_range), onPressed: () async {
                            DateTime newDateTime = await showRoundedDatePicker(
                                context: context,
                                //height: MediaQuery.of(context).size.height,
                                theme: ThemeData(primarySwatch: Colors.green),
                                styleDatePicker: MaterialRoundedDatePickerStyle(
                                  textStyleDayButton: TextStyle(fontSize: 20, color: Colors.white),
                                  textStyleYearButton: TextStyle(
                                    fontSize: 30,
                                    color: Colors.white,
                                  ),
                                  textStyleDayHeader: TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                  ),
                                  textStyleCurrentDayOnCalendar:
                                  TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
                                  textStyleDayOnCalendar: TextStyle(fontSize: 18, color: Colors.white),
                                  textStyleDayOnCalendarSelected:
                                  TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
                                  textStyleDayOnCalendarDisabled: TextStyle(fontSize: 18, color: Colors.white.withOpacity(0.1)),
                                  textStyleMonthYearHeader:
                                  TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
                                  paddingDatePicker: EdgeInsets.all(0),
                                  paddingMonthHeader: EdgeInsets.only(top: 20,bottom: 10),
                                  paddingActionBar: EdgeInsets.all(0),
                                  paddingDateYearHeader: EdgeInsets.all(10),
                                  sizeArrow: 20,
                                  colorArrowNext: Colors.white,
                                  colorArrowPrevious: Colors.white,
                                  marginLeftArrowPrevious: 10,
                                  marginTopArrowPrevious: 10,
                                  marginTopArrowNext: 10,
                                  marginRightArrowNext: 20,
                                  textStyleButtonAction: TextStyle(fontSize: 20, color: Colors.white),
                                  textStyleButtonPositive:
                                  TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
                                  textStyleButtonNegative: TextStyle(fontSize: 20, color: Colors.white.withOpacity(0.5)),
                                  decorationDateSelected: BoxDecoration(color: Colors.orange[600], shape: BoxShape.circle),
                                  backgroundPicker: Colors.green[400],
                                  backgroundActionBar: Colors.green[300],
                                  backgroundHeaderMonth: Colors.green[300],
                                ),

                                styleYearPicker: MaterialRoundedYearPickerStyle(
                                  textStyleYear: TextStyle(fontSize: 40, color: Colors.white),
                                  textStyleYearSelected:
                                  TextStyle(fontSize: 56, color: Colors.white, fontWeight: FontWeight.bold),
                                  heightYearRow: 100,
                                  backgroundPicker: Colors.green[400],
                                ));

                            if (newDateTime != null) {
                              setState(() {
                                dateTime = newDateTime;
                                ngayMua = dateTime.day.toString()+"-"+dateTime.month.toString()+"-"+dateTime.year.toString();
                              });

                            }
                          }),

                        ],
                      ),
                    )

                  ],),

                SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Hóa đơn", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                    Container(
                      height: 40,
                      width: 200,
                      padding: EdgeInsets.only(left: 10),
                      decoration: BoxDecoration(
                        border: Border.all(
                            width: 1,
                            color: Colors.black
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Chụp hóa đơn", style: TextStyle(color: Colors.grey[600], fontSize: 18),),
                          IconButton(icon: Icon(Icons.camera_alt_outlined), onPressed: (){})
                        ],
                      ),
                    )

                  ],),
                SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Người mua", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                    Container(
                      height: 40,
                      width: 200,
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
                    Text("Người tham gia", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                    Container(
                      height: 40,
                      width: 200,
                      decoration: BoxDecoration(
                        border: Border.all(
                            width: 1,
                            color: Colors.black
                        ),
                      ),
                      child: SmartSelect<String>.multiple(
                        title: 'Chọn thành viên',
                        value: _framework,
                        onChange: (state) => setState(() => _framework = state.value),
                        choiceItems: listMembers,
                        modalType: S2ModalType.popupDialog,
                        placeholder: 'Chọn thành viên',
                        tileBuilder: (context, state) {
                          return ListTile(
                            title:Text(
                              state.valueDisplay,
                              style: const TextStyle(color: Colors.grey, fontSize: 18),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                            trailing: const Icon(Icons.keyboard_arrow_down, color: Colors.grey),
                            onTap: (){
                              state.showModal();
                            },
                          );
                        },
                      ),
                    )

                  ],),

                SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Ghi chú", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                    Container(
                      height: 80,
                      width: 200,
                      decoration: BoxDecoration(
                        border: Border.all(
                            width: 1,
                            color: Colors.black
                        ),

                      ),
                      child: TextFormField(
                        decoration: InputDecoration(
                            //hintText: "Nhập giá tiền",
                            hintStyle: TextStyle(fontSize: 18),
                            labelStyle: TextStyle(fontSize: 18)
                        ),
                        keyboardType: TextInputType.number,
                        maxLines: 1,
                        controller: _ghiChuController,
                        // onChanged: (val){
                        //   _giaTienController.text = val;
                        // },
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
                          onPressed: (){
                            _groups.themKhoanChi("Penhouse", "https://firebasestorage.googleapis.com/v0/b/room-financal-manager.appspot.com/o/icon-an-uong.png?alt=media&token=d5415192-8a9c-4088-9577-e8cd03c7e8c8",
                                "Ăn uống", "Đi chợ", "100", "29_11_2020", "Minh Hồng", ["Minh Hồng", "Văn Thuận"], "");
                          },
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
class ItemLoaiKhoanChi {
  const ItemLoaiKhoanChi(this.name, this.icon);
  final String name;
  final String icon;
}
List<S2Choice<String>> listMembers = [
  S2Choice<String>(value: '000001', title: 'Minh Hồng'),
  S2Choice<String>(value: '000002', title: 'Văn Thuận'),
  S2Choice<String>(value: '000003', title: 'Thái Nguyên'),
];