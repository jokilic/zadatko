import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './constants.dart';
import './routes.dart';
import './models/task.dart';
import './screens/start_screen/start_screen.dart';

void main() => runApp(Zadatko());

class Zadatko extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<Task>(
      create: (context) => Task(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: appName,
        theme: theme(),
        initialRoute: StartScreen.routeName,
        routes: routes,
      ),
    );
  }
}
