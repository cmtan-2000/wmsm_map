import 'package:flutter/material.dart';
import 'package:wmsm_flutter/view/user_auth/widgets/signup_form1_widget.dart';

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
      //*to avoid content push upward when soft keyboard appears
      resizeToAvoidBottomInset: false,
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
        children: const [SignUpForm1Widget()],
      ),
    );
  }
}
