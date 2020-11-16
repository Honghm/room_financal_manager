import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:responsive_widgets/responsive_widgets.dart';
import 'package:room_financal_manager/config/initialization.dart';
import 'package:room_financal_manager/providers/user_provider.dart';
import 'package:room_financal_manager/services/authentication.dart';
import 'package:room_financal_manager/widgets/loading.dart';
import 'package:room_financal_manager/providers/group_providers.dart';
import 'package:room_financal_manager/screens/home_page.dart';

// GoogleSignIn _googleSignIn = GoogleSignIn(
//     scopes: <String>[
//       'email',
//     ]
// );

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Authentication authentication = Authentication();

  final _key = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _accountController = TextEditingController();
  final TextEditingController _passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    final expenditures = Provider.of<GroupProviders>(context);

    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      key: _key,
      body: Container(
        height: height,
        decoration: BoxDecoration(
            gradient: LinearGradient(
          colors: [Color(0xFF42AF3B), Color(0xFF17B6A0)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        )),
        child: ListView(
          children: [
            Column(
              children: [
                Column(
                  children: [
                    Container(
                      height: height / 2 - 30,
                      width: width,
                      color: Colors.transparent,
                      child: Image.asset(
                        "assets/intro1.png",
                        fit: BoxFit.fill,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      child: Text(
                        "Phần mềm hỗ trợ quản lý chi tiêu \n cá nhân, gia đình, phòng trọ...",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: _accountController,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Yêu cầu nhập tài khoản';
                          }
                          return null;
                        },
                        style: TextStyle(fontSize: 16, color: Colors.black),
                        decoration: InputDecoration(
                          labelText: "Số điện thoại",
                          prefixIcon: Container(
                              width: 50, child: Icon(Icons.account_circle)),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red, width: 2),
                            borderRadius: BorderRadius.all(Radius.circular(6)),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      TextFormField(
                        controller: _passController,
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Yêu cầu nhập mật khẩu";
                          } else if (value.length < 6) {
                            return "mật khẩu phải lớn hơn 6 ký tự";
                          }
                          return null;
                        },
                        obscureText: true,
                        decoration: InputDecoration(
                            labelText: "Mật khẩu",
                            prefixIcon: Container(
                                width: 50, child: Icon(Icons.vpn_key)),
                            border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.orange, width: 2),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(6)))),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(25))),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => HomePage()));
                    },
                    color: Colors.amberAccent,
                    child: Text(
                      "Đăng nhập",
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ), //Normal Login
                SizedBox(
                  height: 5,
                ),
                Text(
                  "Hoặc",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FlatButton(
                        onPressed: () {},
                        child: Container(
                            width: 50,
                            height: 50,
                            child: Image.asset(
                              "assets/iconfb.png",
                              fit: BoxFit.fill,
                            ))),
                    FlatButton(
                        onPressed: () async {
                          await authentication.googleSignIn().whenComplete(() {
                            print("run here");
                            Navigator.pushReplacement(
                                context,
                                PageTransition(
                                    child: HomePage(),
                                    type: PageTransitionType.bottomToTop));
                          });
                        },
                        child: Container(
                            height: 50,
                            width: 50,
                            child: Image.asset(
                              "assets/icongoogle.png",
                              fit: BoxFit.fill,
                            ))),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Text("Bạn chưa có tài khoản? Đăng ký tại đây!"),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
