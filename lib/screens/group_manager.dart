import 'package:flutter/material.dart';
import 'package:flutter_sliding_up_panel/sliding_up_panel_widget.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:room_financal_manager/config/initialization.dart';
import 'package:room_financal_manager/models/expendituresGroup.dart';
import 'package:room_financal_manager/providers/group_providers.dart';
import 'package:room_financal_manager/screens/home_page.dart';
import 'package:room_financal_manager/widgets/bottom_bar.dart';
import 'package:room_financal_manager/widgets/drawer_menu.dart';
import 'package:room_financal_manager/widgets/item_expenses_group.dart';
import 'package:room_financal_manager/widgets/slide_up_panel.dart';
import 'package:room_financal_manager/widgets/them_KhoanChi_Nhom.dart';
import 'package:room_financal_manager/widgets/top_bar.dart';

class GroupManager extends StatefulWidget {
  String idGroup;

  GroupManager(this.idGroup);

  @override
  _GroupManagerState createState() => _GroupManagerState();
}

class _GroupManagerState extends State<GroupManager> {

  int lengthData = 0;
  Map<String, String> listId = {};
  List<Map<String, dynamic>> listKhoanChi = [];
  int _page  = 2;
  int _state = 1;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }
  Future<void> loadData() async {
    listKhoanChi = await Provider.of<GroupProviders>(context,listen: false).getListKhoanChi(widget.idGroup);
    setState(() {

    });
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
              itemCount: (listKhoanChi != null)?listKhoanChi.length : 0,
              itemBuilder: (value, index){
                return ItemExpensesGroup(listKhoanChi[index]);
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
      appBar: AppBar(
        backgroundColor: Color(0xFF42AF3B),
        leading: IconButton(icon: Icon(Icons.menu, color: Colors.black,), onPressed: (){
          _key.currentState.openDrawer();
        }),
        title: Text("QUẢN LÝ CHI TIÊU NHÓM",style: TextStyle(color: Colors.white,fontSize: 22, fontWeight: FontWeight.bold),),
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
            child: Container(
              height:  MediaQuery.of(context).size.height,
              color: Color(0xFFCDCCCC),
              child: Stack(
                children: [
                 _changePage(_page, _groups.status),
                  TopBar(onButtonPresedCallback: onTopButtonPressed,),
                ],
              ),
            ),
          ),
          SlideUpPanel(_panelController, state: 3,),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor:  Color(0xFF76E65E),
        onPressed: (){
          _panelController.expand();
        },
        child: Icon(Icons.add, size: 40,),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      bottomNavigationBar: BottomBar(onIconPresedCallback: onBottomIconPressed,initSelected: 1,),
      drawer: DrawerMenu(),
    );
  }
  void onBottomIconPressed(int index) {
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
        Navigator.pushReplacement(
            context,
            PageTransition(
                child: HomePage(),
                type: PageTransitionType.bottomToTop));


        break;
    }
  }
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
