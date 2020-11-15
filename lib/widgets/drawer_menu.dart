import 'package:flutter/material.dart';

class DrawerMenu extends StatefulWidget {
  @override
  _DrawerMenuState createState() => _DrawerMenuState();
}

class _DrawerMenuState extends State<DrawerMenu> {
  @override
  Widget build(BuildContext context) {
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
                      "Minh Hồng",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text("ID: 123456",
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
                    Text("0377846295",
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
                      child: Icon(
                        Icons.person,
                        size: 50,
                        color: Colors.white,
                      ))),
            ),
          ),
          //Trang cá nhân
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, '/personal');
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
            onTap: () {},
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
            onTap: () {},
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
              Navigator.pushReplacementNamed(context, '/login');
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
