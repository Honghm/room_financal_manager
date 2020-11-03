import 'package:flutter/material.dart';
import 'package:room_financal_manager/widgets/item_expenses_group.dart';
import 'package:room_financal_manager/widgets/top_bar.dart';

class GroupManager extends StatefulWidget {
  @override
  _GroupManagerState createState() => _GroupManagerState();
}

class _GroupManagerState extends State<GroupManager> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height:  MediaQuery.of(context).size.height,
      color: Color(0xFFCDCCCC),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 50),
            child: ListView(
              children: [
                SizedBox(height: 10,),
                ItemExpensesGroup(),
                SizedBox(height: 10,),
                ItemExpensesGroup(),
                SizedBox(height: 10,),
                ItemExpensesGroup(),
                SizedBox(height: 30,),

              ],

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
