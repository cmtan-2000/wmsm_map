// This is challenge page
import 'package:flutter/material.dart';

import '../../model/users.dart';
import '../../viewmodel/shared/shared_pref.dart';

class ChallengePage extends StatefulWidget {
  const ChallengePage({super.key});

  @override
  State<ChallengePage> createState() => _ChallengePageState();
}

class _ChallengePageState extends State<ChallengePage> {
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
        ? const Center(
            child: Text('This is challenges page Admin')) // Admin Page
        : user.role == 'user'
            ? const Center(child: Text('This is challenges page User'))
            : const Center(
                child: CircularProgressIndicator(),
              );
  }
}
