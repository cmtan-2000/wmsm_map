import 'package:flutter/cupertino.dart';
import 'package:wmsm_flutter/view/home_page.dart';
import 'package:wmsm_flutter/view/introPage.dart';
import 'package:wmsm_flutter/view/user_auth/main_page.dart';
import 'package:wmsm_flutter/view/widgetPage.dart';

import 'view/user_auth/signup_form_3.dart';

Map<String, WidgetBuilder> routes = {
  '/': (context) => const MainPage(),
  '/widget': (context) => WidgetPage(),
  '/intro': (context) => const IntroPage(),
  '/home': (context) => const HomePage(),
  '/f3': (context) => const SignUpForm3()

  // '/profile': (context) => ProfileScreen(),
};
