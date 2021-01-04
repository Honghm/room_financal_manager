import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:room_financal_manager/config/initialization.dart';
import 'package:room_financal_manager/models/user.dart';
import 'package:room_financal_manager/screens/register_page.dart';


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

  ///--------------------Đăng Nhập Thường-----------------------------

  Future<bool> signIn(  GlobalKey<ScaffoldState> _key, {String phone, String password, BuildContext context, Function success}) async {
    _status = Status.Loading;
    notifyListeners();
    FirebaseFirestore.instance.collection("Users").get().then((data){
      for(int i = 0; i<data.size;i++){
        if( data.docs[i].data()["phoneNumber"]==phone&& data.docs[i].data()["password"]==password){
          _userData = UserData.formSnapShot(data.docs[i]);
          notifyListeners();
          success(context, _userData);
        }
      }
    }).then((value) {

      if(userData==null){
        _status = Status.Authenticated;
        notifyListeners();
        _key.currentState.showSnackBar(SnackBar(
            content: Text(
                "Đăng nhập không thành công! Tài khoản hoặc mật khẩu không đúng")));
      }else{
        _status = Status.Loaded;
        notifyListeners();
      }


    });

  }


  FirebaseAuth auth = FirebaseAuth.instance;


  ///-------------Kiểm tra ID đã tồn tại hay chưa?--------------
 bool checkID(String id, String displayName,String email, String phoneNumber, String password, BuildContext context){
   FirebaseFirestore.instance.collection("Users").doc(id.toString()).get().then((value) {
     if(value.data() == null){
       _firestore.collection('Users').doc(id).set({
         'uid': id,
         'displayName': displayName,
         'email':email,
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

 ///-------------Đăng ký tài khoản-------------
Future<void> registerAccount({String displayName,String email, String phoneNumber, String password,Function success, BuildContext context}) async{
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
     ///Bắt đầu đăng ký
     while(checkID(id.toString(),displayName, email, phoneNumber,password,context)){
      id = random.nextInt(100000) + 100000;
      checkID(id.toString(),displayName,email, phoneNumber,password,context);
     }
     ///Đăng ký thành công
     success();
   }catch(e){
     return;
   }

}


///---------------Đăng nhập bằng tài khoản google-------------------
Future<void> loginWithGoogle({BuildContext context, Function success}) async {
    try {
      _status = Status.Loading;
      notifyListeners();
      account = await googleSignIn.signIn();
      notifyListeners();
      await _auth
          .signInWithCredential(GoogleAuthProvider.credential(
        idToken: (await account.authentication).idToken,
        accessToken: (await account.authentication).accessToken,
      ))
          .then((user) {

        FirebaseFirestore.instance
            .collection('Users')
            .where("email", isEqualTo: account.email)
            .snapshots()
            .listen((data){
              if(data.docs.isEmpty){

                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            RegisterPage(
                              kindLogin: "google",
                              email: account.email,
                            )));
                _status = Status.Loaded;
                notifyListeners();
              }else{

                _userData = UserData.formSnapShot(data.docs.first);
                notifyListeners();
                success(context, _userData);
                _status = Status.Loaded;
                notifyListeners();
              }
        });
      }).catchError((e){
        print("Error: $e");
      });
    } catch (e) {
      _status = Status.Unauthenticated;
      notifyListeners();
    }
  }


  ///------------------Đăng nhập bằng tài khoản facebook----------------
  FacebookLogin facebookLogin = FacebookLogin();
  Future<void>loginWithFacebook({BuildContext context, Function success})async{

   try{
     _status = Status.Loading;
     notifyListeners();
     final FacebookLoginResult result = await facebookLogin.logIn(['email', 'public_profile']);

     switch (result.status) {
       case FacebookLoginStatus.cancelledByUser:
         break;
       case FacebookLoginStatus.error:
         break;
       case FacebookLoginStatus.loggedIn:
         try {
           final FacebookAccessToken accessToken = result.accessToken;
           AuthCredential credential =
           FacebookAuthProvider.credential(accessToken.token);
           print("run here: }");
           await _auth.signInWithCredential(credential).then((value) {
             FirebaseFirestore.instance
                 .collection('Users')
                 .where("email", isEqualTo: value.user.email)
                 .snapshots()
                 .listen((data){
               if(data.docs.isEmpty){
                 Navigator.push(
                     context,
                     MaterialPageRoute(
                         builder: (context) =>
                             RegisterPage(
                               kindLogin: "facebook",
                               email: value.user.email,
                             )));
                 _status = Status.Loaded;
                 notifyListeners();
               }else{
                 // _userData = UserData.formSnapShot(data.docs.first);
                 // notifyListeners();
                 // success(context, _userData);
                 // _status = Status.Loaded;
                 // notifyListeners();
               }
             });
           });
         } catch (e) {
           print(e);
         }
         break;
     }
   }catch(e){}

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
