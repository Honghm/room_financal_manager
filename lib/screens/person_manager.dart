import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:room_financal_manager/widgets/item_expenses_person.dart';

class PersonManager extends StatefulWidget {
  @override
  _PersonManagerState createState() => _PersonManagerState();
}

class _PersonManagerState extends State<PersonManager> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height:  MediaQuery.of(context).size.height,
      color: Color(0xFFCDCCCC),
      child: ListView(
        children: [
          SizedBox(height: 10,),
         ItemExpensesPerson(),
          SizedBox(height: 10,),
          ItemExpensesPerson(),
          SizedBox(height: 10,),
          ItemExpensesPerson(),

        ],

      ),
    );
  }
}
