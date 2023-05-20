// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:wmsm_flutter/view/user_dashboard/dashboard_page.dart';

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
  final List<Widget> _user_screens = [
    const Dashboard(),
    const ChallengePage(),
    const ArticlePage(),
    const ProfilePage(),
  ];

  @override
  void initState() {
    _currentIndex = widget.index;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _user_screens[_currentIndex],
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
