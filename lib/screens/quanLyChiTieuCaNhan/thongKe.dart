import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:room_financal_manager/providers/home_provider.dart';
import 'package:room_financal_manager/widgets/ThongKe/bar_chart.dart';
import 'package:room_financal_manager/widgets/ThongKe/info_card.dart';

class ThongKe extends StatefulWidget {
  @override
  _ThongKeState createState() => _ThongKeState();
}

class _ThongKeState extends State<ThongKe> {
  List<Widget> listInfoCard = List();
  List<ItemLoaiKhoanChi> dsItem = [];
  RefreshController _refreshController;
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    _refreshController = RefreshController(initialRefresh: false);
    loadData();
  }

  loadData(){

    Provider.of<HomeProviders>(context,listen: false).getListLoaiKhoanChi();
    Provider.of<HomeProviders>(context, listen: false).dsLoaiKhoanChi.forEach((item) {
      listInfoCard.add(InfoCard(
        title: item.name,
        icon: item.icon,
        effectedNum: 75,
        press: () {},));
    });
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
    HomeProviders _home = Provider.of<HomeProviders>(context);
    return  Padding(
      padding: const EdgeInsets.only(top: 50),
      child: SmartRefresher(
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
            itemCount: 10,
            itemBuilder: (value, index){
              return Container(
                height: 100,
                width: 200,
                margin: EdgeInsets.only(top: 10),
                color: Colors.blue,
                child: Text(index.toString()),
              );
            }
        ),
      ),
    );

    // return Container(
    //   child: SingleChildScrollView(
    //     child: ListView(
    //       shrinkWrap: true,
    //       children: [
    //         Column(
    //           children: [
    //             Container(
    //               padding: EdgeInsets.only(left: 20, top: 60, right: 20, bottom: 20),
    //               width: double.infinity,
    //               decoration: BoxDecoration(
    //                 // color: kPrimaryColor.withOpacity(0.03),
    //                 borderRadius: BorderRadius.only(
    //                   bottomLeft: Radius.circular(50),
    //                   bottomRight: Radius.circular(50),
    //                 ),
    //               ),
    //               child: Wrap(
    //                   runSpacing: 20,
    //                   spacing: 20,
    //                   children: listInfoCard
    //               ),
    //             ),
    //             Container(
    //                 padding: EdgeInsets.only(left: 20, top: 60, right: 20, bottom: 20),
    //                 width: double.infinity,
    //                 decoration: BoxDecoration(
    //                   // color: kPrimaryColor.withOpacity(0.03),
    //                   borderRadius: BorderRadius.only(
    //                     bottomLeft: Radius.circular(50),
    //                     bottomRight: Radius.circular(50),
    //                   ),
    //                 ),
    //                 child: BarChartSample2()
    //
    //             ),
    //           ],
    //         ),
    //       ],
    //     ),
    //   ),
    // );
  }
}
