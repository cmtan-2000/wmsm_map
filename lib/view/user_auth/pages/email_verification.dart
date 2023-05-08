// ignore_for_file: prefer_const_constructors
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wmsm_flutter/view/custom/widgets/custom_outlinedbutton.dart';
import 'package:wmsm_flutter/viewmodel/user_auth/verification_model.dart';
import 'package:wmsm_flutter/view/user_auth/widgets/cover_content.dart';

class EmailVerification extends StatelessWidget {
  const EmailVerification({super.key});

  @override
  Widget build(BuildContext context) {
    return const CoverContent(
      content: EmailVerificationWidget(),
      title: 'Email Verification',
    );
  }
}

class EmailVerificationWidget extends StatefulWidget {
  const EmailVerificationWidget({super.key});

  @override
  State<EmailVerificationWidget> createState() => _EmailVerificationState();
}

class _EmailVerificationState extends State<EmailVerificationWidget> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'A verification email has been sent to the mailbox of ${FirebaseAuth.instance.currentUser!.email}',
            textAlign: TextAlign.justify,
          ),
          const SizedBox(
            height: 40,
          ),
          Row(
            children: [
              Expanded(
                child: CustomOutlinedButton(
                  iconData: null,
                  onPressed: (){
                    VerificationViewModel();
                  },
                  text: 'RESEND LINK', disabled: false,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
