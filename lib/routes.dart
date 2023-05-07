import 'package:flutter/cupertino.dart';
import 'package:wmsm_flutter/view/user_auth/auth_page.dart';
import 'package:wmsm_flutter/view/user_profile/pages/edit_email.dart';
import 'package:wmsm_flutter/view/user_profile/pages/edit_phoneno.dart';
import 'package:wmsm_flutter/view/user_profile/pages/edit_pwd.dart';
import 'package:wmsm_flutter/view/user_profile/profile_page.dart';

// import 'view/custom/widgets/bottom_navigation_bar.dart';
import 'view/custom/widgets/bottom_navigator_bar.dart';
import 'view/intro_page.dart';
import 'view/user_auth/reset_pwd_page.dart';
import 'view/user_auth/pages/signup_form_1.dart';
import 'view/user_auth/pages/signup_form_2.dart';
import 'view/user_auth/pages/signup_form_3.dart';
import 'view/user_auth/pages/signup_form_4.dart';
import 'view/user_auth/pages/signup_form_5.dart';
import 'view/user_profile/pages/bmi_page.dart';

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
  '/bmiInfo': (context) => const BMIPage(),
  '/editEmail': (context) => const EditEmail(),
  '/editPwd': (context) => const EditPassword(),
  '/editPhoneNo': (context) => const EditPhoneNumber(),
  '/profile': (context) => const ProfilePage(),
  '/resetpwd': (context) => const ResetPassword(),
};
