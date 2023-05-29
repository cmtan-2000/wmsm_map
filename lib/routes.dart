import 'package:flutter/material.dart';
import 'package:wmsm_flutter/view/example_provider.dart';
import 'package:wmsm_flutter/view/user_article/article_detail.dart';
import 'package:wmsm_flutter/view/user_challenges/admin/admin_add_challenge.dart';
import 'package:wmsm_flutter/view/user_challenges/admin/admin_edit_challenge.dart';
import 'package:wmsm_flutter/view/user_challenges/admin/admin_manage_challenge_page.dart';
import 'package:wmsm_flutter/view/user_challenges/user/user_join_challenge_page.dart';
import 'package:wmsm_flutter/view/user_dashboard/notification_page.dart';
import 'package:wmsm_flutter/view/user_profile/pages/edit_pwd.dart';
import 'package:wmsm_flutter/viewmodel/user_auth/verification_model.dart';
import 'package:wmsm_flutter/view/user_profile/pages/edit_username.dart';
import 'package:wmsm_flutter/view/user_profile/pages/edit_phoneno.dart';
import 'package:wmsm_flutter/view/user_profile/profile_page.dart';
import 'package:wmsm_flutter/viewmodel/user_auth/authentication_model.dart';
import 'model/users.dart';
import 'view/custom/widgets/bottom_navigator_bar.dart';
import 'view/health_conn/healthPage.dart';
import 'view/intro_page.dart';
import 'view/user_auth/reset_pwd_page.dart';
import 'view/user_auth/pages/user_details.dart';
import 'view/user_auth/pages/setup_password.dart';
import 'view/user_profile/pages/bmi_page.dart';

// Map<String, WidgetBuilder> routes = {
//   //*User
//   '/': (context) => const AuthenticationViewModel(),
//   '/userdetails': (context) => const UserDetails(),
//   '/setuppassword': (context) => const SetupPassword(),
//   '/verifyemail': (context) => const VerificationViewModel(),
//   '/intro': (context) => const IntroPage(),
//   '/btmNav': (context) => BottomNavScreen(),
//   '/bmiInfo': (context) => const BMIPage(),
//   '/editUserName': (context) => const EditUserName(),
//   '/editPwd': (context) => const EditPassword(),
//   '/editPhoneNo': (context) => const EditPhoneNumber(),
//   '/profile': (context) => const ProfilePage(),
//   '/resetpwd': (context) => const ResetPassword(),

//   //*Admin
//   '/adminBtmNav': (context) => AdminBottomNavScreen(),
//   // '/adminProfile': (context) => const AdminProfilePage(),
//   '/adminDashboard': (context) => const AdminDashboardPage(),
//   '/adminChallenge': (context) => const AdminChallengePage(),
//   '/adminArticle': (context) => const AdminArticlePage(),
//   '/adminEditPhoneNo': (context) => const AdminEditPhoneNo(),
// };

Route<dynamic>? generateRoute(RouteSettings settings) {
  final args = settings.arguments;

  switch (settings.name) {
    case '/':
      return MaterialPageRoute(
          builder: (context) => const AuthenticationViewModel());
    case '/provider':
      return MaterialPageRoute(builder: (context) => const ProviderPage());
    case '/editUserName':
      return MaterialPageRoute(
          builder: (context) => EditUserName(user: args as Users));
    case '/editPwd':
      return MaterialPageRoute(
          builder: (context) => EditPassword(
                user: args as Users,
              ));
    case '/editPhoneNo':
      return MaterialPageRoute(
        builder: (context) => EditPhoneNumber(user: args as Users),
      );
    case '/profile':
      return MaterialPageRoute(builder: (context) => const ProfilePage());
    case '/resetpwd':
      return MaterialPageRoute(builder: (context) => const ResetPassword());
    case '/userdetails':
      return MaterialPageRoute(builder: (context) => const UserDetails());
    case '/setuppassword':
      return MaterialPageRoute(builder: (context) => const SetupPassword());
    case '/verifyemail':
      return MaterialPageRoute(
          builder: (context) => const VerificationViewModel());
    case '/intro':
      return MaterialPageRoute(builder: (context) => const IntroPage());
    case '/btmNav':
      return MaterialPageRoute(builder: (context) => const BottomNavScreen());
    case '/bmiInfo':
      return MaterialPageRoute(
          builder: (context) => BMIPage(user: args as Users));
    case '/healthConn':
      return MaterialPageRoute(builder: (context) => const HeahthPage());
    case '/articlePage':
      return MaterialPageRoute(
          builder: (context) => const BottomNavScreen(index: 2));
    case '/challengePage':
      return MaterialPageRoute(
          builder: (context) => const BottomNavScreen(index: 1));
    case '/notification':
      return MaterialPageRoute(builder: (context) => NotificationPage());
    case '/adminjoinChallenge':
      return MaterialPageRoute(
          builder: (context) => AdminJoinChallengePage(user: args as Users));
    case '/userjoinChallenge':
      return MaterialPageRoute(
          builder: (context) => const UserJoinChallengePage());
    case '/articleDetails':
      return MaterialPageRoute(builder: (context) => const ArticleDetails());
    case '/addChallenge':
      return MaterialPageRoute(builder: (context) => const AdminAddChallenge());
    case '/editChallenge':
      return MaterialPageRoute(
          builder: (context) => const AdminEditChallenge());
    // case '/leaderboard':
    //   return MaterialPageRoute(builder: (context) => const LeaderboardPage());
    default:
      return null;
  }
}
