import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';

import '../constants/errors.dart';

enum LoginState {
  loggedIn,
  userNotFound,
  wrongPassword,
  wrongEmail,
  generalError,
}

enum SignupState {
  signedUp,
  accountExists,
  weakPassword,
  wrongEmail,
  generalError,
}

LoginState loginState;
SignupState signupState;

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
        throw (authUserNotFound);
      } else if (e.code == 'wrong-password') {
        loginState = LoginState.wrongPassword;
        throw (authPasswordWrong);
      }
    } catch (e) {
      loginState = LoginState.generalError;
      throw (authLoginError);
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
        throw (authPasswordWeak);
      } else if (e.code == 'email-already-in-use') {
        signupState = SignupState.accountExists;
        throw (authEmailInUse);
      }
    } catch (e) {
      signupState = SignupState.generalError;
      throw (authSignupError);
    }
  }

  ///////////////////////
  /// SIGNOUT
  ///////////////////////
  Future<void> signOutFirebase() async {
    try {
      await firebaseAuth.signOut();
    } catch (e) {
      throw (authSignoutError);
    }
  }
}
