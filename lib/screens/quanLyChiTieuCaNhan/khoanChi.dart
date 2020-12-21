import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:room_financal_manager/config/initialization.dart';
import 'package:room_financal_manager/models/KhoanChiCaNhan.dart';
import 'package:room_financal_manager/providers/caNhan_providers.dart';
import 'file:///D:/My%20Code/Code%20Android/DoAn2/room_financal_manager/lib/widgets/CaNhan/item_expenses_person.dart';


class KhoanChi extends StatefulWidget {
  List<KhoanChiCaNhan> dsKhoanChi;
  KhoanChi({this.dsKhoanChi});
  @override
  _KhoanChiState createState() => _KhoanChiState();
}

class _KhoanChiState extends State<KhoanChi> {
  RefreshController _refreshController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _refreshController = RefreshController(initialRefresh: false);
  }
  void _onRefresh() async{
    await Future.delayed(Duration(milliseconds: 1000));
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
      child: _person.status==Status.Loading?CircularProgressIndicator(
        backgroundColor: Colors.white,
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
        child:  ListView.builder(
            shrinkWrap: true,
            itemCount: (widget.dsKhoanChi != null)?widget.dsKhoanChi.length : 0,
            itemBuilder: (value, index){
              return ItemExpensesPerson(dsItem: widget.dsKhoanChi[index].listItemKhoanChi,ngayMua: widget.dsKhoanChi[index].ngayMua,);
            }
        ),
      ),
    );
  }
}

