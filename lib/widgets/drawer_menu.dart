import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:room_financal_manager/models/user.dart';
import 'package:room_financal_manager/providers/user_provider.dart';
import 'package:room_financal_manager/screens/login_page.dart';
import 'package:room_financal_manager/screens/personal_page.dart';

class DrawerMenu extends StatefulWidget {
  final UserData user;
  DrawerMenu({this.user});
  @override
  _DrawerMenuState createState() => _DrawerMenuState();
}

class _DrawerMenuState extends State<DrawerMenu> {
  @override
  Widget build(BuildContext context) {
    UserProvider _user = Provider.of<UserProvider>(context);
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF42AF3B), Color(0xFF17B6A0)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            accountEmail: Column(
              children: [
                Row(
                  children: [
                    Text(
                      _user.userData.displayName,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text("ID: ${_user.userData.id}",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.normal)),
                  ],
                ),
                Row(
                  children: [
                    Icon(
                      Icons.phone,
                      size: 16,
                    ),
                    Text(_user.userData.phoneNumber,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.normal)),
                  ],
                ),
              ],
            ),
            currentAccountPicture: GestureDetector(
              child: ClipOval(
                  child: Container(
                      width: 100,
                      height: 100,
                      color: Color(0xFFCDCCCC),
                      child: _user.userData.urlAvt==""?Icon(
                        Icons.person,
                        size: 50,
                        color: Colors.white,
                      ):Image.network(_user.userData.urlAvt,fit: BoxFit.fill,))
              ),
            ),
          ),

          ///Trang cá nhân
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          PersonalPage(user: widget.user,)));
            },
            child: ListTile(
              leading: Container(
                height: 50,
                width: 50,
                child: Icon(
                  Icons.account_box,
                  color: Colors.black,
                ),
              ),
              title: Text(
                "Trang cá nhân",
                style: TextStyle(fontSize: 18, color: Color(0xff323643)),
              ),
            ),
          ),

          //Cài đặt
          InkWell(
            onTap: () {},
            child: ListTile(
              leading: Container(
                height: 50,
                width: 50,
                child: Icon(
                  Icons.settings,
                  color: Colors.black,
                ),
              ),
              title: Text(
                "Cài đặt",
                style: TextStyle(fontSize: 18, color: Color(0xff323643)),
              ),
            ),
          ),

          //Hỗ trợ
          InkWell(
            onTap: () async {
              await showDialog(
                  context: this.context,
                  child: AlertDialog(
                  backgroundColor: Colors.white,
                  title:  Center(
                  child: Text("Hỗ trợ", style: TextStyle(color: Colors.blue[900], fontSize: 22, fontWeight: FontWeight.bold),)),
              content: Container(
              height: 100,
              color: Colors.white,
              child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Bạn đang gặp sự cố?"),
              Text(" Liên hệ ngay với chúng tôi!"),
              SizedBox(height: 20,),
              Text("Minh Hồng: 0377846295"),
              Text("Trương Nam: 0973214133")
              ],)
              ),contentPadding: EdgeInsets.all(0),

              actions: <Widget>[
              InkWell(
              onTap: (){
              Navigator.pop(context);
              },
              child: Text("Thoát", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
              ),
              ],
              )
              );
            },
            child: ListTile(
              leading: Container(
                height: 50,
                width: 50,
                child: Icon(
                  Icons.help,
                  color: Colors.black,
                ),
              ),
              title: Text(
                "Hỗ trợ",
                style: TextStyle(fontSize: 18, color: Color(0xff323643)),
              ),
            ),
          ),

          //Thông tin liên hệ
          InkWell(
            onTap: () async {
              await showDialog(
                  context: this.context,
                  child: AlertDialog(
                  backgroundColor: Colors.white,
                  title:  Center(
                  child: Text("Thông tin liên hệ", style: TextStyle(color: Colors.blue[900], fontSize: 22, fontWeight: FontWeight.bold),)),
                    content: Container(
                        height: 100,
                        color: Colors.white,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("17520526 - Hoàng Minh Hồng"),
                            Text("17520785 - Trương Nguyễn Tuấn Nam")
                          ],)
                    ),contentPadding: EdgeInsets.all(0),

                  actions: <Widget>[
                    InkWell(
                    onTap: (){
                    Navigator.pop(context);
                    },
                    child: Text("Thoát", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                    ),
                    ],
                  )
              );
            },
            child: ListTile(
              leading: Container(
                height: 50,
                width: 50,
                child: Icon(
                  Icons.info,
                  color: Colors.black,
                ),
              ),
              title: Text(
                "Thông tin liên hệ",
                style: TextStyle(fontSize: 18, color: Color(0xff323643)),
              ),
            ),
          ),

          //Đăng xuất
          InkWell(
            onTap: () {
              _user.auth.signOut();
              //_user.googleSignIn.disconnect();
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          LoginPage()));
            },
            child: ListTile(
              leading: Container(
                height: 50,
                width: 50,
                child: Icon(
                  Icons.exit_to_app,
                  color: Colors.black,
                ),
              ),
              title: Text(
                "Đăng xuất",
                style: TextStyle(fontSize: 18, color: Color(0xff323643)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
