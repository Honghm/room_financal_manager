import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rounded_date_picker/rounded_picker.dart';
import 'package:flutter_sliding_up_panel/sliding_up_panel_widget.dart';
import 'package:intl/intl.dart';
import 'package:flutter_rounded_date_picker/src/material_rounded_date_picker_style.dart';
import 'package:flutter_rounded_date_picker/src/material_rounded_year_picker_style.dart';
import 'package:provider/provider.dart';
import 'package:room_financal_manager/models/user.dart';
import 'package:room_financal_manager/providers/group_providers.dart';
import 'package:room_financal_manager/providers/home_provider.dart';
import 'package:smart_select/smart_select.dart';
// import 'package:smart_select/smart_select.dart' as choices;
import 'package:smart_select/smart_select.dart' show S2Choice;
class ThemKhoanChiNhom extends StatefulWidget {
  final SlidingUpPanelController panelController;
  final UserData user;
  ThemKhoanChiNhom(this.panelController, this.user);

  @override
  _ThemKhoanChiNhomState createState() => _ThemKhoanChiNhomState();
}

class _ThemKhoanChiNhomState extends State<ThemKhoanChiNhom> {

  final _formKey = GlobalKey<FormState>();
  final _key = GlobalKey<ScaffoldState>();
  ItemLoaiKhoanChi selectedItem;


  final _noiDungController = TextEditingController();
  final _giaTienController = TextEditingController();
  final _ghiChuController = TextEditingController();
  final format = DateFormat("yyyy_MM_dd");
  DateTime dateTime;
  Duration duration;
  String ngayMua;
  String dd;
  String mm;
  String yyyy;
  // List<String> _framework = [];
  List<String> _listMember = [];
  String nguoiMua = "";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dateTime = DateTime.now();
    dd = dateTime.day<10?"0${dateTime.day.toString()}":dateTime.day.toString();
    mm = dateTime.month<10?"0${dateTime.month.toString()}":dateTime.month.toString();
    yyyy = dateTime.year.toString();
    duration = Duration(minutes: 10);
    nguoiMua = widget.user.displayName;
    _listMember.add(widget.user.id);
    ngayMua = dd+"_"+mm+"_"+yyyy;
    // if(widget.idGroup!="")
       loadData();
  }
  File _image;
  getImageSuccess(File image){
    if(image!=null){
      setState(() {
        _image = image;
      });
    }

  }
  Future<void> loadData() async {
  }
  bool themKhoanChi(idGroup,selectedItem, noiDung, giaTien, ngayMua, nguoiMua, nguoiThamGia, ghiChu, GlobalKey<ScaffoldState> _key){
     if(selectedItem==null){
       _key.currentState.showSnackBar(SnackBar(
         backgroundColor: Colors.white,
           content: Container(
             height: 20,
             margin: EdgeInsets.only(bottom: 20),
               child: Center(child: Text("*Bạn chưa chọn loại khoản chi", style: TextStyle(color: Colors.red),)))));
       return false;
     }
     if(noiDung==""){
       _key.currentState.showSnackBar(SnackBar(
           backgroundColor: Colors.white,
           content: Container(
               height: 20,
               margin: EdgeInsets.only(bottom: 20),
               child: Center(child: Text("*Bạn chưa nhập nội dung khoản chi", style: TextStyle(color: Colors.red),)))));
       return false;
     }
     if(giaTien==""){
       _key.currentState.showSnackBar(SnackBar(
           backgroundColor: Colors.white,
           content: Container(
               height: 20,
               margin: EdgeInsets.only(bottom: 20),
               child: Center(child: Text("*Bạn chưa nhập giá tiền khoản chi", style: TextStyle(color: Colors.red),)))));
       return false;
     }
     if(ngayMua==""){
       _key.currentState.showSnackBar(SnackBar(
           backgroundColor: Colors.white,
           content: Container(
               height: 20,
               margin: EdgeInsets.only(bottom: 20),
               child: Center(child: Text("*Bạn chưa nhập ngày tạo khoản chi", style: TextStyle(color: Colors.red),)))));
       return false;
     }
     if(nguoiThamGia.isEmpty){
       _key.currentState.showSnackBar(SnackBar(
           backgroundColor: Colors.white,
           content: Container(
               height: 20,
               margin: EdgeInsets.only(bottom: 20),
               child: Center(child: Text("*Bạn chưa chọn người tham gia khoản chi", style: TextStyle(color: Colors.red),)))));
       return false;
     }
     if(ngayMua == ""){
       _key.currentState.showSnackBar(SnackBar(
           backgroundColor: Colors.white,
           content: Container(
               height: 20,
               margin: EdgeInsets.only(bottom: 20),
               child: Center(child: Text("*Bạn chưa nhập người lập khoản chi", style: TextStyle(color: Colors.red),)))));
       return false;
     }

    Provider.of<GroupProviders>(context,listen: false).themKhoanChi(idGroup, selectedItem.icon, selectedItem.name, noiDung, giaTien, ngayMua, nguoiMua, nguoiThamGia,_image, ghiChu);
     Provider.of<GroupProviders>(context,listen: false).danhSachKhoanChi(idGroup);
     return true;
  }
  @override
  Widget build(BuildContext context) {
    GroupProviders _groups = Provider.of<GroupProviders>(context);
    HomeProviders _homes =  Provider.of<HomeProviders>(context);
    return Scaffold(
      key: _key,
      appBar: AppBar(
        backgroundColor: Colors.green,
      ),
      body: Form(
        key: _formKey,
        child: Column(
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
                    ///----------Chọn loại chi------------------///
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
                            items: _homes.dsLoaiKhoanChi.map((ItemLoaiKhoanChi value){
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
                    ///--------Nhập nội dung---------------
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
                          child: TextFormField(
                            decoration: InputDecoration(
                              hintText: "Nhập nội dung",
                              hintStyle: TextStyle(fontSize: 18),
                              labelStyle: TextStyle(fontSize: 18)
                            ),
                            maxLines: 4,
                            controller: _noiDungController,
                          ),
                        )

                      ],),
                    SizedBox(height: 10,),

                    ///-------------Nhập giá tiền----------------
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
                          ),
                        )

                      ],),
                    SizedBox(height: 10,),

                    ///-------------Chọn ngày mua -------------------
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Ngày mua", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                        InkWell(
                          onTap: () async {
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
                              String _dd = newDateTime.day<10?"0${newDateTime.day.toString()}":newDateTime.day.toString();
                              String _mm = newDateTime.month<10?"0${newDateTime.month.toString()}":newDateTime.month.toString();
                              String _yyyy = newDateTime.year.toString();
                              setState(() {
                                dateTime = newDateTime;
                                ngayMua = _dd+"_"+_mm+"_"+_yyyy;
                              });

                            }
                          },
                          child: Container(
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

                                }),

                              ],
                            ),
                          ),
                        )

                      ],),

                    SizedBox(height: 10,),

                    ///--------------Chụp hóa đơn------------------
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Hóa đơn", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                        InkWell(
                          onTap: (){
                            _homes.showPicker(context: context, success: getImageSuccess);
                          },
                          child: Container(
                            height: _image==null?50:200,
                            width: 200,
                            padding: EdgeInsets.only(left: 10),
                            decoration: BoxDecoration(
                              border: Border.all(
                                  width: 1,
                                  color: Colors.black
                              ),
                            ),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Chụp hóa đơn", style: TextStyle(color: Colors.grey[600], fontSize: 18),),
                                    IconButton(
                                        icon: Icon(Icons.camera_alt_outlined),
                                        onPressed: (){

                                        })
                                  ],
                                ),
                                _image!=null?Container(
                                  height: 120,
                                  width: 100,
                                  child: Image.file(_image, fit: BoxFit.fill,),
                                ):Container()
                              ],
                            ),
                          ),
                        ),


                      ],),
                    SizedBox(height: 10,),

                    ///-----------------Người tạo-------------------
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Người mua", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                        Container(
                          height: 40,
                          width: 200,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            border: Border.all(
                                width: 1,
                                color: Colors.black
                            ),
                          ),
                          child: Text(nguoiMua, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
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
                            value: _listMember,
                            onChange: (state) => setState(() => _listMember = state.value),
                            choiceItems: _groups.listMembers,
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
                                hintStyle: TextStyle(fontSize: 18),
                                labelStyle: TextStyle(fontSize: 18)
                            ),
                            keyboardType: TextInputType.number,
                            maxLines: 5,
                            controller: _ghiChuController,
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
                              onPressed: () async {

                                if(themKhoanChi(_groups.selectedGroup.id, selectedItem, _noiDungController.text, _giaTienController.text,
                                    ngayMua, nguoiMua, _listMember, _ghiChuController.text, _key)){
                                  _key.currentState.showSnackBar(SnackBar(
                                      backgroundColor: Colors.green,
                                      content: Container(
                                          height: 20,
                                          margin: EdgeInsets.only(bottom: 20),
                                          child: Center(child: Text("Tạo khoản chi thành công", style: TextStyle(color: Colors.white),)))));
                                 setState(() {
                                   selectedItem = null;
                                   _noiDungController.text = "";
                                   _giaTienController.text = "";
                                   dateTime = DateTime.now();
                                   dd = dateTime.day<10?"0${dateTime.day.toString()}":dateTime.day.toString();
                                   mm = dateTime.month<10?"0${dateTime.month.toString()}":dateTime.month.toString();
                                   yyyy = dateTime.year.toString();
                                   duration = Duration(minutes: 10);
                                   ngayMua = dd+"_"+mm+"_"+yyyy;
                                   _listMember.clear();
                                 });
                                }
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
                                setState(() {
                                  selectedItem = null;
                                  _noiDungController.text = "";
                                  _giaTienController.text = "";
                                  dateTime = DateTime.now();
                                  dd = dateTime.day<10?"0${dateTime.day.toString()}":dateTime.day.toString();
                                  mm = dateTime.month<10?"0${dateTime.month.toString()}":dateTime.month.toString();
                                  yyyy = dateTime.year.toString();
                                  duration = Duration(minutes: 10);
                                  ngayMua = dd+"_"+mm+"_"+yyyy;
                                  _listMember.clear();
                                });
                                widget.panelController.hide();
                              },
                            ),
                          ),
                        ],),
                    ),
                    SizedBox(height: 40,),
                  ],
                ),
                color: Colors.white,
              ),
            ),

          ],
          mainAxisSize: MainAxisSize.min,
        ),
      ),
    );
  }
}