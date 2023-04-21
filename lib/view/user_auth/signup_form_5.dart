import 'package:flutter/material.dart';
import 'package:wmsm_flutter/view/user_auth/widgets/signup_form5_widget.dart';

class SignUpForm5 extends StatelessWidget {
  const SignUpForm5({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.white,
                Theme.of(context).primaryColor,
              ],
              stops: const [
                0.1,
                1.0,
              ],
              begin: FractionalOffset.topCenter,
              end: FractionalOffset.bottomCenter,
            ),
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.8,
            child: FractionallySizedBox(
              child: Column(
                children: [
                  Text(
                    'Digit Passcode',
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      // padding: const EdgeInsets.symmetric(
                      //     vertical: 55, horizontal: 30),
                      padding: const EdgeInsets.fromLTRB(30, 55, 30, 0),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(30),
                        ),
                      ),
                      child: const SignUpForm5Widget(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
