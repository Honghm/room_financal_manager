import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:room_financal_manager/providers/user_provider.dart';
import 'package:room_financal_manager/screens/login_page.dart';
import 'package:room_financal_manager/widgets/otp_input.dart';


class VerityNumber extends StatefulWidget {
  final String phoneNumber;
  VerityNumber({this.phoneNumber});
  @override
  _VerityNumberState createState() => _VerityNumberState();
}

class _VerityNumberState extends State<VerityNumber> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  /// Control the input text field.
  TextEditingController _pinEditingController = TextEditingController();

  /// Decorate the outside of the Pin.
  PinDecoration _pinDecoration =
  UnderlineDecoration(enteredColor: Colors.black, hintText: '000000');

  bool isCodeSent = false;
  String _verificationId;

  @override
  void initState() {
    super.initState();
    _onVerifyCode();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.green,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
          ),
          color: Colors.white,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text("XÁC MINH SỐ ĐIỆN THOẠI", style: TextStyle(color: Colors.white,fontSize: 22, fontWeight: FontWeight.bold)),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
             PreferredSize(
              child: Container(
                padding: EdgeInsets.only(left: 16.0, bottom: 16, top: 4),
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: 20,),
                    Container(
                      width: MediaQuery.of(context).size.width - 20,
                      child: Text(
                        "Mã xác minh đã được gửi đến số điện thoại của bạn",
                        style: TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      "Vui lòng kiểm tra tin nhắn!",
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              preferredSize: Size.fromHeight(100),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: PinInputTextField(
                pinLength: 6,
                decoration: _pinDecoration,
                controller: _pinEditingController,
                autoFocus: true,
                textInputAction: TextInputAction.done,
                onSubmit: (pin) {
                  if (pin.length == 6) {
                    _onFormSubmitted();
                  } else {
                    showToast("Mã không đúng, thử lại!", Colors.red);
                  }
                },
              ),
            ),
            Container(
              padding: EdgeInsets.all(16),
              child: Center(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: RaisedButton(
                    color: Colors.green,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40)),
                    child: Text(
                      "XÁC MINH",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold),
                    ),
                    onPressed: () {
                      if (_pinEditingController.text.length == 6) {
                        _onFormSubmitted();
                      } else {
                        showToast("Mã không đúng, thử lại!", Colors.red);
                      }
                    },
                    padding: EdgeInsets.all(16.0),
                  ),
                ),
              ),
            ),

            Container(
              alignment: Alignment.center,
              child:  RichText(
                text: TextSpan(
                    text: "Bạn không nhận được mã? ",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal, color: Colors.black),
                    children: <TextSpan>[
                      TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {

                          },
                        text: "Gửi lại!",
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal, color: Colors.blue[900]),
                      )
                    ]
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showToast(message, Color color) {
    print(message);
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        backgroundColor: color,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  void _onVerifyCode() async {
    setState(() {
      isCodeSent = true;
    });
    print("phone:${widget.phoneNumber}");
    final PhoneVerificationCompleted verificationCompleted =
        (AuthCredential phoneAuthCredential) {
      // _firebaseAuth
      //     .signInWithCredential(phoneAuthCredential)
      //     .then((value) {
      //   if (value.user != null) {
      //     // Handle loogged in state
      //     print(value.user.phoneNumber);
      //     Navigator.pushAndRemoveUntil(
      //         context,
      //         MaterialPageRoute(
      //           builder: (context) => LoginPage(
      //
      //           ),
      //         ),
      //             (Route<dynamic> route) => false);
      //   } else {
      //     showToast("Error validating OTP, try again", Colors.red);
      //   }
      // }).catchError((error) {
      //   showToast("Try again in sometime", Colors.red);
      // });
    };
    final PhoneVerificationFailed verificationFailed =
        (FirebaseAuthException authException) {
      showToast(authException.message, Colors.red);
      setState(() {
        isCodeSent = false;
      });
    };

    final PhoneCodeSent codeSent =
        (String verificationId, [int forceResendingToken]) async {
      _verificationId = verificationId;
      setState(() {
        _verificationId = verificationId;
      });
    };
    final PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
        (String verificationId) {
      _verificationId = verificationId;
      setState(() {
        _verificationId = verificationId;
      });
    };

    // TODO: Change country code

    await _firebaseAuth.verifyPhoneNumber(
        phoneNumber: "+84${widget.phoneNumber}",
        timeout: const Duration(seconds: 60),
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: codeSent,
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
  }

  void _onFormSubmitted() async {
    AuthCredential _authCredential = PhoneAuthProvider.credential(
        verificationId: _verificationId, smsCode: _pinEditingController.text);

    _firebaseAuth
        .signInWithCredential(_authCredential)
        .then((value) {
      if (value.user != null) {
        // Handle loogged in state
        print(value.user.phoneNumber);
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => LoginPage(
              ),
            ),
                (Route<dynamic> route) => false);
      } else {
        showToast("Lỗi xác minh, thử lại!", Colors.red);
      }
    }).catchError((error) {
      showToast("Đã xảy ra lỗi", Colors.red);
    });
  }
}
