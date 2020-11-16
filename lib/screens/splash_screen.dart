import 'dart:async';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:room_financal_manager/screens/home_page.dart';
import 'package:room_financal_manager/screens/login_page.dart';
import 'package:room_financal_manager/providers/user_provider.dart';
import 'package:room_financal_manager/services/storage.dart';
import 'package:room_financal_manager/services/authentication.dart';

String finalEmail, finalName;

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final SecureStorage secureStorage = SecureStorage();
  final Authentication authentication = Authentication();
  @override
  void initState() {
    secureStorage.readSecureData('email').then((value) {
      finalEmail = value;
      print(finalEmail);
    });
    secureStorage.readSecureData('name').then((value) {
      finalName = value;
    });
    Timer(
        Duration(seconds: 6),
        () => Navigator.pushReplacement(
            context,
            PageTransition(
                child: LoginPage(),
                type: PageTransitionType.rightToLeftWithFade)));
    // child: finalEmail == null
    //     ? LoginPage()
    //     : {
    //         authentication.googleSignIn().whenComplete(() {
    //           PageTransition(
    //               child: HomePage(),
    //               type: PageTransitionType.rightToLeftWithFade);
    //         })
    //       },
    // type: null)));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
              colors: [Color(0xFF42AF3B), Color(0xFF17B6A0)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            )),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 300,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 100),
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.white,
                    ),
                  )
                ],
              ),
            )));
  }
}
