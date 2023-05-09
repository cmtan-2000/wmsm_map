import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wmsm_flutter/main.dart';
import 'package:wmsm_flutter/view/custom/widgets/custom_button.dart';
import 'package:wmsm_flutter/view/custom/widgets/custom_elevatedbutton.dart';
import 'package:wmsm_flutter/view/user_auth/signup_form.dart';
import '../shared/email_field.dart';
import '../shared/password_field.dart';

class WidgetSignIn extends StatefulWidget {
  const WidgetSignIn({super.key});

  @override
  State<WidgetSignIn> createState() => _WidgetSignInState();
}

class _WidgetSignInState extends State<WidgetSignIn> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  snackBar(String? message) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message!),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Email Address',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(
            height: 10,
          ),
          EmailField(
            emailController: _emailController,
            textInputAction: TextInputAction.next,
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            'Password',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(
            height: 10,
          ),
          passwordField(
            passwordController: _passwordController,
            textInputAction: TextInputAction.done,
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              CustomTextButton(
                context: context,
                text: "Reset Password",
                onPressed: () {
                  MyApp.navigatorKey.currentState!.pushNamed('/resetpwd');
                },
                textStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: CustomElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      signIn();
                    }
                  },
                  child: const Text('Login'),
                ),
              ),
            ],
          ),
          const Center(child: WidgetSignUp()),
        ],
      ),
    );
  }

  Future signIn() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );

    //wrong email message popup
    void wrongEmailMessage() {
      snackBar("Incorrect Email");
      MyApp.navigatorKey.currentState!.pushNamed('/');
    }

    //wrong password message popup
    void wrongPasswordMessage() {
      snackBar("Incorrect Password");
      MyApp.navigatorKey.currentState!.pushNamed('/');
    }

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
    } on FirebaseAuthException catch (e) {
      //WRONG EMAIL
      if (e.code == 'user-not-found') {
        //show error to user
        wrongEmailMessage();
      } else if (e.code == 'wrong-password') {
        //show error to user
        wrongPasswordMessage();
      }
    }

    MyApp.navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }
}
