import 'package:flutter/material.dart';
import 'package:flutter_sliding_up_panel/sliding_up_panel_widget.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:room_financal_manager/config/initialization.dart';
import 'package:room_financal_manager/models/KhoanChiNhom.dart';

import 'package:room_financal_manager/providers/group_providers.dart';
import 'package:room_financal_manager/screens/home_page.dart';
import 'package:room_financal_manager/services/storage.dart';
import 'package:room_financal_manager/widgets/bottom_bar.dart';
import 'package:room_financal_manager/widgets/drawer_menu.dart';
import 'package:room_financal_manager/widgets/item_expenses_group.dart';
import 'package:room_financal_manager/widgets/slide_up_panel.dart';
import 'package:room_financal_manager/widgets/them_KhoanChi_Nhom.dart';
import 'package:room_financal_manager/widgets/top_bar.dart';

class GroupManager extends StatefulWidget {
  @override
  _GroupManagerState createState() => _GroupManagerState();
}

class _GroupManagerState extends State<GroupManager> {

  int lengthData = 0;
  Map<String, String> listId = {};
  List<Map<String, dynamic>> listKhoanChi = [];
  List<KhoanChiNhom> dsKhoanChi = [];
  List<Map<String, dynamic>> groups = [];
  List<String> members = [];
  int _page  = 2;
  // int _state = 1;
  // bool _listGroupShow = true;
  String idGroup;
  final SecureStorage secureStorage = SecureStorage();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(Provider.of<GroupProviders>(context,listen: false).listGroupShow) {
      loadListGroup();
      setState(() {

      });
    }
    else
      {
        secureStorage.readSecureData("idGroup").then((value){

          loadListKhoanChi(value);
          setState(() {
            idGroup = value;
          });
        });
      }
  }

  @override
  Future<void> loadListGroup() async {
    if(groups.isEmpty)
      groups = await Provider.of<GroupProviders>(context,listen: false).getListGroup();
  }
  Future<void> loadListKhoanChi(idGroup) async {
    if(dsKhoanChi.isEmpty){
      await Provider.of<GroupProviders>(context, listen: false).danhSachKhoanChi(idGroup).then((value) {
        dsKhoanChi = Provider.of<GroupProviders>(context, listen: false).dsKhoanChiNhom;
         // print("Run here: ${dsKhoanChi[0].listItemKhoanChi[0].noiDung}");
      });
    }




    // if(dsKhoanChi.isEmpty){
    //
    //
    // }
    // if(listKhoanChi.isEmpty) {
    //   listKhoanChi = await Provider.of<GroupProviders>(context, listen: false).getListKhoanChi(idGroup);
    //   await Provider.of<GroupProviders>(context, listen: false).getListMember(idGroup);
    // }
    if (this.mounted) setState((){});
  }
  Future<void> changeShowListGroup(bool change) async {
    Provider.of<GroupProviders>(context,listen: false).listGroupShow = change;
  }
  Widget _changeScreen(status, listGroupShow){
    if(listGroupShow){
      secureStorage.deleteSecureData("idGroup");
        loadListGroup();
      return _listGroup(groups);
    }else{
      if(idGroup!=""){
        loadListKhoanChi(idGroup);
        return _changePage(_page, status);
      }
        else
          return Container();
    }
  }


  Widget _listGroup(List<Map<String, dynamic>> data)  {

    return Container(
      height:  MediaQuery.of(context).size.height,
      color: Color(0xFFCDCCCC),
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.only(left: 10,right: 10),
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(height: 2,width:MediaQuery.of(context).size.width/2-100, color: Colors.black,),
                Text("NHÓM CỦA BẠN", style: TextStyle(color: Colors.black, fontSize: 20,fontWeight: FontWeight.bold),),
                Container(height: 2,width:MediaQuery.of(context).size.width/2-100, color: Colors.black,),
              ],),
          ),
          Padding(
            padding: EdgeInsets.only(top: 50,left: 10,right: 10),
            child: data==null?Text("Hiện bạn không có nhóm nào!"):ListView.builder(
                itemCount: data.length,
                itemBuilder: (_, index){
                  // print("name group: ${data[index]["name"]}");
                  return InkWell(
                    onTap: (){
                      // setState(() {
                      //   _state = 3;
                      //   groupId = data[index]["id"];
                      // });
                      // Navigator.push(context,
                      //     MaterialPageRoute(builder: (context) => GroupManager(data[index]["id"])));

                      setState(() {
                        idGroup = data[index]["id"];
                        Provider.of<GroupProviders>(context,listen: false).idGroup = idGroup;
                        secureStorage.writeSecureData("idGroup", idGroup);
                        changeShowListGroup(false);
                        // _listGroupShow = false;
                      });
                    },
                    child: Container(
                      height: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                      ),
                      margin: EdgeInsets.only(bottom: 10),
                      child: Row(children: [
                        Container(
                          height: 80,
                          width: 80,
                          margin: EdgeInsets.only(left: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40),
                            border: Border.all(color: Colors.black),
                            color: Color(0xFFCDCCCC),
                          ),
                          child: data[index]["avatar"]==""? Icon(Icons.people,size: 50,color: Colors.white,):ClipOval(
                            child: SizedBox(
                                height: 80,
                                width: 80,
                                child: Image.network(data[index]["avatar"], fit: BoxFit.fill,)),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 10, top: 10,bottom: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(data[index]["name"].toString(), style: TextStyle(color: Colors.red, fontSize: 25,fontWeight: FontWeight.bold),),
                              Text("- Số thành viên: ${data[index]["member"].length}", style: TextStyle(color: Colors.black, fontSize: 18,fontWeight: FontWeight.bold),),
                              Text("- Quỹ hiện có: ${data[index]["group_funds"].toString()} vnđ", style: TextStyle(color: Colors.black, fontSize: 18,fontWeight: FontWeight.bold),),
                            ],
                          ),
                        )
                      ],),
                    ),
                  );
                }
            ),
          ),

        ],
      ),
    );
  }

  Widget _changePage(int page, status){
      switch(page){
        case 1:
          return Container(
            child: Center(
              child: Text("Thống kê khoản thu")
            )
          );
        case 2:
          return  Padding(
            padding: const EdgeInsets.only(top: 50),
            child: status==Status.Loading?CircularProgressIndicator(
              backgroundColor: Colors.white,
            ):ListView.builder(
                itemCount: (dsKhoanChi != null)?dsKhoanChi.length : 0,
                itemBuilder: (value, index){
                  return ItemExpensesGroup(dsItem: dsKhoanChi[index].listItemKhoanChi,ngayMua: dsKhoanChi[index].ngayMua,);
                }

            ),
          );
        case 3:
          return Container(

            child: Center(
              child: Text("Thống kê chi tiêu"),
            ),
          );
      }
  }
  @override
  Widget build(BuildContext context) {
    final _key = GlobalKey<ScaffoldState>();
    SlidingUpPanelController _panelController = SlidingUpPanelController();
    GroupProviders _groups = Provider.of<GroupProviders>(context);
    return Scaffold(
      key: _key,
      backgroundColor:   Color(0xFFCDCCCC),
      // appBar: AppBar(
      //   backgroundColor: Color(0xFF42AF3B),
      //   leading: IconButton(icon: Icon(Icons.arrow_back_rounded, color: Colors.white,), onPressed: (){
      //     setState(() {
      //       listGroupShow = true;
      //     });
      //    Navigator.pop(context);
      //   }),
      //   title: Text("QUẢN LÝ CHI TIÊU NHÓM",style: TextStyle(color: Colors.white,fontSize: 22, fontWeight: FontWeight.bold),),
      // ),
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFF42AF3B),
                    Color(0xFF17B6A0)
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )
            ),
            child: Container(
              height:  MediaQuery.of(context).size.height,
              color: Color(0xFFCDCCCC),
              child: Stack(
                children: [
                 // _changePage(_page, _groups.status),
                  _changeScreen(_groups.status, _groups.listGroupShow),
                  _groups.listGroupShow?Container():TopBar("Tổng quan", "Khoản chi", "Thống kê",onButtonPressedCallback: onTopButtonPressed,initSelected: _page,),
                ],
              ),
            ),
          ),
          //SlideUpPanel(_panelController, state: 3,),
        ],
      ),
      // floatingActionButton: FloatingActionButton(
      //   backgroundColor:  Color(0xFF76E65E),
      //   onPressed: (){
      //     _panelController.expand();
      //   },
      //   child: Icon(Icons.add, size: 40,),
      // ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      //
      // bottomNavigationBar: listGroupShow?Container():BottomBar(onIconPressedCallback: onBottomIconPressed,initSelected: 1,),
      // drawer: DrawerMenu(),
    );
  }
  // void onBottomIconPressed(int index) {
  //   switch (index) {
  //     case 1:
  //       setState(() {
  //         _state = 1;
  //       });
  //       break;
  //     case 2:
  //       setState(() {
  //         _state = 2;
  //       });
  //       Navigator.pushReplacement(
  //           context,
  //           PageTransition(
  //               child: HomePage(),
  //               type: PageTransitionType.bottomToTop));
  //
  //
  //       break;
  //   }
  // }

  void onTopButtonPressed(int index) {
    switch (index) {
      case 1:
        setState(() {
          _page = 1;
        });
        break;
      case 2:

        setState(() {
          _page = 2;
        });
        break;
      case 3:

        setState(() {
          _page = 3;
        });
        break;
    }
  }

}
