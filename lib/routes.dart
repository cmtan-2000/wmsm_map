import 'package:flutter/cupertino.dart';
import 'package:wmsm_flutter/viewmodel/user_auth/verification_model.dart';
import 'package:wmsm_flutter/view/user_profile/pages/edit_email.dart';
import 'package:wmsm_flutter/view/user_profile/pages/edit_phoneno.dart';
import 'package:wmsm_flutter/view/user_profile/pages/edit_pwd.dart';
import 'package:wmsm_flutter/view/user_profile/profile_page.dart';
import 'package:wmsm_flutter/viewmodel/user_auth/authentication_model.dart';
import 'view/custom/widgets/bottom_navigator_bar.dart';
import 'view/intro_page.dart';
import 'view/user_auth/reset_pwd_page.dart';
import 'view/user_auth/pages/user_details.dart';
import 'view/user_auth/pages/setup_password.dart';
import 'view/user_profile/pages/bmi_page.dart';

Map<String, WidgetBuilder> routes = {
  '/': (context) => const AuthenticationViewModel(),
  '/userdetails': (context) => const UserDetails(),
  '/setuppassword': (context) => const SetupPassword(),
  '/verifyemail': (context) => const VerificationViewModel(),
  '/intro': (context) => const IntroPage(),
  '/btmNav': (context) => BottomNavScreen(),
  '/bmiInfo': (context) => const BMIPage(),
  '/editEmail': (context) => const EditEmail(),
  '/editPwd': (context) => const EditPassword(),
  '/editPhoneNo': (context) => const EditPhoneNumber(),
  '/profile': (context) => const ProfilePage(),
  '/resetpwd': (context) => const ResetPassword(),
};
