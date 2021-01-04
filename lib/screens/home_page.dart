import 'package:flutter/material.dart';
import 'package:flutter_sliding_up_panel/sliding_up_panel_widget.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:room_financal_manager/models/KhoanChiCaNhan.dart';
import 'package:room_financal_manager/models/KhoanThuCaNhan.dart';
import 'package:room_financal_manager/models/info_group.dart';
import 'package:room_financal_manager/models/user.dart';
import 'package:room_financal_manager/providers/caNhan_providers.dart';
import 'package:room_financal_manager/providers/group_providers.dart';
import 'package:room_financal_manager/providers/home_provider.dart';
import 'package:room_financal_manager/widgets/CaNhan/them_KhoanChi_CaNhan.dart';
import 'package:room_financal_manager/widgets/CaNhan/them_KhoanThu_CaNhan.dart';
import 'package:room_financal_manager/widgets/Nhom/create_group.dart';
import 'package:room_financal_manager/widgets/Nhom/them_KhoanChi_Nhom.dart';
import 'package:room_financal_manager/widgets/ThongKe/info_card.dart';
import 'package:room_financal_manager/widgets/bottom_bar.dart';
import 'package:room_financal_manager/widgets/drawer_menu.dart';
import 'package:room_financal_manager/widgets/slide_up_panel.dart';

import 'quanLyChiTieuCaNhan/person_manager.dart';
import 'quanLyChiTieuNhom/group_manager.dart';


class HomePage extends StatefulWidget {
  final UserData user;
  HomePage({this.user});
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _key = GlobalKey<ScaffoldState>();

  SlidingUpPanelController panelController = SlidingUpPanelController();



  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }




  Widget changeContainer(screen,){
    switch(screen){
      case 1:case 2:case 3:
      return PersonManager(
        user: widget.user,
      );
      case 4:case 5:case 6:case 7:
      return GroupManager(
          user: widget.user
      );
      default:
        return Container();
    }


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
            child: changeContainer(_home.screen,)
          ),


        // SlideUpPanel(panelController,state: _home.screen, user: widget.user,),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor:  Color(0xFF76E65E),
        onPressed: (){


            switch(_home.screen){
              case 1:{
                return Navigator.push(
                    context,
                    PageTransition(
                        child: ThemKhoanChiCaNhan(user: widget.user,),
                        type: PageTransitionType.bottomToTop));
              }
              case 2:{
                return Navigator.push(
                    context,
                    PageTransition(
                        child: ThemKhoanThuCaNhan(user: widget.user,),
                        type: PageTransitionType.bottomToTop));
              }
              case 4:{
                return Navigator.push(
                    context,
                    PageTransition(
                        child: ThemKhoanChiNhom(panelController,widget.user),
                        type: PageTransitionType.bottomToTop));
              }
              case 7:{
                return Navigator.push(
                    context,
                    PageTransition(
                        child: CreateGroup(panelController: panelController,user: widget.user,),
                        type: PageTransitionType.bottomToTop));
              }
            }
            //panelController.expand();
        },
        child: Icon(Icons.add, size: 40,),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      bottomNavigationBar: BottomBar(onIconPressedCallback: onBottomIconPressed,initSelected: 2,),
      drawer: DrawerMenu(user: widget.user,),
    );
  }

  void onBottomIconPressed(int index) {

    // print(index);
    switch (index) {
      case 1:
        if(Provider.of<GroupProviders>(context, listen: false).listGroupShow)
          Provider.of<HomeProviders>(context, listen: false).screen = 7;
        else
          Provider.of<HomeProviders>(context, listen: false).screen = 4;
        // setState(() {
        //
        // });
        break;
      case 2:
        Provider.of<HomeProviders>(context, listen: false).screen = 1;

        break;
    }
  }

}
