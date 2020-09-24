import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AppRunning extends StatelessWidget {
  Future<void> createUser(String email, String password) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Aplikacija radi 😊',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 36.0,
            ),
          ),
          SizedBox(height: 24.0),
          FlatButton(
            padding: EdgeInsets.symmetric(
              horizontal: 24.0,
              vertical: 12.0,
            ),
            onPressed: () => null,
            color: Colors.indigo[500],
            child: Text(
              'Napravi usera'.toUpperCase(),
              style: TextStyle(
                color: Colors.white,
                fontSize: 24.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
