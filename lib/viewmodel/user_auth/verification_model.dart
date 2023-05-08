import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wmsm_flutter/view/intro_page.dart';
import 'package:wmsm_flutter/view/user_auth/pages/email_verification.dart';

class VerificationViewModel extends StatefulWidget {
  const VerificationViewModel({super.key});

  @override
  State<VerificationViewModel> createState() => _VerificationViewModelState();
}

class _VerificationViewModelState extends State<VerificationViewModel> {
  bool isEmailVerified = false;
  bool canResendEmail = false;
  Timer? timer;

  @override
  void initState() {
    super.initState();

    isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;

    if(!isEmailVerified) {
      sendVerificationEmail();

      timer = Timer.periodic(
        const Duration(seconds: 3),
        (_) => checkEmailVerified(),
      );
    }
  }

  Future checkEmailVerified() async {
    await FirebaseAuth.instance.currentUser?.reload();

    if(mounted) {
      setState(() {
        isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
      });
    }

    if(isEmailVerified) timer?.cancel();
  }

    Future sendVerificationEmail() async {
    try {
      final user = FirebaseAuth.instance.currentUser!;
      await user.sendEmailVerification();

      setState(() => canResendEmail = false);
      await Future.delayed(const Duration(seconds: 30));
      setState(() => canResendEmail = true);
    } catch (e) {
      print(e);
    }
    
  }

  @override
  Widget build(BuildContext context) => 
  isEmailVerified 
    ? const IntroPage() 
    : const EmailVerification();
}