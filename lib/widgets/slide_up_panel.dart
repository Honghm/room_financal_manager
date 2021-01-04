import 'package:flutter/material.dart';
import 'package:flutter_sliding_up_panel/sliding_up_panel_widget.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:room_financal_manager/models/user.dart';
import 'package:room_financal_manager/providers/group_providers.dart';
import 'package:room_financal_manager/providers/home_provider.dart';
import 'package:room_financal_manager/widgets/CaNhan/them_KhoanThu_CaNhan.dart';
import 'file:///D:/My%20Code/Code%20Android/DoAn2/room_financal_manager/lib/widgets/Nhom/create_group.dart';
import 'file:///D:/My%20Code/Code%20Android/DoAn2/room_financal_manager/lib/widgets/Nhom/them_KhoanChi_Nhom.dart';
import 'CaNhan/them_KhoanChi_CaNhan.dart';

class SlideUpPanel extends StatefulWidget {
  final SlidingUpPanelController panelController;
  final int state;
  final UserData user;
  SlideUpPanel(this.panelController, {this.state, this.user});
  @override
  _SlideUpPanelState createState() => _SlideUpPanelState();
}

class _SlideUpPanelState extends State<SlideUpPanel> {
  double _padding = 50;
  Widget changeScreen(){

    switch(widget.state){
      case 1:
        return ThemKhoanChiCaNhan(user: widget.user);
      case 2:
        return ThemKhoanThuCaNhan(user: widget.user);
      case 4:
        return ThemKhoanChiNhom(widget.panelController,widget.user);
      // case 7:
      //   {
      //     Navigator.push(context,
      //         PageTransition(child: CreateGroup(
      //           panelController: widget.panelController, user: widget.user,),
      //             type: PageTransitionType.bottomToTop));
      //   }
      default: {
        widget.panelController.hide();
       return Container();
      }
    }
    return null;
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // if(widget.idGroup!="")
    //   loadData();
  }

  @override
  Widget build(BuildContext context) {
    HomeProviders _home = Provider.of<HomeProviders>(context);

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
            borderRadius: BorderRadius.circular(20),
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
