import 'package:flutter/material.dart';
import 'package:flutter_sliding_up_panel/sliding_up_panel_widget.dart';
import 'package:provider/provider.dart';
import 'package:room_financal_manager/models/info_group.dart';
import 'package:room_financal_manager/models/user.dart';
import 'package:room_financal_manager/providers/group_providers.dart';
import 'package:room_financal_manager/providers/home_provider.dart';
import 'file:///D:/My%20Code/Code%20Android/DoAn2/room_financal_manager/lib/screens/quanLyChiTieuNhom/group_manager.dart';
import 'file:///D:/My%20Code/Code%20Android/DoAn2/room_financal_manager/lib/screens/quanLyChiTieuCaNhan/person_manager.dart';
import 'package:room_financal_manager/widgets/bottom_bar.dart';
import 'package:room_financal_manager/widgets/drawer_menu.dart';
import 'package:room_financal_manager/widgets/slide_up_panel.dart';
import 'file:///D:/My%20Code/Code%20Android/DoAn2/room_financal_manager/lib/widgets/CaNhan/them_KhoanChi_CaNhan.dart';
import 'file:///D:/My%20Code/Code%20Android/DoAn2/room_financal_manager/lib/widgets/Nhom/them_KhoanChi_Nhom.dart';

class HomePage extends StatefulWidget {
  final UserData user;
  HomePage({this.user});
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _key = GlobalKey<ScaffoldState>();

  SlidingUpPanelController panelController = SlidingUpPanelController();

  //int _state = 2;
  Widget changeContainer(screen){
    switch(screen){
      // case 1: return _listGroup(groups);
      case 1:case 2:case 3: return PersonManager();
      case 4:case 5:case 6:case 7: return GroupManager(user: widget.user);

    }
    return Container();
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // loadData();
  }
  @override
  Widget build(BuildContext context) {
    GroupProviders _groups = Provider.of<GroupProviders>(context);
    HomeProviders _home = Provider.of<HomeProviders>(context);
    return Scaffold(
      key: _key,
      backgroundColor:   Color(0xFFCDCCCC),
      appBar: AppBar(
        backgroundColor: Color(0xFF42AF3B),
        leading: IconButton(icon:_home.screen == 1?Icon(Icons.menu, color: Colors.black,): (_groups.listGroupShow?Icon(Icons.menu, color: Colors.black,):Icon(Icons.arrow_back_rounded, color: Colors.white,)), onPressed: (){
          if(_home.screen==1){
            _key.currentState.openDrawer();
          }else{
            if(_groups.listGroupShow)
              _key.currentState.openDrawer();
            else {
              _groups.listGroupShow = true;
              _home.screen = 7;
              // Navigator.pop(context);
            }
          }
        }),
        title: Text((_home.screen==1||_home.screen==2||_home.screen==3)?"QUẢN LÝ CHI TIÊU CÁ NHÂN":"QUẢN LÝ CHI TIÊU NHÓM",style: TextStyle(color: Colors.white,fontSize: 22, fontWeight: FontWeight.bold),),
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
            child: changeContainer(_home.screen)
          ),


         SlideUpPanel(panelController,state: _home.screen,),
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
        Provider.of<HomeProviders>(context, listen: false).screen = 7;
        // setState(() {
        //
        // });
        break;
      case 2:
        Provider.of<HomeProviders>(context, listen: false).screen = 1;
        // setState(() {
        //
        // });
        break;
    }
  }

}
