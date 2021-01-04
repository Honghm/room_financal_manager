import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:room_financal_manager/config/initialization.dart';
import 'package:room_financal_manager/models/KhoanChiCaNhan.dart';
import 'package:room_financal_manager/models/user.dart';
import 'package:room_financal_manager/providers/caNhan_providers.dart';
import 'file:///D:/My%20Code/Code%20Android/DoAn2/room_financal_manager/lib/widgets/CaNhan/item_KhoanChi_CaNhan.dart';


class KhoanChi extends StatefulWidget {
  List<KhoanChiCaNhan> dsKhoanChi;
  UserData user;
  KhoanChi({this.dsKhoanChi, this.user});
  @override
  _KhoanChiState createState() => _KhoanChiState();
}

class _KhoanChiState extends State<KhoanChi> {
  RefreshController _refreshController;
  List<KhoanChiCaNhan> _dsKhoanChi = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _refreshController = RefreshController(initialRefresh: false);
    _dsKhoanChi = widget.dsKhoanChi;
  }
  void _onRefresh() async{
    await Future.delayed(Duration(milliseconds: 1000));
    _dsKhoanChi.clear();
    await Provider.of<CaNhanProviders>(context,listen: false).danhSachKhoanChi(widget.user.id).then((value) {
    _dsKhoanChi =  Provider.of<CaNhanProviders>(context,listen: false).dsKhoanChiCaNhan;
    });
    setState(() {

    });
    _refreshController.refreshCompleted();
  }

  void _onLoading() async{
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));


    // if failed,use loadFailed(),if no data return,use LoadNodata()
    // items.add((items.length+1).toString());
    if(mounted)
      setState(() {

      });
    _refreshController.loadComplete();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _refreshController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    CaNhanProviders _person = Provider.of<CaNhanProviders>(context);
    return  Padding(
      padding: const EdgeInsets.only(top: 50),
      child: _person.status==Status.Loading?Container(
        height: MediaQuery.of(context).size.height,
        width:  MediaQuery.of(context).size.width,

        child: Center(
          child: CircularProgressIndicator(
            backgroundColor: Colors.white,
          ),
        ),
      ):SmartRefresher(
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
        child:  (_dsKhoanChi.isNotEmpty)?ListView.builder(
          padding: EdgeInsets.only(bottom: 40),
            shrinkWrap: true,
            itemCount: (_dsKhoanChi.isNotEmpty)?_dsKhoanChi.length : 0,
            itemBuilder: (value, index){
              return ItemExpensesPerson(dsItem: _dsKhoanChi[index].listItemKhoanChi,ngayMua: _dsKhoanChi[index].ngayMua,);
            }
        ):Center(child: Text("Không có dữ liệu!",style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold,color: Colors.black),),),
      ),
    );
  }
}

