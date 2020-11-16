import 'package:flutter/material.dart';
import 'package:room_financal_manager/services/authentication.dart';
import 'package:room_financal_manager/services/storage.dart';
import 'package:room_financal_manager/widgets/drawer_menu.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PersonalPage extends StatefulWidget {
  @override
  _PersonalPageState createState() => _PersonalPageState();
}

class _PersonalPageState extends State<PersonalPage> {
  SecureStorage secureStorage = SecureStorage();
  final _key = GlobalKey<ScaffoldState>();
  Authentication authentication = Authentication();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      appBar: AppBar(
        backgroundColor: Color(0xFF42AF3B),
        centerTitle: true,
        title: Text(
          "TRANG CÁ NHÂN",
          style: TextStyle(
              color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: MediaQuery.of(context).size.height / 3,
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                Container(
                  height: 200,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.white,
                  child: Image.asset(
                    "assets/image.jpeg",
                    fit: BoxFit.fill,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 150),
                  child: ClipOval(
                    child: SizedBox(
                      width: 100,
                      height: 100,
                      child: Image.asset(
                        "assets/minhhong.png",
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Text(
              "Minh Hồng",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, top: 10),
            child: Container(
                width: MediaQuery.of(context).size.width,
                child: Text("Tổng quan",
                    style:
                        TextStyle(fontSize: 25, fontWeight: FontWeight.bold))),
          ),
          Padding(
            padding: EdgeInsets.only(left: 30, right: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "ID:",
                      style: TextStyle(
                          fontSize: 20, fontWeight: FontWeight.normal),
                    ),
                    Text("123456",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold))
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Số điện thoại:",
                      style: TextStyle(
                          fontSize: 20, fontWeight: FontWeight.normal),
                    ),
                    Text("0377846295",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold))
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Số dư hiện có:",
                      style: TextStyle(
                          fontSize: 20, fontWeight: FontWeight.normal),
                    ),
                    Text("1.000.000 vnđ",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.red))
                  ],
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, top: 10),
            child: Container(
                width: MediaQuery.of(context).size.width,
                child: Text("Nhóm của bạn",
                    style:
                        TextStyle(fontSize: 25, fontWeight: FontWeight.bold))),
          ),
          Padding(
            padding: EdgeInsets.only(left: 30, right: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10,
                ),
                InkWell(
                  onTap: () {},
                  child: Row(
                    children: [
                      Container(
                        height: 50.0,
                        width: 50.0,
                        child: new CircleAvatar(
                          backgroundColor: Colors.grey,
                          radius: 30.0,
                          child:
                              Icon(Icons.people, size: 25, color: Colors.white),
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 1.0,
                          ),
                          shape: BoxShape.circle,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Text("PENHOUSE",
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold)),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                InkWell(
                  onTap: () {},
                  child: Row(
                    children: [
                      Container(
                        height: 50.0,
                        width: 50.0,
                        child: new CircleAvatar(
                          backgroundColor: Colors.grey,
                          radius: 30.0,
                          child:
                              Icon(Icons.people, size: 25, color: Colors.white),
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 1.0,
                          ),
                          shape: BoxShape.circle,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Text("Đồ án",
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold)),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                InkWell(
                  onTap: () {},
                  child: Row(
                    children: [
                      Container(
                        height: 50.0,
                        width: 50.0,
                        child: new CircleAvatar(
                          backgroundColor: Colors.grey,
                          radius: 30.0,
                          child: Icon(
                            Icons.add,
                            size: 25,
                            color: Colors.white,
                          ),
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 1.0,
                          ),
                          shape: BoxShape.circle,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Text("Thêm nhóm",
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, top: 10),
            child: Container(
                width: MediaQuery.of(context).size.width,
                child: Text("Khác",
                    style:
                        TextStyle(fontSize: 25, fontWeight: FontWeight.bold))),
          ),
          Padding(
            padding: EdgeInsets.only(left: 10, right: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
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
                    trailing: Icon(
                      Icons.chevron_right,
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
                    trailing: Icon(
                      Icons.chevron_right,
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
                    trailing: Icon(
                      Icons.chevron_right,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 40,
            width: MediaQuery.of(context).size.width - 80,
            child: RaisedButton(
              onPressed: () async {
                await authentication.googleSignOut().whenComplete(() {
                  secureStorage.deleteSecureData('email');
                }).whenComplete(() {
                  Navigator.pushReplacementNamed(context, '/login');
                });
              },
              color: Colors.white,
              child: Text(
                "Đăng xuất",
                style: TextStyle(
                    fontSize: 25,
                    color: Colors.red,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          SizedBox(
            height: 15,
          )
        ],
      )),
    );
  }
}
