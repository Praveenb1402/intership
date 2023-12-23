import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:untitled/main_page.dart';

class Googolesigin extends ChangeNotifier {



  Future<void> signInWithGoogle(BuildContext context, bool _isloading) async {

    final FirebaseAuth _auth = FirebaseAuth.instance;
    final GoogleSignIn googleSignIn = GoogleSignIn();
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
    if (googleUser == null) {
      return;
    }

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Once signed in, return the UserCredential
    var userCredential = await _auth.signInWithCredential(credential);
    if(userCredential.user!=null) {
      _isloading=false;
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => main_page()));
    }

  }
}
