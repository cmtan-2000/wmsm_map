// ignore_for_file: avoid_print
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wmsm_flutter/view/user_auth/auth_page.dart';

import 'verification_model.dart';

class AuthenticationViewModel extends StatelessWidget {
  const AuthenticationViewModel({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        else if (snapshot.hasError) {
          return const Center(child: Text('Something went wrong!'));
        }
        else if(snapshot.hasData) {
          return const VerificationViewModel();
        }
        else {
          return const AuthPage();
        }
      })
    );
  }
}
