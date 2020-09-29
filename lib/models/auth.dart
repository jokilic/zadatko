import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';

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
  // Login to Firebase with Email & Password
  Future<void> loginFirebase(String email, String password) async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      loginState = LoginState.loggedIn;
      print(loginState);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        loginState = LoginState.userNotFound;
        print(loginState);
      } else if (e.code == 'wrong-password') {
        loginState = LoginState.wrongPassword;
        print(loginState);
      }
    } catch (e) {
      loginState = LoginState.generalError;
      print(loginState);
      print('Zadatko: ${e.toString()}');
      print(e.message);
    }
  }

  // Signup to Firebase with Email & Password
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
        print('Zadatko: The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        signupState = SignupState.accountExists;
        print('Zadatko: The account already exists for that email.');
      }
    } catch (e) {
      signupState = SignupState.generalError;
      print('Zadatko: ${e.toString()}');
      print(e.message);
    }
  }

  // Sign out of Firebase
  Future<void> signOutFirebase() async => await firebaseAuth.signOut();
}
