import 'package:flutter/cupertino.dart';
import 'package:wmsm_flutter/view/signin_page.dart';

import 'view/custom/widgets/bottom_navigation_bar.dart';
import 'view/intro_page.dart';
import 'view/user_auth/signup_form_1.dart';
import 'view/user_auth/signup_form_2.dart';
import 'view/user_auth/signup_form_3.dart';
import 'view/user_auth/signup_form_4.dart';
import 'view/user_auth/signup_form_5.dart';

Map<String, WidgetBuilder> routes = {
  '/': (context) => const SignInPage(),
  //'/widget': (context) => WidgetPage(),
  '/f1': (context) => const SignUpForm1(),
  '/f2': (context) => const SignUpForm2(),
  '/f3': (context) => const SignUpForm3(),
  '/f4': (context) => const SignUpForm4(),
  '/f5': (context) => const SignUpForm5(),
  '/intro': (context) => const IntroPage(),
  //'/home': (context) => HomePage(),
  '/btmNav': (context) => const BottomNavScreen(),

  // '/profile': (context) => ProfileScreen(),
};
