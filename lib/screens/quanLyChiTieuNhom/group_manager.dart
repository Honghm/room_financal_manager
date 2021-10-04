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
import 'package:room_financal_manager/screens/quanLyChiTieuNhom/khoanChi.dart';
import 'package:room_financal_manager/screens/quanLyChiTieuNhom/thongKe.dart';
import 'package:room_financal_manager/screens/quanLyChiTieuNhom/tongQuan.dart';
import 'package:room_financal_manager/services/storage.dart';
import 'package:room_financal_manager/widgets/ThongKe/info_card.dart';

import 'package:room_financal_manager/widgets/top_bar.dart';

class GroupManager extends StatefulWidget {
  final UserData user;
  GroupManager({this.user});
  @override
  _GroupManagerState createState() => _GroupManagerState();
}

class _GroupManagerState extends State<GroupManager> {
  RefreshController _refreshController;
  List<Widget> listInfoCard = List(); //ds thống kê theo loại chi tiêu
  InformationGroup selectGroup;
  List<Map<String, String>> thongKe;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _refreshController = RefreshController(initialRefresh: false);
    if(Provider.of<GroupProviders>(context,listen: false).listGroupShow == false){
      selectGroup = Provider.of<GroupProviders>(context,listen: false).selectedGroup;
      Provider.of<GroupProviders>(context,listen: false).danhSachKhoanChi(Provider.of<GroupProviders>(context,listen: false).selectedGroup.id);
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

    Provider.of<GroupProviders>(context,listen: false).dsNhom = [];
    Provider.of<GroupProviders>(context,listen: false).getListGroup(widget.user);

    await Future.delayed(Duration(milliseconds: 1000));
    if(mounted)
      setState(() {

      });
    _refreshController.refreshCompleted();
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



  Future<void> changeShowListGroup(bool change) async {
    Provider.of<GroupProviders>(context,listen: false).listGroupShow = change;
  }



  Widget _listGroup(GroupProviders _groups)  {

    return SmartRefresher(
      controller: _refreshController,
      onRefresh: _onRefresh,
      onLoading: _onLoading,
      header: WaterDropMaterialHeader(
        backgroundColor: Colors.green,
      ),
      footer: CustomFooter(
        builder: (BuildContext context,LoadStatus mode){
          Widget body ;
          body =  CupertinoActivityIndicator();
          return Container(

            height: 55.0,
            child: Center(child:body),
          );
        },
      ),
      enablePullUp: false,
      enablePullDown: true,
      child: Container(
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
            _groups.status == Status.Loading?Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.white,
                ),
              ),
            ) :Padding(
              padding: EdgeInsets.only(top: 50,left: 10,right: 10),
              child: _groups.dsNhom.isEmpty?Center(child: Text("Hiện bạn không có nhóm nào!", style: TextStyle(fontSize:20 ),)):ListView.builder(
                  itemCount: _groups.dsNhom.length,
                  itemBuilder: (_, index){
                    return InkWell(
                      onTap: (){
                        _groups.danhSachKhoanChi(_groups.dsNhom[index].id);
                        Provider.of<GroupProviders>(context,listen: false).getListName(_groups.dsNhom[index]);
                        Provider.of<GroupProviders>(context,listen: false).getListMember(_groups.dsNhom[index].id);
                        setState(() {
                          _groups.selectedGroup = _groups.dsNhom[index];
                          thongKe = Provider.of<GroupProviders>(context,listen: false).thongKeKhoanChi_Thang(_groups.dsNhom[index],_groups.dsKhoanChiNhom);
                         _groups.listGroupShow = false;

                        });
                        Provider.of<HomeProviders>(context,listen: false).screen = 4;
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
                            child: _groups.dsNhom[index].avatar ==""? Icon(Icons.people,size: 50,color: Colors.white,):ClipOval(
                              child: SizedBox(
                                  height: 80,
                                  width: 80,
                                  child: Image.network(_groups.dsNhom[index].avatar, fit: BoxFit.fill,)),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 10, top: 10,bottom: 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(_groups.dsNhom[index].nameGroup.toString(), style: TextStyle(color: Colors.red, fontSize: 25,fontWeight: FontWeight.bold),),
                                Text("- Số thành viên: ${_groups.dsNhom[index].members.length.toString()}", style: TextStyle(color: Colors.black, fontSize: 18,fontWeight: FontWeight.bold),),
                                Text("- Quỹ hiện có: ${_groups.dsNhom[index].groupFunds.toString()}K", style: TextStyle(color: Colors.black, fontSize: 18,fontWeight: FontWeight.bold),),
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
      ),
    );
  }

  Widget _changePage(int screen, GroupProviders _groups){

      switch(screen){
        case 5:
          return TongQuan(

          );
        case 4:
         return KhoanChi(
           dsKhoanChi: _groups.dsKhoanChiNhom,
         );
        case 6:
          return ThongKe(thongKe);
      }
  }

  // loadDataThongKe({List<ItemLoaiKhoanChi> dsLoaiKhoanChi, List<KhoanChiNhom> dsKhoanChiNhom }){
  //   loadListInfoCard(
  //     dsKhoanChiNhom: dsKhoanChiNhom,
  //     dsLoaiKhoanChi: dsLoaiKhoanChi,
  //   );
  //
  // }

  loadListInfoCard({List<ItemLoaiKhoanChi> dsLoaiKhoanChi, List<KhoanChiNhom> dsKhoanChiNhom }) {
    listInfoCard.clear();
    dsLoaiKhoanChi.forEach((item) {
      List<double> dsTienChi = [];
      double TongChi = 0;
      dsKhoanChiNhom.forEach((data) {
        if(data.ngayMua.split("_")[1] == DateTime.now().month.toString()){
          data.listItemKhoanChi.forEach((value) {
            if(value.tenLoai == item.name){
              dsTienChi.add(double.parse(value.giaTien));
              TongChi += double.parse(value.giaTien);
            }
          });
        }
      });
      listInfoCard.add(InfoCard(
        title: item.name,
        icon: item.icon,
        dsTienChi: dsTienChi,
        TongChi: TongChi,
        press: () {},));
    });

  }

  @override
  Widget build(BuildContext context) {
    final _key = GlobalKey<ScaffoldState>();
    GroupProviders _groups = Provider.of<GroupProviders>(context);
    HomeProviders _home = Provider.of<HomeProviders>(context);

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
                  _groups.listGroupShow==true?_listGroup( _groups):_changePage(_home.screen, _groups),
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
        // loadDataThongKe(
        //   dsLoaiKhoanChi: Provider.of<HomeProviders>(context, listen: false).dsLoaiKhoanChi,
        //   dsKhoanChiNhom:  Provider.of<GroupProviders>(context, listen: false).dsKhoanChiNhom
        // );
        break;
    }
  }

}
