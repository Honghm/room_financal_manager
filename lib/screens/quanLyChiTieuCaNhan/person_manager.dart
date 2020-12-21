import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_widgets/responsive_widgets.dart';
import 'package:room_financal_manager/config/initialization.dart';
import 'package:room_financal_manager/models/KhoanChiCaNhan.dart';
import 'package:room_financal_manager/models/KhoanThuCaNhan.dart';
import 'package:room_financal_manager/providers/caNhan_providers.dart';
import 'package:room_financal_manager/providers/home_provider.dart';
import 'package:room_financal_manager/screens/quanLyChiTieuCaNhan/KhoanThu.dart';
import 'package:room_financal_manager/screens/quanLyChiTieuCaNhan/khoanChi.dart';
import 'package:room_financal_manager/screens/quanLyChiTieuCaNhan/thongKe.dart';
import 'file:///D:/My%20Code/Code%20Android/DoAn2/room_financal_manager/lib/widgets/CaNhan/item_expenses_person.dart';
import 'package:room_financal_manager/widgets/top_bar.dart';

class PersonManager extends StatefulWidget {
  @override
  _PersonManagerState createState() => _PersonManagerState();
}

class _PersonManagerState extends State<PersonManager> {
  List<KhoanChiCaNhan> dsKhoanChi = [];
  List<KhoanThuCaNhan> dsKhoanThu = [];
  int _page  = 2;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }
  Future<void> loadData() async {
    if(dsKhoanChi.isEmpty){
       await Provider.of<CaNhanProviders>(context,listen: false).danhSachKhoanChi("000001").then((value) {
        dsKhoanChi =  Provider.of<CaNhanProviders>(context,listen: false).dsKhoanChiCaNhan;
      });
    }
    if(dsKhoanThu.isEmpty){
      await Provider.of<CaNhanProviders>(context,listen: false).danhSachKhoanThu("000001").then((value) {
        dsKhoanThu =  Provider.of<CaNhanProviders>(context,listen: false).dsKhoanThuCaNhan;
      });
    }

  }
  Widget _changePage(int page, status){
    switch(page){
      case 2:
        return KhoanThu(dsKhoanThu: dsKhoanThu,);
      case 1:
        return KhoanChi(dsKhoanChi: dsKhoanChi);
      case 3:
        return ThongKe();
    }
  }
  @override
  Widget build(BuildContext context) {
    final _key = GlobalKey<ScaffoldState>();
    CaNhanProviders _caNhan = Provider.of<CaNhanProviders>(context);
    HomeProviders _home = Provider.of<HomeProviders>(context);
    return Scaffold(
      key: _key,
      backgroundColor:  Color(0xFFCDCCCC),
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF42AF3B),
                Color(0xFF17B6A0)
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            )
        ),
        child: Container(
          height:  MediaQuery.of(context).size.height,
          color: Color(0xFFCDCCCC),
          child: Stack(
            children: [
              _changePage(_home.screen, _caNhan.status, ),
              TopBar("Khoản thu", "Khoản chi", "Thống kê",onButtonPressedCallback: onTopButtonPressed,initSelected: _home.screen),
            ],
          ),
        ),
      ),
    );
  }

  void onTopButtonPressed(int index) {
    switch (index) {
      case 1:
        Provider.of<HomeProviders>(context, listen: false).screen = 2;

        break;
      case 2:
        Provider.of<HomeProviders>(context, listen: false).screen = 1;

        break;
      case 3:
        Provider.of<HomeProviders>(context, listen: false).screen = 3;

        break;
    }
  }
}
