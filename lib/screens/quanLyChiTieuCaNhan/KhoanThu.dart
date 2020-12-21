import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:room_financal_manager/config/initialization.dart';
import 'package:room_financal_manager/models/KhoanThuCaNhan.dart';
import 'package:room_financal_manager/providers/caNhan_providers.dart';
import 'package:room_financal_manager/widgets/CaNhan/item_KhoanThu_CaNhan.dart';

class KhoanThu extends StatefulWidget {
  RefreshController refreshController;
  List<KhoanThuCaNhan> dsKhoanThu;
  KhoanThu({this.dsKhoanThu, this.refreshController});
  @override
  _KhoanThuState createState() => _KhoanThuState();
}

class _KhoanThuState extends State<KhoanThu> {
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
        child: Column(
          children: [
            ListView.builder(
                shrinkWrap: true,
                itemCount: (widget.dsKhoanThu != null)?widget.dsKhoanThu.length : 0,
                itemBuilder: (value, index){
                  return ItemRevenuePerson(dsItem: widget.dsKhoanThu[index].listItemKhoanChi,ngayMua: widget.dsKhoanThu[index].ngayMua,);
                }
            ),
          ],
        ),
      ),
    );
  }
}
