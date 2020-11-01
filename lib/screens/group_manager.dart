import 'package:flutter/material.dart';

class GroupManager extends StatefulWidget {
  @override
  _GroupManagerState createState() => _GroupManagerState();
}

class _GroupManagerState extends State<GroupManager> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height:  MediaQuery.of(context).size.height,
      color: Colors.blue,
    );
  }
}
