import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:room_financal_manager/config/initialization.dart';
import 'package:room_financal_manager/models/user.dart';
import 'package:room_financal_manager/screens/login_with_google.dart';
<<<<<<< HEAD
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
=======
import 'package:room_financal_manager/providers/user_provider.dart';
>>>>>>> 116af0f... aa

class UserProvider with ChangeNotifier {
  FirebaseAuth _auth;

  User _user;

  User get user => _user;

  UserData _userData;

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
        .where("account", isEqualTo: phone)
        .snapshots()
        .listen((data) {
      if (data.docs.length != 0) {
        print("đúng tài khoản");
        FirebaseFirestore.instance
            .collection('Users')
            .where("pass", isEqualTo: password)
            .snapshots()
            .listen((data) async {
          if (data.docs.length != 0) {
            print("đúng pass");
            FirebaseFirestore.instance
                .collection('Users')
                .where("account", isEqualTo: phone)
                .snapshots()
                .listen((data) => data.docs.forEach((doc) {
                      _userData = UserData.formSnapShot(doc);
                      notifyListeners();
                    }));
            Navigator.pushNamed(context, '/main');
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
}
