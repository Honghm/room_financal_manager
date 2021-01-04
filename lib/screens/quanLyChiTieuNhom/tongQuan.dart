import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:room_financal_manager/models/info_group.dart';
import 'package:room_financal_manager/models/user.dart';
import 'package:room_financal_manager/providers/group_providers.dart';
import 'package:room_financal_manager/screens/quanLyChiTieuNhom/updateTongQuan.dart';

class TongQuan extends StatefulWidget {
  final InformationGroup selectedGroup;
  final UserData user;
  TongQuan({this.selectedGroup, this.user});
  @override
  _TongQuanState createState() => _TongQuanState();
}

class _TongQuanState extends State<TongQuan> {

  final _key = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  RefreshController _refreshController;
  List<TextEditingController> listMoney = [];
  List<String> member = [];

  final TextEditingController test = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _refreshController = RefreshController(initialRefresh: false);
    loadData();
    setState(() {

    });
  }
  loadData() {
     widget.selectedGroup.members.forEach((item) {
        listMoney.add(new TextEditingController(text: widget.selectedGroup.detailMoney[item]));
      });

  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _refreshController.dispose();
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
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    GroupProviders _groups = Provider.of<GroupProviders>(context);
    return SingleChildScrollView(
      child: Container(
        width: width-20,
        height: height-50,
        margin: EdgeInsets.only(left: 10,right: 10,top: 60,bottom: 40),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20)
        ),
        child: SmartRefresher(
          // key: _key,
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
          child:  Form(
            key: _formKey,
            child: Column(
              children: [
                ///Hiển thị thông tin tổng quan của nhóm: avatar, tên, quỹ nhóm,...
                Container(
                    height: height/4,
                    child:  Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(height: 20,),
                        Container(
                          height: 100,
                          width: 100,
                          margin: EdgeInsets.only(left: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            border: Border.all(color: Colors.black),
                            color: Color(0xFFCDCCCC),
                          ),
                          child: _groups.selectedGroup.avatar ==""? Icon(Icons.people,size: 50,color: Colors.white,):ClipOval(
                            child: SizedBox(
                                height: 80,
                                width: 80,
                                child: Image.network(_groups.selectedGroup.avatar, fit: BoxFit.fill,)),
                          ),
                        ),
                        SizedBox(height: 10,),
                        Text(_groups.selectedGroup.nameGroup, style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: Colors.red),),
                        Text("Quỹ nhóm hiện có: ${_groups.selectedGroup.groupFunds}",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.red)),

                      ],
                    )
                ),
                SizedBox(height: 20,),
                ///Hiển thị thông tin số tiền hiện có của các thành viên trong nhóm
                Container(
                  padding: EdgeInsets.only(left: 5,right: 5,),
                  height: height/3,
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
                                //print(_groups.getNameById(_groups.selectedGroup.members[index]));
                                return (index%2 == 0) ? Column(
                                  children: [
                                    // ListTile(
                                    //   leading: Text("${listName[_groups.selectedGroup.members[index]]}: ",  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black), ),
                                    //   title:TextFormField(
                                    //     keyboardType: TextInputType.number,
                                    //     controller: listMoney[index],
                                    //     onChanged: (value){
                                    //       listMoney[index].text = value;
                                    //     },
                                    //     onSaved: (String value) {
                                    //     },
                                    //     //readOnly: !isUpdate,
                                    //   ),
                                    // )
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      child:  RichText(
                                        text: TextSpan(
                                            text: "${_groups.listName[_groups.selectedGroup.members[index]]}: ",
                                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
                                            children: <TextSpan>[
                                              TextSpan(
                                                text: "${_groups.selectedGroup.detailMoney[_groups.selectedGroup.members[index]]}K",
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
                                                text: "${_groups.selectedGroup.detailMoney[_groups.selectedGroup.members[index]]}K",
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

                ///Buttom điều hướng cho phép chỉnh sửa thông tin của nhóm
                (widget.user.id==widget.selectedGroup.idCreator)?Container(
                  height: 50,
                  width: 200,
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(25))),
                    onPressed: (){
                      // setState(() {
                      //   isUpdate = true;
                      // });
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => UpdateTongQuan(listMoney: listMoney,listName: _groups.listName,selectedGroup: widget.selectedGroup,)));
                    },
                    color: Colors.green,
                    child: Text("Cập nhật",style: TextStyle(fontSize: 18,color: Colors.white,fontWeight: FontWeight.bold),),
                  ),
                ):Container()
              ],
            ),
          ),
        ),
      ),
    );
  }
  Widget detailMoneyOfMember (name,  money) {
    TextEditingController moneyController = TextEditingController(text: money);
    return Container(
      child: ListTile(
        leading: Text(name),
        title: TextFormField(
          controller: moneyController,
        ),
      ),
    );
}
}
