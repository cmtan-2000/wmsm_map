// ignore_for_file: prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:wmsm_flutter/view/user_auth/widgets/signup_form3_widget.dart';

final ScrollController _controller = ScrollController();

class SignUpForm3 extends StatefulWidget {
  const SignUpForm3({super.key});

  @override
  State<SignUpForm3> createState() => _SignUpForm3State();
}

class _SignUpForm3State extends State<SignUpForm3> {
  bool isExpanded = false;

  // @override
  // void dispose() {
  //   _controller.dispose();
  //   super.dispose();
  // }

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {
        //if the scrolling position reaches maxium scrolling extent, expand
        isExpanded =
            _controller.position.pixels >= _controller.position.pixels * 0.5;
      });
    });
  }

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
        //*White container
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: SizedBox(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 30.0),
                  child: Text(
                    'Personal Information'.toUpperCase(),
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
                          // padding: const EdgeInsets.symmetric(
                          //     vertical: 55, horizontal: 30),
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
        Positioned(
            top: MediaQuery.of(context).size.height * 0.15,
            left: MediaQuery.of(context).size.height * 0.05,
            child: Image.asset('assets/images/etiqa.png', width: 99)),
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
        children: const [SignUpForm3Widget()],
      ),
    );
  }
}
