import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:room_financal_manager/providers/user_provider.dart';
import 'package:room_financal_manager/screens/login_page.dart';
import 'package:room_financal_manager/widgets/verity_number.dart';

class RegisterPage extends StatefulWidget {
  final String kindLogin;
  final String email;
  RegisterPage({this.kindLogin, this.email});
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _key = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController displayNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController rePasswordController = TextEditingController();
  final TextEditingController codeController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("run here: ${widget.kindLogin}");
  }
  @override
  Widget build(BuildContext context) {

    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final user = Provider.of<UserProvider>(context);
    return Scaffold(
      key: _key,
      body: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF42AF3B), Color(0xFF17B6A0)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            )),
        padding: EdgeInsets.only(left: 20,right: 20),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: 120,
                  width: 120,
                  margin: EdgeInsets.only(top: 60),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(60),
                    color: Colors.white,
                    border: Border.all(color: Colors.black,width: 2)
                  ),
                  child: Image.asset("assets/icon-app.png",fit: BoxFit.fill,),
                ),
                SizedBox(height: 10,),
                Container(
                  width: width-60,
                  child: Text("FINANCIAL MANAGE ROOM",textAlign: TextAlign.center, style: TextStyle(color: Colors.white,fontSize: 33, fontWeight: FontWeight.bold),),
                ),
                SizedBox(height: 10,),
                Container(
                  width: width-50,
                  child: Text("Tạo tài khoản để có được nhiều trải nghiệp thú vị hơn!",textAlign: TextAlign.center, style: TextStyle(color: Colors.black,fontSize: 20, fontWeight: FontWeight.bold),),
                ),

                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: displayNameController,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Yêu cầu nhập tên hiển thị';
                    }
                    return null;
                  },
                  style: TextStyle(fontSize: 20, color: Colors.black),
                  decoration: InputDecoration(
                    labelText: "Tên hiển thị",
                    prefixIcon: Container(
                        width: 50, child: Icon(Icons.account_circle,size: 30,)),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red, width: 2),
                      borderRadius: BorderRadius.all(Radius.circular(6)),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: phoneController,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Yêu cầu nhập tên hiển thị';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.phone,
                  style: TextStyle(fontSize: 20, color: Colors.black),
                  decoration: InputDecoration(
                    labelText: "Số điện thoại",
                    prefixIcon: Container(
                        width: 50, child: Icon(Icons.phone,size: 30,)),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red, width: 2),
                      borderRadius: BorderRadius.all(Radius.circular(6)),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                widget.kindLogin=="google"?Container():TextFormField(
                  controller: passwordController,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Yêu cầu nhập mật khẩu';
                    }
                    return null;
                  },
                  obscureText: true,
                  style: TextStyle(fontSize: 20, color: Colors.black),
                  decoration: InputDecoration(
                    labelText: "Mật khẩu",
                    prefixIcon: Container(
                        width: 50, child: Icon(Icons.vpn_key,size: 30,)),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red, width: 2),
                      borderRadius: BorderRadius.all(Radius.circular(6)),
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                widget.kindLogin=="google"?Container():TextFormField(
                  controller: rePasswordController,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Yêu cầu nhập lại mật khẩu';
                    }
                    return null;
                  },
                  onChanged: (value){
                    if(value!=passwordController.text){
                      return 'Mật khẩu nhập lại không đúng';
                    }
                  },
                  obscureText: true,
                  style: TextStyle(fontSize: 20, color: Colors.black),
                  decoration: InputDecoration(
                    labelText: "Nhập lại mật khẩu",
                    prefixIcon: Container(
                        width: 50, child: Icon(Icons.vpn_key,size: 30,)),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red, width: 2),
                      borderRadius: BorderRadius.all(Radius.circular(6)),
                    ),
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
                    onPressed: () async {
                      if(_formKey.currentState.validate()){
                        user.registerAccount(
                          displayName: displayNameController.text,
                          email: widget.email,
                          phoneNumber: phoneController.text,
                          password: passwordController.text,
                          context: context,
                          success: (){
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      VerityNumber(
                                        phoneNumber: phoneController.text,
                                      ),
                                ));
                          }
                        );

                        // Navigator.pushReplacement(
                        //     context,
                        //     PageTransition(
                        //         child: VerityNumber("0377846295"),
                        //         type: PageTransitionType.bottomToTop));
                        // await user.registerAccount(nameDisplayController.text.toString(), phoneController.text.toString(),
                        //     passwordController.text.toString(),false, context);
                      //   if(result){
                      //     // await showDialog(
                      //     //     context: this.context,
                      //     //     child: VerityNumber(phoneController.text.toString())
                      //     // );
                      //     //Navigator.pushReplacementNamed(context,'/login');
                      //   }
                      // }else{
                      //   _key.currentState.showSnackBar(SnackBar(
                      //       content: Text(
                      //           "Đăng ký không thành công! Kiểm tra lại dữ liệu nhập vào!")));
                      // }

                      // user.registerAccount("name", "nameDisplay", "phoneNumber", "password", false, context);
                    }},
                    color: Colors.amberAccent,
                    child: Text(
                      "Đăng ký",
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),

                SizedBox(height: 10,),
                Container(
                  alignment: Alignment.center,
                  child:  RichText(
                    text: TextSpan(
                        text: "Bạn đã có tài khoản? ",
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal, color: Colors.black),
                        children: <TextSpan>[
                          TextSpan(
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.pushReplacementNamed(context,'/login');
                              },
                            text: "Đăng nhập tại đây!",
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal, color: Colors.blue[900]),
                          )
                        ]
                    ),
                  ),
                ),
                SizedBox(height: 10,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
