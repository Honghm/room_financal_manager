import 'package:flutter/material.dart';
import 'package:responsive_widgets/responsive_widgets.dart';
class TopBar extends StatefulWidget {
  Function(int) onButtonPressedCallback;
  String title1;
  String title2;
  String title3;
  int initSelected;
  TopBar(this.title1,this.title2, this.title3,{Key key, this.onButtonPressedCallback, this.initSelected}): super(key: key);
  @override
  _TopBarState createState() => _TopBarState();
}

class _TopBarState extends State<TopBar> {
  int _selectedIndex = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      _selectedIndex = widget.initSelected;
    });
  }
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
                            child: Text(widget.title1,style: TextStyle(fontSize: 20,color: _selectedIndex==1?Colors.white:Colors.black,fontWeight: FontWeight.bold))
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
                            child: Text(widget.title2,style: TextStyle(fontSize: 20,color: _selectedIndex==2?Colors.white:Colors.black,fontWeight: FontWeight.bold))
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
                            child: Text(widget.title3, style: TextStyle(fontSize: 20,color: _selectedIndex==3?Colors.white:Colors.black,fontWeight: FontWeight.bold),)
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
    widget.onButtonPressedCallback(index);
    setState(() {
      _selectedIndex = index;
    });
  }
}
