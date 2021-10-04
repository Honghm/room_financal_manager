import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:room_financal_manager/providers/home_provider.dart';
import 'package:room_financal_manager/widgets/ThongKe/bar_chart.dart';
import 'package:room_financal_manager/widgets/ThongKe/info_card.dart';

class ThongKe extends StatefulWidget {
  final List<Widget> listInfoCard;
  final List<double> thongKeKhoanChi;
  final List<double> thongKeKhoanThu;
  ThongKe({this.listInfoCard, this.thongKeKhoanThu, this.thongKeKhoanChi});
  @override
  _ThongKeState createState() => _ThongKeState();
}

class _ThongKeState extends State<ThongKe> {

  List<ItemLoaiKhoanChi> dsItem = [];
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
    HomeProviders _home = Provider.of<HomeProviders>(context);
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
      child:  ListView(
        shrinkWrap: true,
        children: [
          SizedBox(height: 60,),
          Container(
            height: 30,
            width: 100,
            padding: EdgeInsets.only(left: 10),
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(
                        width: 1,
                        color: Colors.black54
                    )
                )
            ),
            child: Text("Loại chi tiêu", style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.green),),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text("Thống kê khoản chi trong tháng ${ DateTime.now().month} theo loại chi tiêu"),
          ),
          Container(
              padding: EdgeInsets.only(left: 20, top: 10, right: 20, bottom: 20),
              width: double.infinity,
              decoration: BoxDecoration(
                // color: kPrimaryColor.withOpacity(0.03),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(50),
                  bottomRight: Radius.circular(50),
                ),
              ),
              child: Wrap(
                spacing: 20,
                runSpacing: 20,
                children: widget.listInfoCard,
              )

          ),
          Container(
            height: 30,
            width: 100,
            padding: EdgeInsets.only(left: 10),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  width: 1,
                  color: Colors.black54
                )
              )
            ),
            child: Text("Thống kê tuần", style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.green),),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text("Thống kê chi tiêu trong tháng ${ DateTime.now().month} theo tuần"),
          ),
          Container(
              padding: EdgeInsets.only(left: 10, top: 10, right: 10, bottom: 40),
              width: double.infinity,
              decoration: BoxDecoration(
                // color: kPrimaryColor.withOpacity(0.03),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(50),
                  bottomRight: Radius.circular(50),
                ),
              ),
              child: BarChartThongKeThang(thongKeKhoanChi: widget.thongKeKhoanChi, thongKeKhoanThu: widget.thongKeKhoanThu,)

          ),

        ],
      )
    );

  }
}
