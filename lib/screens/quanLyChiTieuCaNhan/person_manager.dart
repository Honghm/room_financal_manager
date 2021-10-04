
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:room_financal_manager/models/KhoanChiCaNhan.dart';
import 'package:room_financal_manager/models/KhoanThuCaNhan.dart';
import 'package:room_financal_manager/models/user.dart';
import 'package:room_financal_manager/providers/caNhan_providers.dart';
import 'package:room_financal_manager/providers/home_provider.dart';
import 'package:room_financal_manager/screens/quanLyChiTieuCaNhan/KhoanThu.dart';
import 'package:room_financal_manager/screens/quanLyChiTieuCaNhan/khoanChi.dart';
import 'package:room_financal_manager/screens/quanLyChiTieuCaNhan/thongKe.dart';
import 'package:room_financal_manager/widgets/ThongKe/info_card.dart';

import 'package:room_financal_manager/widgets/top_bar.dart';

class PersonManager extends StatefulWidget {
  final UserData user;

  PersonManager({this.user, });
  @override
  _PersonManagerState createState() => _PersonManagerState();
}

class _PersonManagerState extends State<PersonManager> {

  List<Widget> listInfoCard = List(); //ds thống kê theo loại chi tiêu
  List<double> thongKeKhoanChi = [];
  List<double> thongKeKhoanThu = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }




  Widget _changePage(int page, status, dsKT, dsKC){
    switch(page){
      case 2:
        return KhoanThu(dsKhoanThu: dsKT,);
      case 1:
        return KhoanChi(
          dsKhoanChi: dsKC,
          user: widget.user,);
      case 3:
       return ThongKe(
           listInfoCard: listInfoCard,
         thongKeKhoanChi: thongKeKhoanChi,
         thongKeKhoanThu: thongKeKhoanThu,
       );
      default:
        return Container();
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
              _changePage(_home.screen, _caNhan.status,_caNhan.dsKhoanThuCaNhan, _caNhan.dsKhoanChiCaNhan),
              TopBar("Khoản thu", "Khoản chi", "Thống kê",onButtonPressedCallback: onTopButtonPressed,initSelected: _home.screen),
            ],
          ),
        ),
      ),
    );
  }
  loadDataThongKe({List<ItemLoaiKhoanChi> dsLoaiKhoanChi, List<KhoanChiCaNhan> dsKhoanChiCaNhan,List<KhoanThuCaNhan> dsKhoanThuCaNhan }){
    loadListInfoCard(
        dsKhoanChiCaNhan: dsKhoanChiCaNhan,
      dsLoaiKhoanChi: dsLoaiKhoanChi,
    );
    thongKeKhoanChi = Provider.of<CaNhanProviders>(context, listen: false).thongKeKhoanChi_Thang(dsKhoanChiCaNhan);
    thongKeKhoanThu = Provider.of<CaNhanProviders>(context, listen: false).thongKeKhoanThu_Thang(dsKhoanThuCaNhan);
  }

  loadListInfoCard({List<ItemLoaiKhoanChi> dsLoaiKhoanChi, List<KhoanChiCaNhan> dsKhoanChiCaNhan }) {
    listInfoCard.clear();
    dsLoaiKhoanChi.forEach((item) {
      List<double> dsTienChi = [];
      double TongChi = 0;
      dsKhoanChiCaNhan.forEach((data) {
        if(data.ngayMua.split("_")[1] == DateTime.now().month.toString()){
          data.listItemKhoanChi.forEach((value) {
            if(value.tenLoai == item.name){
              dsTienChi.add(double.parse(value.giaTien));
              TongChi += double.parse(value.giaTien);
            }
          });
        }
      });
      listInfoCard.add(InfoCard(
        title: item.name,
        icon: item.icon,
        dsTienChi: dsTienChi,
        TongChi: TongChi,
        press: () {},));
    });

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
        loadDataThongKe(
            dsLoaiKhoanChi:Provider.of<HomeProviders>(context, listen: false).dsLoaiKhoanChi,
          dsKhoanChiCaNhan: Provider.of<CaNhanProviders>(context, listen: false).dsKhoanChiCaNhan,
          dsKhoanThuCaNhan: Provider.of<CaNhanProviders>(context, listen: false).dsKhoanThuCaNhan,
        );

        break;
    }
  }
}
