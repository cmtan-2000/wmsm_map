// ignore_for_file: non_constant_identifier_names, camel_case_types, avoid_print, prefer_const_constructors, unnecessary_null_comparison

/*
consist of:
  sign-in.dart
  sign-up.dart
  forget-password.dart.
*/

import 'package:flutter/material.dart';
import 'package:wmsm_flutter/view/user_auth/signin_form.dart';
import 'package:wmsm_flutter/view/user_auth/widgets/cover_content.dart';

import '../custom/themes/custom_theme.dart';
import '../custom/widgets/custom_outlinedbutton.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(children: [
        Expanded(
          child: Container(
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 50,
                ),
                Container(
                    margin: const EdgeInsets.all(16),
                    width: 100,
                    height: 100,
                    child: Image.asset('assets/images/etiqa.png', width: 99)),
                Expanded(child: SingleChildScrollView(
                    child: LayoutBuilder(builder: (context, constraints) {
                  return SizedBox(
                    height: MediaQuery.of(context).size.height * 0.9,
                    child: Column(
                      children: [
                        Text(
                          'Sign In',
                          style: Theme.of(context).textTheme.displayMedium,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Expanded(
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 16),
                            width: MediaQuery.of(context).size.width,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(30),
                              ),
                            ),
                            padding: const EdgeInsets.fromLTRB(30, 55, 30, 0),
                            child: ContentClass(),
                          ),
                        )
                      ],
                    ),
                  );
                }))),
              ],
            ),
          ),
        )
      ]),
    );
  }
}

class ContentClass extends StatelessWidget {
  const ContentClass({
    super.key,
  });

  @override
  Widget build(BuildContext context) => Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const <Widget>[
            WidgetSignIn(),
            WidgetBottom(),
          ]));
}

// Positioned(
//   left: 0,
//   right: 0,
//   bottom: 0,
//   child: SizedBox(
//     height: MediaQuery.of(context).size.height * 0.7,
//     child: FractionallySizedBox(
//       child: Column(
//         children: [
//           Expanded(
//             child: Container(
//               width: MediaQuery.of(context).size.width * 0.9,
//               // padding: const EdgeInsets.symmetric(
//               //     vertical: 55, horizontal: 30),
//               padding: EdgeInsets.fromLTRB(30, 55, 30, 0),
//               decoration: const BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.vertical(
//                   top: Radius.circular(30),
//                 ),
//               ),
//               child: const ContentClass(),
//             ),
//           ),
//         ],
//       ),
//     ),
//   ),
// ),
// Positioned(
//     top: MediaQuery.of(context).size.height * 0.15,
//     left: MediaQuery.of(context).size.height * 0.05,
//     child: Image.asset('assets/images/etiqa.png', width: 99)),) ),

class WidgetBottom extends StatelessWidget {
  const WidgetBottom({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth > Config.minWidth) {
              return Row(
                children: [
                  Expanded(
                    child: CustomOutlinedButton(
                      onPressed: () => print('Outline_1'),
                      iconData: null,
                      text: 'Outline_1',
                      disabled: false,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: CustomOutlinedButton(
                      onPressed: () => print('Outline_2'),
                      iconData: Icons.car_crash_rounded,
                      text: 'Outline_2',
                      disabled: false,
                    ),
                  ),
                ],
              );
            } else {
              return Center(
                child: Column(
                  children: [
                    CustomOutlinedButton(
                      onPressed: () => print('Outline_1'),
                      iconData: null,
                      text: 'Outline_1',
                      disabled: false,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomOutlinedButton(
                      onPressed: () => print('Outline_2'),
                      iconData: Icons.car_crash_rounded,
                      text: 'Outline_2',
                      disabled: false,
                    ),
                  ],
                ),
              );
            }
          },
        ),
        const SizedBox(
          height: 5,
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 25.0),
          child: Text('Version 5.3.7 +766'),
        )
      ],
    );
  }
}
