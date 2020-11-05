import 'package:flutter/material.dart';
import 'package:responsive_widgets/responsive_widgets.dart';
class TopBar extends StatefulWidget {
  final Function(int) onIconPresedCallback;
  TopBar({Key key, this.onIconPresedCallback}): super(key: key);
  @override
  _TopBarState createState() => _TopBarState();
}

class _TopBarState extends State<TopBar> {
  int _selectedIndex = 2;
  @override
  Widget build(BuildContext context) {
    ResponsiveWidgets.init(context,
      height: 1920, // Optional
      width: 1080, // Optional
      allowFontScaling: true, // Optional
    );
    return Container(
        height: 50.0,
        decoration: BoxDecoration(
          color: Color(0xFFCDCCCC),
        ),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                  height: 50.0,
                  width: MediaQuery.of(context).size.width /3,

                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      InkWell(
                        onTap: () {
                          _handlePressed(1);
                        },
                        child: Container(
                            width: 100,
                            height: 40,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Colors.white,

                            ),
                            child: Text("Khoản thu")
                        ),
                      ),

                    ],
                  )
              ),
              Container(
                  height: 50.0,
                  width: MediaQuery.of(context).size.width /3,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      InkWell(
                        onTap: () {
                          _handlePressed(1);
                        },
                        child: Container(
                            width: 100,
                            height: 40,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Colors.white,

                            ),
                            child: Text("Khoản chi")
                        ),
                      ),
                    ],
                  )
              ),

              Container(
                  height: 50.0,
                  width: MediaQuery.of(context).size.width /3,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      InkWell(
                        onTap: () {
                          _handlePressed(1);
                        },
                        child: Container(
                            width: 100,
                            height: 40,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Colors.white,

                            ),
                            child: Text("Thống kê")
                        ),
                      ),
                    ],
                  )
              ),
            ]
        )
    );
  }
  void _handlePressed(int index) {
    widget.onIconPresedCallback(index);
    setState(() {
      _selectedIndex = index;
    });
  }
}
