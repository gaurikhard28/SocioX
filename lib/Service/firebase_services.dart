import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';


class FirebaseService{
  final _auth=FirebaseAuth.instance;
  final _googleSignIn=GoogleSignIn();
  signInWithGoogle() async{
    try{
      final GoogleSignInAccount? googleSignInAccount=
          await _googleSignIn.signIn();
      if(googleSignInAccount!=null){
        final GoogleSignInAuthentication googleSignInAuthentication=
            await googleSignInAccount.authentication;
        final AuthCredential authCredential=GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken
        );
        await _auth.signInWithCredential(authCredential);


      }
    }
    on FirebaseAuthException catch(e){
      print(e.message);
      throw e;
    }
}



  Future<UserCredential> signInWithFacebook() async {
    // Trigger the sign-in flow
    final LoginResult loginResult = await FacebookAuth.instance.login();

    // Create a credential from the access token
    final OAuthCredential facebookAuthCredential = FacebookAuthProvider.credential(loginResult.accessToken!.token);

    // Once signed in, return the UserCredential
    return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
  }


signOut() async{
    await _auth.signOut();
    await _googleSignIn.signOut();

}

}