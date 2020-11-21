import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';

import '../constants/enums.dart';
import '../constants/errors.dart';

LoginState? loginState;
SignupState? signupState;

FirebaseAuth firebaseAuth = FirebaseAuth.instance;

class Auth {
  ///////////////////////
  /// LOGIN
  ///////////////////////
  Future<void> loginFirebase(String email, String password) async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      loginState = LoginState.loggedIn;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        loginState = LoginState.userNotFound;
        print(authUserNotFound);
        // throw (authUserNotFound);
      } else if (e.code == 'wrong-password') {
        loginState = LoginState.wrongPassword;
        print(authPasswordWrong);
        // throw (authPasswordWrong);
      }
    } catch (e) {
      loginState = LoginState.generalError;
      print(authLoginError);
      // throw (authLoginError);
    }
  }

  ///////////////////////
  /// SIGNUP
  ///////////////////////
  Future<void> signupFirebase(String email, String password) async {
    try {
      await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      signupState = SignupState.signedUp;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        signupState = SignupState.weakPassword;
        print(authPasswordWeak);
        // throw (authPasswordWeak);
      } else if (e.code == 'email-already-in-use') {
        signupState = SignupState.accountExists;
        print(authEmailInUse);
        // throw (authEmailInUse);
      }
    } catch (e) {
      signupState = SignupState.generalError;
      print(authSignupError);
      // throw (authSignupError);
    }
  }

  ///////////////////////
  /// SIGNOUT
  ///////////////////////
  Future<void> signOutFirebase() async {
    try {
      await firebaseAuth.signOut();
    } catch (e) {
      print(authSignoutError);
      // throw (authSignoutError);
    }
  }
}
