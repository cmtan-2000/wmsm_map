import 'package:flutter/cupertino.dart';
import 'package:wmsm_flutter/view/user_auth/main_page.dart';
import 'package:wmsm_flutter/view/widgetPage.dart';

Map<String, WidgetBuilder> routes = {
  '/': (context) => const MainPage(),
  '/widget': (context) => WidgetPage()
  // '/profile': (context) => ProfileScreen(),
};
