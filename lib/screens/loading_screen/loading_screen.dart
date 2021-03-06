import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../constants/errors.dart';
import '../../components/loading.dart';
import '../start_screen/start_screen.dart';
import '../tasks_screen/tasks_screen.dart';
import '../../components/my_error_widget.dart';

// Gets run first because Firebase needs to be initalized
class LoadingScreen extends StatelessWidget {
  static const routeName = '/loading-screen';

  // Initialize Firebase App
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        // Show Error Screen if the initialization throws an error
        if (snapshot.hasError) {
          return MyErrorWidget(firestoreInitializeError);
        }

        // Return a StreamBuilder if the Firebase app initializes
        if (snapshot.connectionState == ConnectionState.done) {
          return StreamBuilder<User?>(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context, snapshot) {
                // Show TasksScreen if the user is logged in
                if (snapshot.hasData) return TasksScreen();

                // Show StartScreen if the user is not logged in
                return StartScreen();
              });
        }

        // Show a LoadingScreen while waiting
        return Loading();
      },
    );
  }
}
