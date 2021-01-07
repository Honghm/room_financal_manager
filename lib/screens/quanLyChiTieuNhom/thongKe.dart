
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:room_financal_manager/providers/group_providers.dart';
import 'package:room_financal_manager/providers/home_provider.dart';
import 'package:room_financal_manager/widgets/ThongKe/bar_chart.dart';


class ThongKe extends StatefulWidget {
 List<Map<String, String>> dsThongKe;
  ThongKe(this.dsThongKe);
  @override
  _ThongKeState createState() => _ThongKeState();
}

class _ThongKeState extends State<ThongKe> with SingleTickerProviderStateMixin{

  List<ItemLoaiKhoanChi> dsItem = [];
  RefreshController _refreshController;
  TabController _tabController;
  //TabController _tabController1;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("run here: ${widget.dsThongKe}");
    _refreshController = RefreshController(initialRefresh: false);
   // _tabController1 = new TabController(vsync: this, length: 12);
    _tabController = new TabController(vsync: this, length: 2,initialIndex: 1);
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
    //_tabController1.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    HomeProviders _home = Provider.of<HomeProviders>(context);
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    GroupProviders _groups = Provider.of<GroupProviders>(context);
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
            SizedBox(height: 50,),

            Container(height: 50,
            child: TabBar(
              controller: _tabController,
                //isScrollable: true,
                labelColor: Colors.black,
                labelStyle: TextStyle(color:  Colors.black, fontSize: 16,fontWeight: FontWeight.bold),
                tabs: <Tab>[
                 Tab(text: "Tháng trước",),
                  Tab(text: "Tháng này",),
                ]
            ),),
            Container(
             height: MediaQuery.of(context).size.height-100,
              child: TabBarView(
                controller: _tabController,
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 5,right: 5,top: 20),
                    height: height/3,
                    color: Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                            width: width/2-20,
                            // color: Colors.green,
                            padding: EdgeInsets.only(left: 5),
                            child: ListView.builder(
                                itemCount: _groups.selectedGroup.members.length,
                                itemBuilder: (_,index){
                                  return (index%2 == 0) ? Column(
                                    children: [
                                      Container(
                                        alignment: Alignment.centerLeft,
                                        child:  RichText(
                                          text: TextSpan(
                                              text: "${_groups.listName[_groups.selectedGroup.members[index]]}: ",
                                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
                                              children: <TextSpan>[
                                                TextSpan(
                                                  text: "${widget.dsThongKe[0][_groups.selectedGroup.members[index]]}K",
                                                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.red),
                                                )
                                              ]
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: _groups.selectedGroup.members.length/2*10,
                                      )
                                    ],
                                  ):Container();
                                })),
                        Container(
                            width: width/2-20,
                            // color: Colors.blue,
                            padding: EdgeInsets.only(left: 5),
                            child: ListView.builder(
                                itemCount: _groups.selectedGroup.members.length,
                                itemBuilder: (_,index) {

                                  return index%2!=0?Column(
                                    children: [
                                      Container(
                                        alignment: Alignment.centerLeft,
                                        child: RichText(
                                          text: TextSpan(
                                              text: "${_groups.listName[_groups.selectedGroup.members[index]]}: ",
                                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
                                              children: <TextSpan>[
                                                TextSpan(
                                                  text: "${widget.dsThongKe[0][_groups.selectedGroup.members[index]]}K",
                                                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.red),
                                                )
                                              ]
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: _groups.selectedGroup.members.length/2*10,
                                      )
                                    ],
                                  ):Container();
                                }))
                      ],),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 5,right: 5,top: 20),
                    height: height/3,
                    color: Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                            width: width/2-20,
                            // color: Colors.green,
                            padding: EdgeInsets.only(left: 5),
                            child: ListView.builder(
                                itemCount: _groups.selectedGroup.members.length,
                                itemBuilder: (_,index){
                                  return (index%2 == 0) ? Column(
                                    children: [
                                      Container(
                                        alignment: Alignment.centerLeft,
                                        child:  RichText(
                                          text: TextSpan(
                                              text: "${_groups.listName[_groups.selectedGroup.members[index]]}: ",
                                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
                                              children: <TextSpan>[
                                                TextSpan(
                                                  text: "${widget.dsThongKe[1][_groups.selectedGroup.members[index]]}K",
                                                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.red),
                                                )
                                              ]
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: _groups.selectedGroup.members.length/2*10,
                                      )
                                    ],
                                  ):Container();
                                })),
                        Container(
                            width: width/2-20,
                            // color: Colors.blue,
                            padding: EdgeInsets.only(left: 5),
                            child: ListView.builder(
                                itemCount: _groups.selectedGroup.members.length,
                                itemBuilder: (_,index) {

                                  return index%2!=0?Column(
                                    children: [
                                      Container(
                                        alignment: Alignment.centerLeft,
                                        child: RichText(
                                          text: TextSpan(
                                              text: "${_groups.listName[_groups.selectedGroup.members[index]]}: ",
                                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
                                              children: <TextSpan>[
                                                TextSpan(
                                                  text: "${widget.dsThongKe[1][_groups.selectedGroup.members[index]]}K",
                                                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.red),
                                                )
                                              ]
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: _groups.selectedGroup.members.length/2*10,
                                      )
                                    ],
                                  ):Container();
                                }))
                      ],),
                  ),
                ],
              ),
            )
          ],
        ),
        // ListView(
        //   shrinkWrap: true,
        //   children: [
        //     SizedBox(height: 60,),
        //     Container(
        //       height: 30,
        //       width: 100,
        //       padding: EdgeInsets.only(left: 10),
        //       decoration: BoxDecoration(
        //           border: Border(
        //               bottom: BorderSide(
        //                   width: 1,
        //                   color: Colors.black54
        //               )
        //           )
        //       ),
        //       child: Text("Loại chi tiêu", style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.green),),
        //     ),
        //     Padding(
        //       padding: const EdgeInsets.only(left: 10),
        //       child: Text("Thống kê khoản chi trong tháng ${ DateTime.now().month} theo loại chi tiêu"),
        //     ),
        //     Container(
        //         padding: EdgeInsets.only(left: 20, top: 10, right: 20, bottom: 20),
        //         width: double.infinity,
        //         decoration: BoxDecoration(
        //           // color: kPrimaryColor.withOpacity(0.03),
        //           borderRadius: BorderRadius.only(
        //             bottomLeft: Radius.circular(50),
        //             bottomRight: Radius.circular(50),
        //           ),
        //         ),
        //         child: Wrap(
        //           spacing: 20,
        //           runSpacing: 20,
        //           children: widget.listInfoCard,
        //         )
        //
        //     ),
        //
        //   ],
        // )
    );

  }
}
