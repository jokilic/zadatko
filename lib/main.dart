import 'package:flutter/material.dart';

import './constants/general.dart';
import './constants/theme.dart';
import './constants/routes.dart';
import './screens/loading_screen/loading_screen.dart';

void main() => runApp(Zadatko());

class Zadatko extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appName,
      theme: theme(),
      initialRoute: LoadingScreen.routeName,
      routes: routes,
    );
  }
}
