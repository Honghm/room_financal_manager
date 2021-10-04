import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sliding_up_panel/sliding_up_panel_widget.dart';
import 'package:provider/provider.dart';
import 'package:room_financal_manager/models/user.dart';
import 'package:room_financal_manager/providers/group_providers.dart';
import 'package:room_financal_manager/providers/home_provider.dart';
import 'package:room_financal_manager/providers/user_provider.dart';

class CreateGroup extends StatefulWidget {
 final SlidingUpPanelController panelController;
 UserData user;

  CreateGroup({this.panelController, this.user});
  @override
  _CreateGroupState createState() => _CreateGroupState();
}

class _CreateGroupState extends State<CreateGroup> {
  final _formKey = GlobalKey<FormState>();
  final _key = GlobalKey<ScaffoldState>();
  final TextEditingController addMemberController = TextEditingController();
  final TextEditingController nameGroupController = TextEditingController();
  final TextEditingController fundGroupController = TextEditingController();
  
  List<Map> listMember = [];
  List<String> listIdMember = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //widget.fromPersonal = false;
  }
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
    UserProvider _user =  Provider.of<UserProvider>(context);
    GroupProviders _group =  Provider.of<GroupProviders>(context);
    HomeProviders _home =  Provider.of<HomeProviders>(context);
    return Scaffold(
     key: _key,
      appBar: AppBar(
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 40,),
            Container(
                alignment: Alignment.center,
                child: Text("TẠO NHÓM CỦA BẠN", style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold,color: Colors.black),)),

            ///avatar nhóm
            SizedBox(height: 20,),
            Stack(
              alignment: Alignment.topRight,
              children: [
                ClipOval(
                  child: Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(color: Colors.black),
                        color: Color(0xFFCDCCCC),
                      ),
                      child: _image!=null?Image.file(_image, fit: BoxFit.fill,):widget.user.urlAvt==""?Icon(
                        Icons.person,
                        size: 50,
                        color: Colors.white,
                      ):Image.network(widget.user.urlAvt,fit: BoxFit.fill,)
                  ),
                ),
                Container(
                  width: 30,
                  height: 30,
                  padding: EdgeInsets.only(left:15,),
                  child: IconButton(icon: Icon(Icons.camera_alt),onPressed: (){
                    print("alooo");
                    _home.showPicker(context:context,success: getImageSuccess );
                  },),
                )
              ],
            ),

            ///Tên nhóm
            SizedBox(height: 20,),
            Container(
              margin: EdgeInsets.only(left: 0,right: 10),
              width: MediaQuery.of(context).size.width,
              height: 50,
              child: ListTile(
                leading: Text("Tên nhóm:",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                title: TextFormField(
                  controller: nameGroupController,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    labelText: "Nhập tên nhóm",
                  ),
                ),
              )
            ),

            ///Quỹ nhóm
            SizedBox(height: 20,),
            Container(
                margin: EdgeInsets.only(left: 0,right: 10),
                width: MediaQuery.of(context).size.width,
                height: 50,
                child: ListTile(
                  leading: Text("Quỹ nhóm:",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                  title: TextFormField(
                    controller: fundGroupController,
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: "Nhập quỹ nhóm",
                    ),
                  ),
                )
            ),

            ///Thêm thành viên
            SizedBox(height: 20,),
            Container(
                padding: EdgeInsets.only(left: 10,right: 10),
                width: MediaQuery.of(context).size.width,
                height: 200,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Thành viên:",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                    Container(
                      height: 200,
                      width: MediaQuery.of(context).size.width - 150,
                      decoration: BoxDecoration(
                        border: Border.all(width: 1)
                      ),
                      child: Column(
                        children: [
                          Container(
                            height: 40,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                              Container(
                                width: MediaQuery.of(context).size.width - 200,
                                  child: TextFormField(
                                    keyboardType: TextInputType.number,
                                    controller: addMemberController,
                                  )),
                                InkWell(
                                  onTap: () async{
                                    Map<String, dynamic> member = {};
                                    member = await _user.getNameById(addMemberController.text);
                                    if(member!=null){
                                      listMember.add(member);
                                      listIdMember.add(member["uid"]);
                                    }

                                    addMemberController.clear();
                                  },
                                  child: Container(
                                    height: 40,
                                      width: 40,
                                      alignment: Alignment.center,
                                      child: Text("ADD", style: TextStyle(fontWeight: FontWeight.bold),)),
                                ),
                                SizedBox(width: 5,)
                                //IconButton(icon: Icon(Icons.search), onPressed: (){})
                              ],
                            ),
                          ),

                          Container(
                            height: 150,
                            child: ListView.builder(
                              itemCount: listMember.length,
                                itemBuilder:(key,index){
                              return ListTile(
                                leading: Container(
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.circular(20)
                                  ),
                                ),
                                title: Text(listMember[index]["displayName"]),
                                subtitle: Text("#${listMember[index]["uid"]}"),
                                trailing: IconButton(icon: Icon(Icons.delete, size: 20,),onPressed: (){},),
                              );
                            }),
                          )
                        ],
                      ),
                    ),
                  ],
                )
            ),

            ///Button điều hướng
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
                      onPressed: () {
                        String idGroup =  FirebaseFirestore.instance.collection("Groups").doc().id;
                        _group.addNewGroup(idGroup,_image, nameGroupController.text,fundGroupController.text, listIdMember, widget.user);
                        // _group.getListGroup(widget.user);
                        nameGroupController.clear();
                        listMember.clear();
                        listIdMember.clear();
                       Navigator.pop(context);
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
                        nameGroupController.clear();
                        fundGroupController.clear();
                        listMember.clear();
                        listIdMember.clear();
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ],),
            ),
            SizedBox(height: 20,),
          ],
        ),
      ),
    );
  }
}
