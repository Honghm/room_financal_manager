import 'package:flutter/material.dart';
import 'package:room_financal_manager/screens/home_page.dart';
import 'package:room_financal_manager/screens/login_page.dart';
import 'package:room_financal_manager/screens/personal_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/login',
      routes: {
        '/login':(context)=>LoginPage(),
        '/home':(context)=>HomePage(),
        '/personal': (context)=>PersonalPage(),
      },
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}


