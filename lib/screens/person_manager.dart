import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:responsive_widgets/responsive_widgets.dart';
import 'package:room_financal_manager/widgets/item_expenses_person.dart';
import 'package:room_financal_manager/widgets/top_bar.dart';

class PersonManager extends StatefulWidget {
  @override
  _PersonManagerState createState() => _PersonManagerState();
}

class _PersonManagerState extends State<PersonManager> {
  @override
  Widget build(BuildContext context) {
    ResponsiveWidgets.init(context,
      height: 1920, // Optional
      width: 1080, // Optional
      allowFontScaling: true, // Optional
    );
    return ResponsiveWidgets.builder(
      height: 1920, // Optional
      width: 1080, // Optional
      allowFontScaling: true, // Optional
      child: Container(
        height:  MediaQuery.of(context).size.height,
        color: Color(0xFFCDCCCC),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 50),
              child: ListView(
                children: [
                  SizedBox(height: 10,),
                 ItemExpensesPerson(),
                  SizedBox(height: 10,),
                  ItemExpensesPerson(),
                  SizedBox(height: 10,),
                  ItemExpensesPerson(),
                  SizedBox(height: 30,),
                ],

              ),
            ),
            TopBar(onButtonPresedCallback: onTopButtonPressed,),
          ],
        ),
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
  void onTopButtonPressed(int index) {
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
