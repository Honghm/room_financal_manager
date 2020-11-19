import 'package:flutter/material.dart';
import 'package:responsive_widgets/responsive_widgets.dart';
class TopBar extends StatefulWidget {
  final Function(int) onButtonPresedCallback;
  TopBar({Key key, this.onButtonPresedCallback}): super(key: key);
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
                                color: _selectedIndex==1?Color(0xff07E459):Colors.white,
                                border: Border.all(
                                    color: Color(0xff04FF2F)
                                )

                            ),
                            child: Text("Khoản thu",style: TextStyle(fontSize: 20,color: _selectedIndex==1?Colors.white:Colors.black,fontWeight: FontWeight.bold))
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
                          _handlePressed(2);
                        },
                        child: Container(
                            width: 100,
                            height: 40,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: _selectedIndex==2?Color(0xff07E459):Colors.white,
                                border: Border.all(
                                    color: Color(0xff04FF2F)
                                )

                            ),
                            child: Text("Khoản chi",style: TextStyle(fontSize: 20,color: _selectedIndex==2?Colors.white:Colors.black,fontWeight: FontWeight.bold))
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
                          _handlePressed(3);
                        },
                        child: Container(
                            width: 100,
                            height: 40,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: _selectedIndex==3?Color(0xff07E459):Colors.white,
                              border: Border.all(
                                color: Color(0xff04FF2F)
                              )
                            ),
                            child: Text("Thống kê", style: TextStyle(fontSize: 20,color: _selectedIndex==3?Colors.white:Colors.black,fontWeight: FontWeight.bold),)
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
    widget.onButtonPresedCallback(index);
    setState(() {
      _selectedIndex = index;
    });
  }
}
