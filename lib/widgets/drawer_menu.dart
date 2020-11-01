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
                colors: [
                  Color(0xFF42AF3B),
                  Color(0xFF17B6A0)
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            accountName: Text(
              "Hoàng Minh Hồng",
              style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
            ),
            accountEmail: Text("17520526@gm.uit.edu.vn", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.normal)),
            currentAccountPicture: GestureDetector(
              child: ClipOval(
                  child: Container(
                      width: 100,
                      height: 100,
                      color: Color(0xFFCDCCCC),
                      child: Icon(Icons.person, size: 50,color: Colors.white,))
              ),
            ),

          ),


          InkWell(
            onTap: () {
              Navigator.pushReplacementNamed(context, '/login');
            },
            child: ListTile(
              leading: Container(
                height:50,
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
