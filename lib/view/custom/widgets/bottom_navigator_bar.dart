// ignore_for_file: use_key_in_widget_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wmsm_flutter/view/user_dashboard/dashboard_page.dart';
// import 'package:wmsm_flutter/view/user_dashboard/dashboard.dart';
import 'package:wmsm_flutter/viewmodel/shared/shared_pref.dart';

import '../../../model/users.dart';
import '../../user_article/article_page.dart';
import '../../user_challenges/challenge_page.dart';
import '../../user_profile/profile_page.dart';

class BottomNavScreen extends StatefulWidget {
  const BottomNavScreen({super.key, this.index = 0});
  final int index;

  @override
  // ignore: library_private_types_in_public_api
  _BottomNavScreenState createState() => _BottomNavScreenState();
}

class _BottomNavScreenState extends State<BottomNavScreen> {
  late int _currentIndex;

  String role = '';
  late SharedPref sharedPref = SharedPref();
  late Users user;
  @override
  void initState() {
    _currentIndex = widget.index;
    // TODO: implement initState
    super.initState();
    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) {
      setState(() {
        user = Users(
            fullname: value.data()!['fullname'],
            username: value.data()!['username'],
            email: value.data()!['email'],
            phoneNumber: value.data()!['phoneNumber'],
            dateOfBirth: value.data()!['dateOfBirth'],
            role: value.data()!['role']);
        sharedPref.save('user', user);

        role = user.role;
      });
    });
  }

  final List<Widget> screens = [
    const Dashboard(),
    const ChallengePage(),
    const ArticlePage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Theme.of(context).primaryColor,
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
          unselectedItemColor: Theme.of(context).primaryColor,
          unselectedLabelStyle:
              TextStyle(color: Theme.of(context).primaryColor),
          currentIndex: _currentIndex,
          onTap: (index) => setState(() => _currentIndex = index),
          items: [
            const BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.emoji_events),
              label: 'Challenge',
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.article),
              label: 'Article',
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.person),
              label: role == "admin" ? 'Admin' : 'Profile',
            ),
          ]),
    );
  }
}
