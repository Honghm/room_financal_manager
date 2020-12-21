import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:room_financal_manager/config/initialization.dart';
import 'package:room_financal_manager/models/KhoanChiNhom.dart';
import 'package:room_financal_manager/models/info_group.dart';
import 'package:room_financal_manager/models/user.dart';
import 'package:room_financal_manager/providers/group_providers.dart';
import 'package:room_financal_manager/providers/home_provider.dart';
import 'package:room_financal_manager/providers/user_provider.dart';
import 'package:room_financal_manager/screens/quanLyChiTieuCaNhan/thongKe.dart';
import 'package:room_financal_manager/screens/quanLyChiTieuNhom/khoanChi.dart';
import 'package:room_financal_manager/screens/quanLyChiTieuNhom/tongQuan.dart';
import 'package:room_financal_manager/services/storage.dart';
import 'file:///D:/My%20Code/Code%20Android/DoAn2/room_financal_manager/lib/widgets/Nhom/item_expenses_group.dart';
import 'package:room_financal_manager/widgets/top_bar.dart';

class GroupManager extends StatefulWidget {
  final UserData user;
  GroupManager({this.user});
  @override
  _GroupManagerState createState() => _GroupManagerState();
}

class _GroupManagerState extends State<GroupManager> {
  RefreshController _refreshController;
  int lengthData = 0;
  Map<String, String> listId = {};
  List<Map<String, dynamic>> listKhoanChi = [];
  List<KhoanChiNhom> dsKhoanChi = [];
  List<InformationGroup> dsNhom = [];
  //int _page  = 2;
  InformationGroup selectedGroup;
  String idGroup;
  final SecureStorage secureStorage = SecureStorage();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _refreshController = RefreshController(initialRefresh: false);
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
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _refreshController.dispose();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();

    // _refreshController();
  }
  void _onRefresh() async{
    print("Run here");
    if(mounted)
      setState(() {
        dsKhoanChi = [];
      });

    await loadListKhoanChi(idGroup).then((value){
      _refreshController.refreshCompleted();
    });

  }

  void _onLoading() async{
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    print("run here 2");
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    // items.add((items.length+1).toString());
    if(mounted)
      setState(() {

      });
    _refreshController.loadComplete();
  }

  @override
  Future<void> loadListGroup() async {
    if(dsNhom.isEmpty)
     await Provider.of<GroupProviders>(context,listen: false).getListGroup(widget.user).then((value) {
       dsNhom =  Provider.of<GroupProviders>(context,listen: false).dsNhom;
     });
    if(Provider.of<GroupProviders>(context,listen: false).haveNewGroup){
      await Provider.of<GroupProviders>(context,listen: false).getListGroup(widget.user).then((value) {
        dsNhom =  Provider.of<GroupProviders>(context,listen: false).dsNhom;
      });
      Provider.of<GroupProviders>(context,listen: false).haveNewGroup = false;
    }
  }
  Future<void> loadListKhoanChi(idGroup) async {
    if(dsKhoanChi.isEmpty){
      Provider.of<GroupProviders>(context,listen: false).getListMember(idGroup);
      await Provider.of<GroupProviders>(context, listen: false).danhSachKhoanChi(idGroup).then((value) {
        dsKhoanChi = Provider.of<GroupProviders>(context, listen: false).dsKhoanChiNhom;
      });
    }
  }
  Future<void> changeShowListGroup(bool change) async {
    Provider.of<GroupProviders>(context,listen: false).listGroupShow = change;
  }
  Widget _changeScreen(status, listGroupShow, screen){
    Future.delayed(Duration(milliseconds: 1000));
    if(screen == 7){
      secureStorage.deleteSecureData("idGroup");
        loadListGroup();
      return _listGroup(dsNhom);
    }else{
      if(idGroup!=""){
        loadListKhoanChi(idGroup);
        return _changePage(screen, status);
      }
        else
          return Container();
    }
  }


  Widget _listGroup(List<InformationGroup> data)  {
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
                //TextFormField(),
                Container(height: 2,width:MediaQuery.of(context).size.width/2-100, color: Colors.black,),
                Text("NHÓM CỦA BẠN", style: TextStyle(color: Colors.black, fontSize: 20,fontWeight: FontWeight.bold),),
                Container(height: 2,width:MediaQuery.of(context).size.width/2-100, color: Colors.black,),
              ],),
          ),
          Padding(
            padding: EdgeInsets.only(top: 50,left: 10,right: 10),
            child: data.isEmpty?Center(child: Text("Hiện bạn không có nhóm nào!", style: TextStyle(fontSize:20 ),)):ListView.builder(
                itemCount: data.length,
                itemBuilder: (_, index){
                  // print("name group: ${data[index]["name"]}");
                  return InkWell(
                    onTap: (){
                      Provider.of<HomeProviders>(context,listen: false).screen = 4;
                      setState(() {
                        idGroup = data[index].id;
                        Provider.of<GroupProviders>(context,listen: false).idGroup = idGroup;
                        secureStorage.writeSecureData("idGroup", idGroup);
                        changeShowListGroup(false);
                        Provider.of<GroupProviders>(context,listen: false).selectedGroup = data[index];
                        selectedGroup = data[index];
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
                          child: data[index].avatar ==""? Icon(Icons.people,size: 50,color: Colors.white,):ClipOval(
                            child: SizedBox(
                                height: 80,
                                width: 80,
                                child: Image.network(data[index].avatar, fit: BoxFit.fill,)),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 10, top: 10,bottom: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(data[index].nameGroup.toString(), style: TextStyle(color: Colors.red, fontSize: 25,fontWeight: FontWeight.bold),),
                              Text("- Số thành viên: ${data[index].members.length.toString()}", style: TextStyle(color: Colors.black, fontSize: 18,fontWeight: FontWeight.bold),),
                              Text("- Quỹ hiện có: ${data[index].groupFunds.toString()} vnđ", style: TextStyle(color: Colors.black, fontSize: 18,fontWeight: FontWeight.bold),),
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

  Widget _changePage(int screen, status){

      switch(screen){
        case 5:
          return TongQuan();
        case 4:
         return KhoanChi(
           dsKhoanChi: dsKhoanChi,
           refreshController: _refreshController,
           onLoading: _onLoading,
           onRefresh: _onRefresh,
         );
        case 6:
          return Container();
      }
  }
  @override
  Widget build(BuildContext context) {
    final _key = GlobalKey<ScaffoldState>();
    GroupProviders _groups = Provider.of<GroupProviders>(context);
    HomeProviders _home = Provider.of<HomeProviders>(context);
    if(_groups.haveNewGroup){
      loadListGroup();
     //  print("run here");
     //  _groups.getListGroup(widget.user).then((value) {
     //    dsNhom =  _groups.dsNhom;
     //  });
     // _groups.haveNewGroup = false;
    }
    return Scaffold(
      key: _key,
      backgroundColor:   Color(0xFFCDCCCC),
      body:Stack(
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

                  _changeScreen(_groups.status, _groups.listGroupShow, _home.screen ),
                  _groups.listGroupShow?Container():TopBar("Tổng quan", "Khoản chi", "Thống kê",onButtonPressedCallback: onTopButtonPressed,initSelected: _home.screen,),

                ],
              ),
            ),
          ),

        ],
      ),

    );
  }


  void onTopButtonPressed(int index) {
    switch (index) {
      case 1:
        Provider.of<HomeProviders>(context, listen: false).screen = 5;

        break;
      case 2:
        Provider.of<HomeProviders>(context, listen: false).screen = 4;

        break;
      case 3:
        Provider.of<HomeProviders>(context, listen: false).screen = 6;

        break;
    }
  }

}
