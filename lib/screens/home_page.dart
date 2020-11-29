import 'package:flutter/material.dart';
import 'package:flutter_sliding_up_panel/sliding_up_panel_widget.dart';
import 'package:provider/provider.dart';
import 'package:room_financal_manager/providers/group_providers.dart';
import 'package:room_financal_manager/screens/group_manager.dart';
import 'package:room_financal_manager/screens/person_manager.dart';
import 'package:room_financal_manager/widgets/bottom_bar.dart';
import 'package:room_financal_manager/widgets/drawer_menu.dart';
import 'package:room_financal_manager/widgets/slide_up_panel.dart';
import 'package:room_financal_manager/widgets/them_KhoanChi_CaNhan.dart';
import 'package:room_financal_manager/widgets/them_KhoanChi_Nhom.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _key = GlobalKey<ScaffoldState>();

  SlidingUpPanelController panelController = SlidingUpPanelController();

  int _state = 2;
  String groupId;
  List<Map<String, dynamic>> groups = [];
  Future<void> loadData() async {
    groups = await Provider.of<GroupProviders>(context,listen: false).getListGroup();
    setState(() {

    });
  }
  Widget changeContainer(state){
    switch(state){
      // case 1: return _listGroup(groups);
      case 1: return GroupManager();
      case 2: return PersonManager();
    }
    return Container();
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }
  @override
  Widget build(BuildContext context) {
    GroupProviders _groups = Provider.of<GroupProviders>(context);
    return Scaffold(
      key: _key,
      backgroundColor:   Color(0xFFCDCCCC),
      appBar: AppBar(
        backgroundColor: Color(0xFF42AF3B),
        leading: IconButton(icon:_state == 2?Icon(Icons.menu, color: Colors.black,): (_groups.listGroupShow?Icon(Icons.menu, color: Colors.black,):Icon(Icons.arrow_back_rounded, color: Colors.white,)), onPressed: (){
          if(_state==2){
            _key.currentState.openDrawer();
          }else{
            if(_groups.listGroupShow)
              _key.currentState.openDrawer();
            else {
              _groups.listGroupShow = true;
              // Navigator.pop(context);
            }
          }
        }),
        title: Text(_state==2?"QUẢN LÝ CHI TIÊU CÁ NHÂN":"QUẢN LÝ CHI TIÊU NHÓM",style: TextStyle(color: Colors.white,fontSize: 22, fontWeight: FontWeight.bold),),
      ),
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
            child: changeContainer(_state)
          ),

         SlideUpPanel(panelController,state: _state,),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor:  Color(0xFF76E65E),
        onPressed: (){
          panelController.expand();
        },
        child: Icon(Icons.add, size: 40,),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      bottomNavigationBar: BottomBar(onIconPressedCallback: onBottomIconPressed,initSelected: 2,),
      drawer: DrawerMenu(),
    );
  }

  void onBottomIconPressed(int index) {

    // print(index);
    switch (index) {
      case 1:
        setState(() {
          _state = 1;
        });
        break;
      case 2:
        setState(() {
          _state = 2;
        });
        break;
    }
  }
  // Widget _listGroup(List<Map<String, dynamic>> data)  {
  //
  //   return Container(
  //     height:  MediaQuery.of(context).size.height,
  //     color: Color(0xFFCDCCCC),
  //     child: Stack(
  //       children: [
  //         Container(
  //           padding: EdgeInsets.only(left: 10,right: 10),
  //           height: 50,
  //          child: Row(
  //            mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //            children: [
  //              Container(height: 2,width:MediaQuery.of(context).size.width/2-100, color: Colors.black,),
  //            Text("NHÓM CỦA BẠN", style: TextStyle(color: Colors.black, fontSize: 20,fontWeight: FontWeight.bold),),
  //              Container(height: 2,width:MediaQuery.of(context).size.width/2-100, color: Colors.black,),
  //          ],),
  //         ),
  //         Padding(
  //           padding: EdgeInsets.only(top: 50,left: 10,right: 10),
  //           child: data==null?Text("Hiện bạn không có nhóm nào!"):ListView.builder(
  //               itemCount: data.length,
  //               itemBuilder: (_, index){
  //                 // print("name group: ${data[index]["name"]}");
  //                 return InkWell(
  //                   onTap: (){
  //                     // setState(() {
  //                     //   _state = 3;
  //                     //   groupId = data[index]["id"];
  //                     // });
  //                     Navigator.push(context,
  //                         MaterialPageRoute(builder: (context) => GroupManager(data[index]["id"])));
  //                   },
  //                   child: Container(
  //                     height: 100,
  //                     decoration: BoxDecoration(
  //                       borderRadius: BorderRadius.circular(20),
  //                       color: Colors.white,
  //                     ),
  //                     margin: EdgeInsets.only(bottom: 10),
  //                     child: Row(children: [
  //                       Container(
  //                         height: 80,
  //                         width: 80,
  //                         margin: EdgeInsets.only(left: 10),
  //                         decoration: BoxDecoration(
  //                           borderRadius: BorderRadius.circular(40),
  //                           border: Border.all(color: Colors.black),
  //                           color: Color(0xFFCDCCCC),
  //                         ),
  //                         child: data[index]["avatar"]==""? Icon(Icons.people,size: 50,color: Colors.white,):ClipOval(
  //                           child: SizedBox(
  //                               height: 80,
  //                               width: 80,
  //                               child: Image.network(data[index]["avatar"], fit: BoxFit.fill,)),
  //                         ),
  //                       ),
  //                       Container(
  //                         margin: EdgeInsets.only(left: 10, top: 10,bottom: 10),
  //                         child: Column(
  //                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                           crossAxisAlignment: CrossAxisAlignment.start,
  //                           children: [
  //                             Text(data[index]["name"].toString(), style: TextStyle(color: Colors.red, fontSize: 25,fontWeight: FontWeight.bold),),
  //                             Text("- Số thành viên: ${data[index]["member"].length}", style: TextStyle(color: Colors.black, fontSize: 18,fontWeight: FontWeight.bold),),
  //                             Text("- Quỹ hiện có: ${data[index]["group_funds"].toString()} vnđ", style: TextStyle(color: Colors.black, fontSize: 18,fontWeight: FontWeight.bold),),
  //                           ],
  //                         ),
  //                       )
  //                     ],),
  //                   ),
  //                 );
  //               }
  //           ),
  //         ),
  //
  //       ],
  //     ),
  //   );
  // }

}
