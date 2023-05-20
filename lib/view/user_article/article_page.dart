// This is article page
import 'package:flutter/material.dart';

import '../../model/users.dart';
import '../../viewmodel/shared/shared_pref.dart';

class ArticlePage extends StatefulWidget {
  const ArticlePage({super.key});

  @override
  State<ArticlePage> createState() => _ArticlePageState();
}

class _ArticlePageState extends State<ArticlePage> {
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
        ? const Center(child: Text('This is article page Admin')) // Admin Page
        : user.role == 'user'
            ? const Center(child: Text('This is artiucle page User'))
            : const Center(
                child: CircularProgressIndicator(),
              );
  }
}
