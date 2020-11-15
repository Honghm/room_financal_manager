import 'dart:async';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:room_financal_manager/screens/home_page.dart';
import 'package:room_financal_manager/screens/login_page.dart';
import 'package:room_financal_manager/providers/user_provider.dart';

String finalEmail, finalName;

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final SecureStorage secureStorage = SecureStorage();
  @override
  void initState() {
    secureStorage.readSecureData('email').then((value) {
      finalEmail = value;
    });
    Timer(
        Duration(seconds: 5),
        () => Navigator.pushReplacement(
            context,
            PageTransition(
                child: finalEmail == null ? LoginPage() : HomePage(),
                type: PageTransitionType.leftToRightWithFade)));
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
