// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:wmsm_flutter/view/admin_article/admin_article_page.dart';
import 'package:wmsm_flutter/view/admin_challenges/admin_challenges_page.dart';
import 'package:wmsm_flutter/view/admin_dashboard/admin_dashboard_page.dart';
import 'package:wmsm_flutter/view/admin_profile/admin_profile_page.dart';

class AdminBottomNavScreen extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _AdminBottomNavScreenState createState() => _AdminBottomNavScreenState();
}

class _AdminBottomNavScreenState extends State<AdminBottomNavScreen> {
  int _currentIndex = 0;
  final List<Widget> _admin_screens = [
    const AdminDashboardPage(),
    const AdminChallengePage(),
    const AdminArticlePage(),
    const AdminProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _admin_screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Theme.of(context).primaryColor,
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
          unselectedItemColor: Theme.of(context).primaryColor,
          unselectedLabelStyle:
              TextStyle(color: Theme.of(context).primaryColor),
          currentIndex: _currentIndex,
          onTap: (index) => setState(() => _currentIndex = index),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.emoji_events),
              label: 'Challenge',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.article),
              label: 'Article',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ]),
    );
  }
}
