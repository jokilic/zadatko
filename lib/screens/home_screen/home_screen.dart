import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

import './components/loading.dart';
import './components/app_running.dart';
import './components/error_screen.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = '/home-screen';

  final Future<FirebaseApp> initialization = Firebase.initializeApp();
  Future init() async {
    await Firebase.initializeApp();
    FirebaseAuth.instance;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: init(),
        builder: (context, snapshot) {
          if (snapshot.hasError) return ErrorScreen();
          if (snapshot.connectionState == ConnectionState.done)
            return AppRunning();
          return Loading();
        },
      ),
    );
  }
}
