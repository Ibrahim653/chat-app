import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:scholar_chat/helper/shared_pref_helper.dart';
import 'package:scholar_chat/pages/chat_page.dart';
import 'package:scholar_chat/services/database.dart';

class AuthMethods {
  final FirebaseAuth auth = FirebaseAuth.instance;

  getCurrentUser() async{
    return await auth.currentUser;
  }

  signWithGoogle(BuildContext context) async {
    final FirebaseAuth _fireBaseAuth = FirebaseAuth.instance;
    final GoogleSignIn _googleSignIn = GoogleSignIn();

    final GoogleSignInAccount googleSignInAccount =
        await _googleSignIn.signIn();

    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      idToken: googleSignInAuthentication.idToken,
      accessToken: googleSignInAuthentication.accessToken,
    );

    final UserCredential result =
        await _fireBaseAuth.signInWithCredential(credential);

    User? userDetails = result.user;

    if (result != null) {
      SharedPreferenceHelper().saveUserDisplayName(userDetails!.displayName!);
      SharedPreferenceHelper().saveUserEmail(userDetails.email!);
      SharedPreferenceHelper().saveUserID(userDetails.uid);
      SharedPreferenceHelper().saveUserProfileUrl(userDetails.photoURL!);

      Map<String, dynamic> userInfoMap = {
        'email': userDetails.email,
        'username': userDetails.email!.replaceAll("@gmail.com", ""),
        'name': userDetails.displayName,
        'imgUrl': userDetails.photoURL,
      };

      DataBaseMethods()
          .addUserInfoToDB(userDetails.uid, userInfoMap)
          .then((value) {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>ChatPage()));
      });
    }
  }
}
