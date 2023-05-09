import 'package:flutter/cupertino.dart';
import 'package:wmsm_flutter/view/admin_article/admin_article_page.dart';
import 'package:wmsm_flutter/view/admin_challenges/admin_challenges_page.dart';
import 'package:wmsm_flutter/view/admin_dashboard/admin_dashboard_page.dart';
import 'package:wmsm_flutter/view/admin_profile/admin_edit_phoneno.dart';
import 'package:wmsm_flutter/view/custom/widgets/bottom_navigator_bar_admin.dart';
import 'package:wmsm_flutter/view/user_profile/pages/edit_pwd.dart';
import 'package:wmsm_flutter/viewmodel/user_auth/verification_model.dart';
import 'package:wmsm_flutter/view/user_profile/pages/edit_username.dart';
import 'package:wmsm_flutter/view/user_profile/pages/edit_phoneno.dart';
import 'package:wmsm_flutter/view/user_profile/profile_page.dart';
import 'package:wmsm_flutter/viewmodel/user_auth/authentication_model.dart';
import 'view/custom/widgets/bottom_navigator_bar.dart';
import 'view/intro_page.dart';
import 'view/user_auth/reset_pwd_page.dart';
import 'view/user_auth/pages/user_details.dart';
import 'view/user_auth/pages/setup_password.dart';
import 'view/admin_profile/admin_profile_page.dart';
import 'view/user_profile/pages/bmi_page.dart';

Map<String, WidgetBuilder> routes = {
  //*User
  '/': (context) => const AuthenticationViewModel(),
  '/userdetails': (context) => const UserDetails(),
  '/setuppassword': (context) => const SetupPassword(),
  '/verifyemail': (context) => const VerificationViewModel(),
  '/intro': (context) => const IntroPage(),
  '/btmNav': (context) => BottomNavScreen(),
  '/bmiInfo': (context) => const BMIPage(),
  '/editUserName': (context) => const EditUserName(),
  '/editPwd': (context) => const EditPassword(),
  '/editPhoneNo': (context) => const EditPhoneNumber(),
  '/profile': (context) => const ProfilePage(),
  '/resetpwd': (context) => const ResetPassword(),

  //*Admin
  '/adminBtmNav': (context) => AdminBottomNavScreen(),
  '/adminProfile': (context) => const AdminProfilePage(),
  '/adminDashboard': (context) => const AdminDashboardPage(),
  '/adminChallenge': (context) => const AdminChallengePage(),
  '/adminArticle': (context) => const AdminArticlePage(),
  '/adminEditPhoneNo': (context) => const AdminEditPhoneNo(),
};
