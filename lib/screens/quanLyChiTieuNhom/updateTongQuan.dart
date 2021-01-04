import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:room_financal_manager/models/info_group.dart';
import 'package:room_financal_manager/providers/group_providers.dart';
import 'package:room_financal_manager/providers/home_provider.dart';

class UpdateTongQuan extends StatefulWidget {

  Map<String, String> listName = {};
  List<TextEditingController> listMoney = [];
  List<String> member = [];
  UpdateTongQuan({this.listName, this.listMoney, this.member, this.selectedGroup});
  InformationGroup selectedGroup;
  @override
  _UpdateTongQuanState createState() => _UpdateTongQuanState();
}

class _UpdateTongQuanState extends State<UpdateTongQuan> {
  final _key = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  bool showThemThanhVien = false;
  final TextEditingController code = TextEditingController();
  File _image;
  getImageSuccess(File image){
    if(image!=null){
      setState(() {
        _image = image;
      });
    }

  }
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    GroupProviders _groups = Provider.of<GroupProviders>(context);
    HomeProviders _home =  Provider.of<HomeProviders>(context);
    final TextEditingController nameGroup = TextEditingController(text: _groups.selectedGroup.nameGroup);
    return Scaffold(
      key: _key,
      appBar: AppBar(
        backgroundColor: Colors.green,
        centerTitle: true,
        title: Text("CẬP NHẬT THÔNG TIN NHÓM", style: TextStyle(color: Colors.white,fontSize: 22, fontWeight: FontWeight.bold)),
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  ///Hiển thị thông tin tổng quan của nhóm: avatar, tên, quỹ nhóm,...
                  Container(
                      height: height/3,
                      child:  Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(height: 20,),
                          Stack(
                            alignment: Alignment.topRight,
                            children: [
                              Container(
                                height: 100,
                                width: 100,
                                margin: EdgeInsets.only(left: 10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  border: Border.all(color: Colors.black),
                                  color: Color(0xFFCDCCCC),
                                ),
                                child: _groups.selectedGroup.avatar ==""? Icon(Icons.people,size: 50,color: Colors.white,):ClipOval(
                                  child: SizedBox(
                                      height: 80,
                                      width: 80,
                                      child: _image!=null?Image.file(_image, fit: BoxFit.fill,):_groups.selectedGroup.avatar==""?Icon(
                                        Icons.person,
                                        size: 50,
                                        color: Colors.white,
                                      ):Image.network(_groups.selectedGroup.avatar,fit: BoxFit.fill,)),
                                ),
                              ),
                              Container(
                                width: 30,
                                height: 30,
                                padding: EdgeInsets.only(left:15,),
                                child: IconButton(icon: Icon(Icons.camera_alt),onPressed: (){
                                  _home.showPicker(context:context,success: getImageSuccess );
                                },),
                              )
                            ],
                          ),
                          SizedBox(height: 10,),
                          Container(
                            width: 150,
                            child: TextField(
                              textAlign: TextAlign.center,
                              controller: nameGroup,
                              style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: Colors.red),
                            ),
                          ),
                          //Text(_groups.selectedGroup.nameGroup, style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: Colors.red),),
                          Text("Quỹ nhóm hiện có: ${_groups.selectedGroup.groupFunds}",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.red)),

                        ],
                      )
                  ),
                  SizedBox(height: 20,),
                  ///Hiển thị thông tin số tiền hiện có của các thành viên trong nhóm
                  Container(
                    padding: EdgeInsets.only(left: 5,right: 5,),
                    height: height/3,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                            width: width/2-10,
                             //color: Colors.green,
                            padding: EdgeInsets.only(left: 5),
                            child: ListView.builder(
                                itemCount: _groups.selectedGroup.members.length,
                                itemBuilder: (_,index){
                                  //print(_groups.getNameById(_groups.selectedGroup.members[index]));
                                  return (index%2 == 0) ? Container(
                                    child: ListTile(
                                      leading: Container(
                                          margin: EdgeInsets.only(top: 5),
                                          child: Text("${widget.listName[_groups.selectedGroup.members[index]]}: ",  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black), )),
                                      title:Container(
                                        width: 50,
                                        margin: EdgeInsets.only(bottom: 5),
                                        child: TextFormField(
                                          keyboardType: TextInputType.number,
                                          controller: widget.listMoney[index],
                                          onChanged: (value){
                                            widget.listMoney[index].text = value;
                                          },
                                          onSaved: (String value) {
                                          },
                                          //readOnly: !isUpdate,
                                        ),
                                      ),
                                    ),
                                  ):Container();
                                })),
                        Container(
                            width: width/2-10,
                             //color: Colors.blue,
                            padding: EdgeInsets.only(left: 5),
                            child: ListView.builder(
                                itemCount: _groups.selectedGroup.members.length,
                                itemBuilder: (_,index) {
                                  /*  String name = _groups.getNameById(selectedGroup.nameGroup[index]);*/
                                  // print(name);
                                  return index%2!=0?Container(
                                    child: ListTile(
                                      leading: Container(
                                        margin: EdgeInsets.only(top: 5),
                                          child: Text("${widget.listName[_groups.selectedGroup.members[index]]}: ",  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black), )),
                                      title:Container(
                                        width: 50,
                                        margin: EdgeInsets.only(bottom: 5),
                                        child: TextFormField(
                                          keyboardType: TextInputType.number,
                                          controller: widget.listMoney[index],
                                          onChanged: (value){
                                            widget.listMoney[index].text = value;
                                          },

                                          //readOnly: !isUpdate,
                                        ),
                                      ),
                                    ),
                                  ):Container();
                                }))
                      ],),
                  ),

                  SizedBox(height: 20,),
                  ///Buttom điều hướng cho phép chỉnh sửa thông tin của nhóm
                  // Container(
                  //   height: 50,
                  //   padding: EdgeInsets.only(left: 20,right: 20),
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //     children: [
                  //       Container(
                  //         height: 50,
                  //         width: 120,
                  //         child: RaisedButton(
                  //           shape: RoundedRectangleBorder(
                  //               borderRadius: BorderRadius.all(Radius.circular(25))),
                  //           onPressed: (){
                  //
                  //
                  //           },
                  //           color: Colors.green,
                  //           child: Text("Xong",style: TextStyle(fontSize: 18,color: Colors.white,fontWeight: FontWeight.bold),),
                  //         ),
                  //       ),
                  //       SizedBox(width: 10,),
                  //       Container(
                  //         height: 50,
                  //         width: 120,
                  //         child: RaisedButton(
                  //           shape: RoundedRectangleBorder(
                  //               borderRadius: BorderRadius.all(Radius.circular(25))),
                  //           onPressed: (){
                  //
                  //           },
                  //           color: Colors.red,
                  //           child: Text("Hủy",style: TextStyle(fontSize: 18,color: Colors.white,fontWeight: FontWeight.bold),),
                  //         ),
                  //       )
                  //     ],
                  //   ),
                  // )
                ],
              ),
            ),
            showThemThanhVien?themThanhVien():Container(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor:  Color(0xFF76E65E),
        onPressed: () async {
          // panelController.expand();
          await showDialog(
              context: this.context,
              child: AlertDialog(
                backgroundColor: Colors.white,
                title:  Center(
                    child: Text("Nhập mã của thành viên", style: TextStyle(color: Colors.black, fontSize: 22, fontWeight: FontWeight.bold),)),
                contentPadding: EdgeInsets.all(0),
               content: Container(
                 height: 120,
                   color: Colors.white,
                   child: Column(
                     children: [
                       SizedBox(height: 20,),
                       Container(
                           height: 54,
                           margin: EdgeInsets.only(left: 30, right: 30),
                           padding: EdgeInsets.only(bottom: 4),
                           decoration: BoxDecoration(
                               border: Border.all(color: Colors.black),
                               color: Colors.white
                           ),
                           child: ListTile(
                             leading:  Text("#", style: TextStyle(color:Colors.black54,fontSize: 30,fontWeight:FontWeight.bold),),
                             title: TextField(
                               controller: code,
                               decoration: InputDecoration(
                                   labelText: "000000",
                                   labelStyle: TextStyle(fontSize: 30)
                               ),
                               keyboardType: TextInputType.number,
                             ),
                           )
                       ),


                     ],)
              ),
                actions: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(width: 20,),
                      Container(
                        width: 100,
                        height: 40,
                        margin: EdgeInsets.only(bottom: 20),
                        child: RaisedButton(
                          color: Colors.red,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(25))),
                          onPressed: (){
                            Navigator.pop(context);
                          },
                          child: Text("Hủy", style: TextStyle(fontSize: 20),),
                        ),
                      ),
                      SizedBox(width: 20,),
                      Container(
                        width: 100,
                        height: 40,
                        margin: EdgeInsets.only(right: 20, bottom: 20),
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(25))),
                          onPressed: (){

                            _key.currentState.showSnackBar(SnackBar(
                              backgroundColor: Colors.green,
                                content: Text(
                                    "Thêm thành viên thành công")));
                            Navigator.pop(context);
                          },
                          child: Text("Thêm", style: TextStyle(fontSize: 20),),
                        ),
                      ),

                    ],
                  )


                ],
              )
          );
          // setState(() {
          //   showThemThanhVien = true;
          // });
        },
        child: Icon(Icons.add, size: 40,),
      ),
      bottomNavigationBar: Container(
        height: 60,
        padding: EdgeInsets.only(left: 20,right: 20,bottom: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 50,
              width: 120,
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(25))),
                onPressed: (){


                },
                color: Colors.green,
                child: Text("Xong",style: TextStyle(fontSize: 18,color: Colors.white,fontWeight: FontWeight.bold),),
              ),
            ),
            SizedBox(width: 10,),
            Container(
              height: 50,
              width: 120,
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(25))),
                onPressed: (){
                  Navigator.pop(context);
                },
                color: Colors.red,
                child: Text("Hủy",style: TextStyle(fontSize: 18,color: Colors.white,fontWeight: FontWeight.bold),),
              ),
            )
          ],
        ),
      ),
      //floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
    );
  }
  Widget themThanhVien(){
    final TextEditingController code = TextEditingController();
    return Column(
      children: [
        SizedBox(height: 10,),
        Container(
            height: 54,
            margin: EdgeInsets.only(left: 30, right: 30),
            padding: EdgeInsets.only(bottom: 4),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                color: Colors.white
            ),
            child: ListTile(
              leading:  Text("#", style: TextStyle(color:Colors.black54,fontSize: 30,fontWeight:FontWeight.bold),),
              title: TextField(
                controller: code,
                decoration: InputDecoration(
                  labelText: "000000",
                  labelStyle: TextStyle(fontSize: 30)
                ),
                keyboardType: TextInputType.number,
              ),
            )
        ),

        // SizedBox(height: 10,),
        // Container(
        //   height: 50,
        //   margin: EdgeInsets.only(left: 10, right: 10),
        //   decoration: BoxDecoration(
        //       border: Border.all(color: Colors.black),
        //       color: Colors.white
        //   ),
        //   child: Row(
        //     children: [
        //       Text("#"),
        //       //TextFormField()
        //     ],
        //   ),
        // )
      ],);
  }
}
