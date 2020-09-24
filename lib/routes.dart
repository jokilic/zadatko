import 'package:flutter/widgets.dart';

import './screens/start_screen/start_screen.dart';
import './screens/home_screen/home_screen.dart';

final Map<String, WidgetBuilder> routes = {
  StartScreen.routeName: (context) => StartScreen(),
  HomeScreen.routeName: (context) => HomeScreen(),
};
