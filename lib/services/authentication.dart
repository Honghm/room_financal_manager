import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:room_financal_manager/services/storage.dart';

class Authentication {
  final SecureStorage secureStorage = SecureStorage();
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<String> googleSignIn({BuildContext context, Function success}) async {
    final GoogleSignInAccount googleSignInAccount =
        await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;
    final AuthCredential authCredential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken);
    final UserCredential userCredential =
        await _firebaseAuth.signInWithCredential(authCredential).then((value){
          
        });
    final User user = userCredential.user;
    assert(user.displayName != null);
    assert(user.email != null);
    print(user.displayName);
    print(user.email);
    print(user.refreshToken);
    final User currentUser = _firebaseAuth.currentUser;
    assert(currentUser.uid == user.uid);
    secureStorage.writeSecureData('email', user.email);
    secureStorage.writeSecureData('name', user.displayName);

    return 'Error occured';
  }

  Future<String> googleSignOut() async {
    _googleSignIn.signOut();

    return 'Error out';
  }
}
