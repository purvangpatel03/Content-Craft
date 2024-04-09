import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignup extends StatelessWidget {
  const GoogleSignup({super.key});

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: () async {
        if (kIsWeb) {
          await webSignInGoogle();
          if(context.mounted){
            Navigator.pop(context);
          }
        } else {
          await signInWithGoogle();
          if(context.mounted){
            Navigator.pop(context);
          }
        }
      },
      style: FilledButton.styleFrom(
        backgroundColor: Colors.amberAccent,
        minimumSize: const Size.fromHeight(56),
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image(
            height: 28,
            image: AssetImage('assets/login_signup/google.png'),
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            'Sign-up with Google',
            style: TextStyle(color: Colors.black, fontSize: 16),
          ),
        ],
      ),
    );
  }

  Future<UserCredential> signInWithGoogle() async {
    final GoogleSignInAccount? googleAccount = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication googleAuth =
        await googleAccount!.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    return await FirebaseAuth.instance.signInWithCredential(credential);

  }

  Future<UserCredential> webSignInGoogle() async {
    GoogleAuthProvider googleProvider = GoogleAuthProvider();

    googleProvider
        .addScope('https://www.googleapis.com/auth/contacts.readonly');
    googleProvider.setCustomParameters({'login_hint': 'user@example.com'});
    return await FirebaseAuth.instance.signInWithPopup(googleProvider);
  }
}
