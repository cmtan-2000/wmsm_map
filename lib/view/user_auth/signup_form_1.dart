import 'package:flutter/material.dart';
import 'package:wmsm_flutter/view/custom/widgets/custom_elevatedbutton.dart';

import '../shared/phone_number_field.dart';

final ScrollController _controller = ScrollController();

class SignUpForm1 extends StatefulWidget {
  const SignUpForm1({super.key});

  @override
  State<SignUpForm1> createState() => _SignUpForm1State();
}

class _SignUpForm1State extends State<SignUpForm1> {
  //check animated container open 70% of screen by default
  bool isExpanded = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {
        //if the scrolling position reaches maxium scrolling extent, expand
        isExpanded =
            _controller.position.pixels >= _controller.position.maxScrollExtent;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        //*Background linear gradient
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.white,
                Theme.of(context).primaryColor,
              ],
              stops: const [
                0.2,
                1.0,
              ],
              begin: FractionalOffset.topCenter,
              end: FractionalOffset.bottomCenter,
            ),
          ),
        ),
        //*White container
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: SizedBox(
            child: Column(
              children: [
                //const StepProgressWidget(),
                Padding(
                  padding: const EdgeInsets.only(bottom: 30.0),
                  child: Text(
                    'consent form'.toUpperCase(),
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                ),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 500),
                  height: isExpanded
                      ? MediaQuery.of(context).size.height
                      : MediaQuery.of(context).size.height * 0.7,
                  child: Column(
                    children: [
                      Expanded(
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.9,
                          padding: const EdgeInsets.fromLTRB(30, 55, 30, 0),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(30),
                            ),
                          ),
                          child: const ContentClass(),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}

class ContentClass extends StatelessWidget {
  const ContentClass({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: _controller,
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const [
          WidgetSignUp(),
        ],
      ),
    );
  }
}

class WidgetSignUp extends StatefulWidget {
  const WidgetSignUp({super.key});

  @override
  State<WidgetSignUp> createState() => _WidgetSignInState();
}

class _WidgetSignInState extends State<WidgetSignUp> {
  final TextEditingController _phoneController = TextEditingController();
  bool isChecked = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const SizedBox(
          height: 10,
        ),
        Text(
          'Sign Up',
          style: Theme.of(context).textTheme.displayLarge,
        ),
        Text(
          'Signing up is easy. Just fill up the details and you are set to go',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        const SizedBox(
          height: 70,
        ),
        Container(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Phone number'.toUpperCase(),
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(
                height: 10,
              ),
              phoneNumberField(
                phoneController: _phoneController,
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                  'assets/images/sign_up.png',
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
        Row(
          children: const [
            Expanded(child: ConsentCheckBox()),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: CustomElevatedButton(
                child: Text('Request otp'.toUpperCase()),
                onPressed: () {
                  if (isChecked) {
                    print('isChecked');
                    Navigator.pushNamed(context, '/f2');
                  }
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class ConsentCheckBox extends StatefulWidget {
  const ConsentCheckBox({super.key});
  //final void Function(bool isChecked) onCheckedChanged; //callback function

  @override
  State<ConsentCheckBox> createState() => _ConsentCheckBoxState();
}

class _ConsentCheckBoxState extends State<ConsentCheckBox> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      title: Text(
        "I consent to processing of my persona data (including sensitive personal data) in accordance with Etiqa's Privacy Notice and I agree to the Terms and Conditions",
        style: Theme.of(context).textTheme.bodyLarge,
      ),
      value: isChecked,
      onChanged: (bool? value) {
        setState(() {
          isChecked = value ?? false;
          //widget.onCheckedChanged(
          //    isChecked); //*call the callback func with new value
        });
      },
      controlAffinity: ListTileControlAffinity.leading,
      activeColor: Theme.of(context).primaryColor,
    );
  }
}
