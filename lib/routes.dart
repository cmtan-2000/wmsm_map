import 'package:flutter/cupertino.dart';
import 'package:wmsm_flutter/view/user_auth/auth_page.dart';

// import 'view/custom/widgets/bottom_navigation_bar.dart';
import 'view/custom/widgets/bottom_navigator_bar.dart';
import 'view/intro_page.dart';
import 'view/user_auth/pages/signup_form_1.dart';
import 'view/user_auth/pages/signup_form_2.dart';
import 'view/user_auth/pages/signup_form_3.dart';
import 'view/user_auth/pages/signup_form_4.dart';
import 'view/user_auth/pages/signup_form_5.dart';

Map<String, WidgetBuilder> routes = {
  '/': (context) => const AuthPage(),
  //'/widget': (context) => WidgetPage(),
  '/signup1': (context) => const SignUpForm1(),
  '/signup2': (context) => const SignUpForm2(),
  '/signup3': (context) => const SignUpForm3(),
  '/signup4': (context) => const SignUpForm4(),
  '/signup5': (context) => const SignUpForm5(),
  '/intro': (context) => const IntroPage(),
  // '/home': (context) => HomePage(),
  '/btmNav': (context) => BottomNavScreen(),

  // '/profile': (context) => ProfileScreen(),
};
