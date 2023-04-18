import 'package:flutter/cupertino.dart';
import 'package:wmsm_flutter/view/user_auth/main_page.dart';
import 'package:wmsm_flutter/view/widgetPage.dart';

import 'view/user_auth/signup_form_3.dart';
import 'view/user_auth/signup_form_4.dart';
import 'view/user_auth/signup_form_5.dart';

Map<String, WidgetBuilder> routes = {
  '/': (context) => const MainPage(),
  '/widget': (context) => WidgetPage(),
  '/f3': (context) => const SignUpForm3(),
  '/f4': (context) => const SignUpForm4(),
  '/f5': (context) => const SignUpForm5()
  // '/profile': (context) => ProfileScreen(),
};
