import 'package:flutter/material.dart';
import 'package:flutter_sliding_up_panel/sliding_up_panel_widget.dart';
import 'package:room_financal_manager/screens/group_manager.dart';
import 'package:room_financal_manager/screens/person_manager.dart';
import 'package:room_financal_manager/widgets/bottom_bar.dart';
import 'package:room_financal_manager/widgets/drawer_menu.dart';
import 'package:room_financal_manager/widgets/them_KhoanChi_CaNhan.dart';
import 'package:room_financal_manager/widgets/them_KhoanChi_Nhom.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}
bool isPerson = true;
bool isGroup = false;
class _HomePageState extends State<HomePage> {
  final _key = GlobalKey<ScaffoldState>();

  ScrollController scrollController;
  SlidingUpPanelController panelController = SlidingUpPanelController();
 double _padding = 50;
  @override
  void initState(){
    super.initState();
    scrollController = ScrollController();
    scrollController.addListener(() {
      if (scrollController.offset >=
          scrollController.position.maxScrollExtent &&
          !scrollController.position.outOfRange) {
        panelController.expand();
      } else if (scrollController.offset <=
          scrollController.position.minScrollExtent &&
          !scrollController.position.outOfRange) {
        panelController.anchor();
      } else {}
    });

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      key: _key,
      backgroundColor:   Color(0xFFCDCCCC),
      appBar: AppBar(
        backgroundColor: Color(0xFF42AF3B),
        leading: IconButton(icon: Icon(Icons.menu, color: Colors.black,), onPressed: (){
          _key.currentState.openDrawer();
        }),
        title: Text(isPerson?"QUẢN LÝ CHI TIÊU CÁ NHÂN":"QUẢN LÝ CHI TIÊU NHÓM",style: TextStyle(color: Colors.white,fontSize: 22, fontWeight: FontWeight.bold),),
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
            child: isPerson?PersonManager():GroupManager(),
          ),

          SlidingUpPanelWidget(

            child: Container(

              margin: EdgeInsets.fromLTRB(10, _padding, 10, 0),
              decoration: ShapeDecoration(
                color: Colors.white,
                shadows: [
                  BoxShadow(
                      blurRadius: 5.0,
                      spreadRadius: 2.0,
                      color: const Color(0x11000000))
                ],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: isPerson?ThemKhoanChiCaNhan(panelController,scrollController):ThemKhoanChiNhom(panelController,scrollController),
            ),
            controlHeight: 0.0,
            anchor: 0.4,
            panelController: panelController,
            enableOnTap: false, //Enable the onTap callback for control bar.
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor:  Color(0xFF76E65E),
        onPressed: (){
          setState(() {
            _padding = 10;
          });
          panelController.expand();
        },
        child: Icon(Icons.add, size: 40,),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      bottomNavigationBar: BottomBar(onIconPresedCallback: onBottomIconPressed,),
      drawer: DrawerMenu(),
    );
  }

  void onBottomIconPressed(int index) {

    // print(index);
    switch (index) {
      case 1:
        setState(() {
          isGroup = true;
          isPerson =false;
        });
        break;
      case 2:
        setState(() {
          isGroup = false;
          isPerson =true;
        });
        break;
    }
  }


}
