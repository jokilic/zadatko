import 'package:flutter/material.dart';

import '../../constants.dart';
import '../../components/zadatko_button.dart';
import '../../models/auth.dart';

class TasksScreen extends StatelessWidget {
  static const routeName = '/tasks-screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkColor,
      body: Container(
        padding: EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              connectedString,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline1,
            ),
            SizedBox(height: 56.0),
            ZadatkoButton(
              text: 'Sign out'.toUpperCase(),
              onTap: () async => await Auth().signOutFirebase(),
            ),
          ],
        ),
      ),
    );
  }
}
