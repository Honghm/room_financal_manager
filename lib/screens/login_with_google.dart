import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_widgets/responsive_widgets.dart';
import 'package:room_financal_manager/config/initialization.dart';
import 'package:room_financal_manager/providers/user_provider.dart';

import 'home_page.dart';

class LoginWithGoogle extends StatefulWidget {
  @override
  _LoginWithGoogleState createState() => _LoginWithGoogleState();
}

class _LoginWithGoogleState extends State<LoginWithGoogle> {
  TextEditingController _nameController = new TextEditingController();
  TextEditingController _phoneController = new TextEditingController();
  final _key = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    ResponsiveWidgets.init(
      context,
      height: 1520, // Optional
      width: 720, // Optional
      allowFontScaling: true, // Optional
    );
    if (user.isMailExist == true) return HomePage();
    // return user.isMailExist == true
    //     ? HomePage()
    //     : ResponsiveWidgets.builder(
    //   height: 1520, // Optional
    //   width: 720, // Optional
    //   allowFontScaling: true, // Optional
    //   child: Scaffold(
    //     key: _key,
    //     body: user.status == Status.Authenticating
    //         ? Loading()
    //         : Stack(
    //       children: <Widget>[
    //         Container(
    //           width: MediaQuery.of(context).size.width,
    //           height: MediaQuery.of(context).size.height,
    //           child: Image.asset(
    //             "assets/images/background.jpg",
    //             fit: BoxFit.fill,
    //           ),
    //         ),
    //         Form(
    //           key: _formKey,
    //           child: Container(
    //               decoration: BoxDecoration(
    //                   gradient: LinearGradient(
    //                     colors: [
    //                       Colors.black.withOpacity(0.8),
    //                       Colors.blue,
    //                       Colors.orange.withOpacity(0.8)
    //                     ],
    //                     begin: Alignment.topLeft,
    //                     end: Alignment.bottomRight,
    //                   )),
    //               constraints: BoxConstraints.expand(),
    //               child: Container(
    //                 color: Colors.white.withOpacity(0.4),
    //                 child: SingleChildScrollView(
    //                   child: Container(
    //                     padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
    //                     child: Column(
    //                       children: <Widget>[
    //                         SizedBoxResponsive(
    //                           height: 160,
    //                         ),
    //
    //                         ContainerResponsive(
    //                           height: ScreenUtil().setHeight(300),
    //                           width: ScreenUtil().setWidth(300),
    //                           child: new CircleAvatar(
    //                             backgroundColor: Colors.white,
    //                             radius: 100.0,
    //                             child: Image.asset(
    //                               "assets/images/icon.png",
    //                               fit: BoxFit.fill,
    //                             ),
    //                           ),
    //                           decoration: BoxDecoration(
    //                             border: Border.all(
    //                               width: 1.0,
    //                             ),
    //                             shape: BoxShape.circle,
    //                           ),
    //                         ),
    //
    //                         Padding(
    //                           padding: EdgeInsetsResponsive.fromLTRB(0, 60, 0, 20),
    //                           child: TextResponsive(
    //                             "XIN CHÀO!",
    //                             style: TextStyle(
    //                                 fontSize: ScreenUtil().setSp(90),
    //                                 color: Colors.white,
    //                                 fontWeight: FontWeight.bold),
    //                           ),
    //                         ),
    //                         TextResponsive(
    //                           "Đăng ký tài khoản mới",
    //                           style: TextStyle(
    //                               fontSize: ScreenUtil().setSp(60), color: Colors.white),
    //                         ),
    //                         //-----------Họ tên----------------
    //                         Padding(
    //                           padding: EdgeInsetsResponsive.fromLTRB(0, 30, 0, 30),
    //                           child: TextFormField(
    //                             controller: _nameController,
    //                             validator: (value){
    //                               if(value.isEmpty)
    //                                 return "Nhập họ tên của bạn";
    //                               return null;
    //                             },
    //                             style:
    //                             TextStyle(fontSize: 16, color: Colors.black),
    //                             decoration: InputDecoration(
    //                                 labelText: "Họ tên",
    //                                 prefixIcon: Container(
    //                                     width: 50, child: Icon(Icons.person)),
    //                                 border: OutlineInputBorder(
    //                                     borderSide: BorderSide(
    //                                         color: Color(0xffCED0D2), width: 1),
    //                                     borderRadius: BorderRadius.all(
    //                                         Radius.circular(6)))),
    //                           ),
    //                         ),
    //
    //                         //----------Số điện thoại--------
    //                         TextFormField(
    //                           controller: _phoneController,
    //                           style: TextStyle(fontSize: 18, color: Colors.black),
    //                           decoration: InputDecoration(
    //                               labelText: "Số điện thoại",
    //                               prefixIcon: ContainerResponsive(
    //                                   width: ScreenUtil().setWidth(100), child: Icon(Icons.phone)),
    //                               border: OutlineInputBorder(
    //                                   borderSide: BorderSide(
    //                                       color: Color(0xffCED0D2), width: 1),
    //                                   borderRadius:
    //                                   BorderRadius.all(Radius.circular(6)))),
    //                         ),
    //                         Padding(
    //                           padding: EdgeInsetsResponsive.fromLTRB(0, 30, 0, 20),
    //                           child: SizedBox(
    //                             width: double.infinity,
    //                             height: 52,
    //                             child: RaisedButton(
    //                               onPressed: () async {
    //                                 Navigator.push(
    //                                     context,
    //                                     MaterialPageRoute(
    //                                         builder: (context) =>
    //                                             RegisterPageCoun(
    //                                                 _nameController
    //                                                     .text,
    //                                                 user.account.email,
    //                                                 null,
    //                                                 _phoneController
    //                                                     .text)));
    //                               },
    //                               child: TextResponsive(
    //                                 "Tiếp tục",
    //                                 style: TextStyle(
    //                                     color: Colors.white, fontSize: ScreenUtil().setSp(70)),
    //                               ),
    //                               color: Color(0xff3277D8),
    //                               shape: RoundedRectangleBorder(
    //                                   borderRadius:
    //                                   BorderRadius.all(Radius.circular(6))),
    //                             ),
    //                           ),
    //                         ),
    //                         Padding(
    //                           padding: EdgeInsetsResponsive.fromLTRB(0, 0, 0, 20),
    //                           child: RichText(
    //                             text: TextSpan(
    //                                 text: "Bạn đã có tài khoản? ",
    //                                 style: TextStyle(
    //                                     color: Color(0xff606470), fontSize: 16),
    //                                 children: <TextSpan>[
    //                                   TextSpan(
    //                                       recognizer: TapGestureRecognizer()
    //                                         ..onTap = () {
    //                                           Navigator.pushNamed(context,'/login');
    //                                         },
    //                                       text: "Đăng nhập ngay",
    //                                       style: TextStyle(
    //                                           color: Color(0xff3277D8),
    //                                           fontSize: 16))
    //                                 ]),
    //                           ),
    //                         )
    //                       ],
    //                     ),
    //                   ),
    //                 ),
    //               )),
    //         ),
    //       ],
    //     ),
    //   ),
    // );
  }
}
