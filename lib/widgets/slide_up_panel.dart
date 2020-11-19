import 'package:flutter/material.dart';
import 'package:flutter_sliding_up_panel/sliding_up_panel_widget.dart';
import 'package:room_financal_manager/widgets/them_KhoanChi_Nhom.dart';

import 'them_KhoanChi_CaNhan.dart';

class SlideUpPanel extends StatefulWidget {
  SlidingUpPanelController panelController;
  int state;
  SlideUpPanel(this.panelController, {this.state});
  @override
  _SlideUpPanelState createState() => _SlideUpPanelState();
}

class _SlideUpPanelState extends State<SlideUpPanel> {
  double _padding = 50;
  Widget changeScreen(){
    switch(widget.state){
      case 1:
        return ThemKhoanChiCaNhan(widget.panelController);
      case 3:
        return ThemKhoanChiNhom(widget.panelController);
    }
    return null;
  }
  @override
  Widget build(BuildContext context) {
    return SlidingUpPanelWidget(
      onStatusChanged: (value){
        if(value == SlidingUpPanelStatus.hidden){
          setState(() {
            _padding = 50;
          });
        }else {
          setState(() {
            _padding = 10;
          });
        }

      },
      child: Container(
        margin: EdgeInsets.fromLTRB(10, _padding, 10, 0),
        decoration: ShapeDecoration(
          color: Colors.white,
          shadows: [
            BoxShadow(
                blurRadius: 5.0,
                spreadRadius: 2.0,
                color: const Color(0x11000000))
          ],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: changeScreen(),
      ),
      controlHeight: 0.0,
      anchor: 0.4,
      panelController: widget.panelController,
      enableOnTap: false, //Enable the onTap callback for control bar.
    );
  }
}
