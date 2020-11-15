import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:room_financal_manager/models/expendituresGroup.dart';
import 'package:room_financal_manager/providers/group_providers.dart';
import 'package:room_financal_manager/widgets/item_expenses_group.dart';
import 'package:room_financal_manager/widgets/top_bar.dart';

class GroupManager extends StatefulWidget {
  @override
  _GroupManagerState createState() => _GroupManagerState();
}

class _GroupManagerState extends State<GroupManager> {

  int lengthData = 0;
  Map<String, String> listId = {};
  List<Map<String, dynamic>> listKhoanChi = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }
  Future<void> loadData() async {
    listKhoanChi = await Provider.of<GroupProviders>(context,listen: false).getListKhoanChi();
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    // GroupProviders KhoanChi = Provider.of<GroupProviders>(context);
    return Container(
      height:  MediaQuery.of(context).size.height,
      color: Color(0xFFCDCCCC),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 50),
            child: ListView.builder(
              itemCount: (listKhoanChi != null)?listKhoanChi.length : 0,
              itemBuilder: (value, index){
                return ItemExpensesGroup(listKhoanChi[index]);
              }

            ),
          ),
          TopBar(onIconPresedCallback: onBottomIconPressed,),
        ],
      ),
    );
  }
  void onBottomIconPressed(int index) {
    // print(index);
    // switch (index) {
    //   case 1:
    //     setState(() {
    //       isGroup = true;
    //       isPerson =false;
    //     });
    //     break;
    //   case 2:
    //     setState(() {
    //       isGroup = false;
    //       isPerson =true;
    //     });
    //     break;
    // }
  }
}
