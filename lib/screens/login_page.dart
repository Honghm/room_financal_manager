import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:responsive_widgets/responsive_widgets.dart';
import 'package:room_financal_manager/config/initialization.dart';
import 'package:room_financal_manager/models/user.dart';
import 'package:room_financal_manager/providers/caNhan_providers.dart';
import 'package:room_financal_manager/providers/home_provider.dart';
import 'package:room_financal_manager/providers/user_provider.dart';
import 'package:room_financal_manager/screens/register_page.dart';
import 'package:room_financal_manager/services/authentication.dart';
import 'package:room_financal_manager/widgets/loading.dart';
import 'package:room_financal_manager/providers/group_providers.dart';
import 'package:room_financal_manager/screens/home_page.dart';



class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isSignIn = false;
  FirebaseAuth _auth = FirebaseAuth.instance;
  User _user;
  FacebookLogin facebookLogin = FacebookLogin();

  final _key = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _passController = TextEditingController();

   loginSuccess (BuildContext context, UserData user){
    Provider.of<CaNhanProviders>(context,listen: false).danhSachKhoanChi(user.id);
    Provider.of<CaNhanProviders>(context,listen: false).danhSachKhoanThu(user.id);
    Provider.of<HomeProviders>(context, listen: false).getListLoaiKhoanChi();
    Provider.of<GroupProviders>(context,listen: false).getListGroup(user);
    Navigator.pushReplacement(context,   MaterialPageRoute(
        builder: (context) => HomePage(user: user,)
    ));
  }
  Future<void> handleLogin() async {
    //facebookLogin.logOut();
    final FacebookLoginResult result = await facebookLogin.logIn(['email']);

    switch (result.status) {
      case FacebookLoginStatus.cancelledByUser:
        print("đăng nhập không thành công");
        break;
      case FacebookLoginStatus.error:
        print("đăng nhập bị lỗi");
        break;
      case FacebookLoginStatus.loggedIn:
        try {
          print("đăng nhập thành công");
          await loginWithfacebook(result);
        } catch (e) {
          print(e);
        }
        break;
    }
  }

  Future loginWithfacebook(FacebookLoginResult result) async {
    final FacebookAccessToken accessToken = result.accessToken;
    AuthCredential credential =
    FacebookAuthProvider.credential(accessToken.token);
    var a = await _auth.signInWithCredential(credential);
    setState(() {
      isSignIn = true;
      _user = a.user;
    });
  }

  Future<void> gooleSignout() async {
    await _auth.signOut().then((onValue) {
      setState(() {
        facebookLogin.logOut();
        isSignIn = false;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);


    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      key: _key,
      body: (user.status == Status.Loading) ? Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF42AF3B), Color(0xFF17B6A0)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            )),
        child: Center(
          child: CircularProgressIndicator(
            backgroundColor: Colors.white,
          ),
        ),
      ) :  (user.status == Status.Loaded)?Container():Container(
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
                        controller: _phoneNumberController,
                        keyboardType: TextInputType.phone,
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
                              width: 50, child: Icon(Icons.phone)),
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
                     //user.signIn(_phoneNumberController.text, _passController.text, context, _key);
                     user.signIn(_key,
                       phone: _phoneNumberController.text,
                       password: _passController.text,
                       context: context,
                       success: loginSuccess,
                     );
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
                        onPressed: () async {
                          // await user.loginWithFacebook();
                          // panelController.expand();
                          await showDialog(
                              context: this.context,
                              child: AlertDialog(
                                backgroundColor: Colors.white,
                                title:  Center(
                                    child: Text("Thông báo!", style: TextStyle(color: Colors.black, fontSize: 22, fontWeight: FontWeight.bold),)),
                                contentPadding: EdgeInsets.all(0),
                                content: Container(
                                    height: 100,
                                    color: Colors.white,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text("Tính năng đang phát triển."),
                                        Text("Chúng tôi sẽ cấp nhật chúng sớm thôi!")
                                      ],)
                                ),
                                actions: <Widget>[
                                  InkWell(
                                    onTap: (){
                                      Navigator.pop(context);
                                    },
                                    child: Text("Thoát", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                                  )


                                ],
                              )
                          );
                        },
                        child: Container(
                            width: 50,
                            height: 50,
                            child: Image.asset(
                              "assets/iconfb.png",
                              fit: BoxFit.fill,
                            ))),
                    FlatButton(
                        onPressed: () async {
                          user.googleSignIn.disconnect();
                          user.loginWithGoogle(context: context,success: loginSuccess);
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
                Container(
                  alignment: Alignment.center,
                  child:  RichText(
                    text: TextSpan(
                        text: "Bạn chưa có tài khoản? ",
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal, color: Colors.black),
                        children: <TextSpan>[
                          TextSpan(
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            RegisterPage(kindLogin: "normal",email: "",)));
                              },
                            text: "Đăng ký tại đây!",
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal, color: Colors.blue[900]),
                          )
                        ]
                    ),
                  ),
                ),
                //Text("Bạn chưa có tài khoản? Đăng ký tại đây!"),
              ],
            ),
          ],
        ),
      ),
    );
  }

}
