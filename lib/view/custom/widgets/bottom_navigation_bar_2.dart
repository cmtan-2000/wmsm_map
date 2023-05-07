import 'package:flutter/material.dart';

import '../../user_article/article_page.dart';
import '../../user_challenges/challenge_page.dart';
import '../../user_profile/profile_page.dart';
import '../../user_dashboard/dashboard.dart';

class BottomNavScreen2 extends StatefulWidget {
  const BottomNavScreen2({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _BottomNavScreen2State createState() => _BottomNavScreen2State();
}

class _BottomNavScreen2State extends State<BottomNavScreen2> {
  int _currentIndex = 0;
  final List<Widget> _screens = [
    const Dashboard(),
    const ChallengePage(),
    const ArticlePage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(28), topRight: Radius.circular(28)),
        child: NavigationBar(
            animationDuration: const Duration(milliseconds: 500),
            selectedIndex: _currentIndex,
            onDestinationSelected: (index) =>
                setState(() => _currentIndex = index),
            destinations: const [
              NavigationDestination(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              NavigationDestination(
                icon: Icon(Icons.emoji_events),
                label: 'Challenge',
              ),
              NavigationDestination(
                icon: Icon(Icons.article),
                label: 'Article',
              ),
              NavigationDestination(
                icon: Icon(Icons.person),
                label: 'Profile',
              ),
            ]),
      ),
    );
  }
}
