import 'package:flutter/material.dart';
import 'package:room_financal_manager/screens/group_manager.dart';
import 'package:room_financal_manager/screens/person_manager.dart';
import 'package:room_financal_manager/widgets/bottom_bar.dart';
import 'package:room_financal_manager/widgets/drawer_menu.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}
bool isPerson = true;
bool isGroup = false;
class _HomePageState extends State<HomePage> {
  final _key = GlobalKey<ScaffoldState>();
  final double _initFabHeight = 120.0;
  double _fabHeight;
  double _panelHeightOpen;
  double _panelHeightClosed = 95.0;
  @override
  void initState(){
    super.initState();

    _fabHeight = _initFabHeight;
  }

  @override
  Widget build(BuildContext context) {
    _panelHeightOpen = MediaQuery.of(context).size.height * .80;
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
          // SlidingUpPanel(
          //   panel: Center(
          //     child: Text("This is the sliding Widget"),
          //   ),
          //   body: Center(
          //     child: Text("This is the Widget behind the sliding panel"),
          //   ),
          // ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor:  Color(0xFF76E65E),
        onPressed: (){},
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
