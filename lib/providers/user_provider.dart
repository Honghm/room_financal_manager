import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:room_financal_manager/config/initialization.dart';
import 'package:room_financal_manager/models/user.dart';
import 'package:room_financal_manager/screens/home_page.dart';
import 'package:room_financal_manager/screens/login_with_google.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:room_financal_manager/widgets/verity_number.dart';

class UserProvider with ChangeNotifier {
  FirebaseAuth _auth;

  User _user;

  User get user => _user;

  UserData _userData;

  set userData(UserData value) {
    _userData = value;
    notifyListeners();
  }

  UserData get userData => _userData;

  Status _status = Status.Uninitialized;

  Status get status => _status;

  bool get isMailExist => _isMailExist;

  set isMailExist(bool value) {
    _isMailExist = value;
  }

  bool _isLogin = false;

  bool get isLogin => _isLogin;
  bool _isMailExist = false;
  bool _loginGoogle = false;

  bool get loginGoogle => _loginGoogle;

  set loginGoogle(bool value) {
    _loginGoogle = value;
  }

  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  GoogleSignIn googleSignIn = GoogleSignIn(scopes: ['profile', 'email']);

  GoogleSignInAccount account;
  UserProvider.initialize() : _auth = FirebaseAuth.instance {
    _auth.authStateChanges().listen(_onStateChanged);
  }

  Future<void> _onStateChanged(User user) async {
    if (user == null) {
      _status = Status.Unauthenticated;
    } else {
      _status = Status.Authenticated;
    }
    notifyListeners();
  }

  //--------------------Đăng Nhập-----------------------------

  Future<bool> signIn(String phone, String password, BuildContext context,
      GlobalKey<ScaffoldState> _key) async {
    FirebaseFirestore.instance
        .collection('Users')
        .where("phoneNumber", isEqualTo: phone)
        .snapshots()
        .listen((data) {
      if (data.docs.length != 0) {
        FirebaseFirestore.instance
            .collection('Users')
            .where("password", isEqualTo: password)
            .snapshots()
            .listen((data) async {
          if (data.docs.length != 0) {
           FirebaseFirestore.instance
                .collection('Users')
                .where("phoneNumber", isEqualTo: phone)
                .get().then((data) {
                 data.docs.forEach((item) {
                   _userData = UserData.formSnapShot(item);
                   notifyListeners();
                 });
           }).then((value) {
             Navigator.pushReplacement(context,   MaterialPageRoute(
               builder: (context) => HomePage(user: _userData,)
             ));
           });
          } else {
            _key.currentState.showSnackBar(SnackBar(
                content: Text(
                    "Đăng nhập không thành công! Tài khoản hoặc mật khẩu không đúng")));
          }
        });
      } else {
        _key.currentState.showSnackBar(SnackBar(
            content:
                Text("Đăng nhập không thành công!Tài khoản không tồn tại")));
      }
    });
  }


  FirebaseAuth auth = FirebaseAuth.instance;


 bool checkID(String id, String displayName, String phoneNumber, String password, BuildContext context){
   FirebaseFirestore.instance.collection("Users").doc(id.toString()).get().then((value) {
     if(value.data() == null){
       _firestore.collection('Users').doc(id).set({
         'uid': id,
         'displayName': displayName,
         'phoneNumber': phoneNumber,
         'password': password,
         'avatar':"",
         'cover':"",
       });
         return true;
       }
     return false;
   });
   return false;
 }
Future<void> registerAccount({String displayName, String phoneNumber, String password,Function success, BuildContext context}) async{
   try{
     await FirebaseFirestore.instance
         .collection('Users').get().then((value) {
       for(int i = 0; i<value.docs.length;i++){
         if(value.docs[i].data()["phoneNumber"] == phoneNumber)
           return;
       }
     });
     Random random = new Random();
     int id = random.nextInt(100000) + 100000;
     while(checkID(id.toString(),displayName,phoneNumber,password,context)){
      id = random.nextInt(100000) + 100000;
      checkID(id.toString(),displayName,phoneNumber,password,context);
     }
     success();
   }catch(e){
     return;
   }

}
  Future<bool> loginWithGoogle(
      BuildContext context, GlobalKey<ScaffoldState> _key) async {
    try {
      loginGoogle = true;
      notifyListeners();
      _status = Status.Authenticating;
      notifyListeners();
      account = await googleSignIn.signIn();
      notifyListeners();
      await _auth
          .signInWithCredential(GoogleAuthProvider.credential(
        idToken: (await account.authentication).idToken,
        accessToken: (await account.authentication).accessToken,
      ))
          .then((user) {
            print("run here: login");
        // FirebaseFirestore.instance
        //     .collection('users')
        //     .where("account", isEqualTo: account.email)
        //     .snapshots()
        //     .listen((data) => data.docs.forEach((doc) {
        //           _userData = UserData.formSnapShot(doc);
        //           notifyListeners();
        //           _isMailExist = true;
        //           notifyListeners();
        //         }));
        Navigator.pushNamed(context, '/home');
      }).catchError((e){
        print("Error: $e");
      });

      // FirebaseFirestore.instance
      //     .collection('users')
      //     .where("account", isEqualTo: account.email)
      //     .snapshots()
      //     .listen((data) async {
      //   if (data.docs.length == 0) {
      //     await _auth
      //         .signInWithCredential(GoogleAuthProvider.credential(
      //       idToken: (await account.authentication).idToken,
      //       accessToken: (await account.authentication).accessToken,
      //     ))
      //         .then((user) {
      //       _isMailExist = false;
      //       notifyListeners();
      //       Navigator.push(context,
      //           MaterialPageRoute(builder: (context) => LoginWithGoogle()));
      //       _status = Status.Unauthenticated;
      //       notifyListeners();
      //     });
      //   } else {
      //     await _auth
      //         .signInWithCredential(GoogleAuthProvider.credential(
      //       idToken: (await account.authentication).idToken,
      //       accessToken: (await account.authentication).accessToken,
      //     ))
      //         .then((user) {
      //       FirebaseFirestore.instance
      //           .collection('users')
      //           .where("account", isEqualTo: account.email)
      //           .snapshots()
      //           .listen((data) => data.docs.forEach((doc) {
      //                 _userData = UserData.formSnapShot(doc);
      //                 notifyListeners();
      //                 _isMailExist = true;
      //                 notifyListeners();
      //               }));
      //       Navigator.pushNamed(context, '/home');
      //     });
      //   }
      // });
      return true;
    } catch (e) {
      _status = Status.Unauthenticated;
      notifyListeners();
      return false;
    }
  }

  Future<Map<String, dynamic>> getNameById(String id) async {
    try{
      Map<String, dynamic> member = {};
      await FirebaseFirestore.instance.collection("Users").doc(id).get().then((value) {
        member = value.data();
        notifyListeners();
      });
      return member;
    }catch(e){
      print(e);
    }

  }
}
