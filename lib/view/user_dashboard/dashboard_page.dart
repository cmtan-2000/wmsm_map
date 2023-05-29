import 'package:flutter/material.dart';
import 'package:wmsm_flutter/model/users.dart';
import 'package:wmsm_flutter/view/user_dashboard/admin_dashboard_page.dart';
import 'package:wmsm_flutter/view/user_dashboard/user_dashboard_page.dart';
import 'package:wmsm_flutter/viewmodel/shared/shared_pref.dart';

//* The dashboard page to determine user dashboard or admin dashboard
class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  Users user = Users(
      dateOfBirth: '',
      email: '',
      fullname: '',
      phoneNumber: '',
      username: '',
      role: '');
  SharedPref sharedPref = SharedPref();

  @override
  initState() {
    super.initState();
    initialGetSavedData();
  }

  void initialGetSavedData() async {
    Users response = Users.fromJson(await sharedPref.read("user"));
    setState(() {
      user = Users(
          dateOfBirth: response.dateOfBirth,
          email: response.email,
          fullname: response.fullname,
          phoneNumber: response.phoneNumber,
          role: response.role,
          username: response.username);
    });
  }

  @override
  Widget build(BuildContext context) {
    return user.role == 'admin'
        ? const AdminDashboard()
        : user.role == 'user'
            ? UserDashboard(user: user)
            : const Center(child: CircularProgressIndicator());
  }
}
