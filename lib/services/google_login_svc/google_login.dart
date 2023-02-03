import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleLoginProvider extends ChangeNotifier {
  final googleSignIn = GoogleSignIn(
    scopes: ['email'],
  );

  GoogleSignInAccount? _user;

  GoogleSignInAccount get user => _user!;

  Future GoogleLogin() async {
    final googleUser = await googleSignIn.signIn();
    if (googleUser == null) {
      return;
    }
    _user = googleUser;

    final googleAuth = await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    await FirebaseAuth.instance.signInWithCredential(credential);

    // final response = await getCurrentUser();

    notifyListeners(); //update UI
  }
}
