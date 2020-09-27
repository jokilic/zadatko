import 'package:flutter/widgets.dart';

import './screens/loading_screen/loading_screen.dart';
import './screens/start_screen/start_screen.dart';
import './screens/tasks_screen/tasks_screen.dart';

final Map<String, WidgetBuilder> routes = {
  LoadingScreen.routeName: (context) => LoadingScreen(),
  StartScreen.routeName: (context) => StartScreen(),
  TasksScreen.routeName: (context) => TasksScreen(),
};
