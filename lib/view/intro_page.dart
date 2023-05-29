// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:wmsm_flutter/view/custom/widgets/custom_elevatedbutton.dart';
import 'package:wmsm_flutter/view/custom/widgets/custom_outlinedbutton.dart';
import 'package:wmsm_flutter/viewmodel/health_conn_view/health_conn_view_model.dart';
import 'package:wmsm_flutter/viewmodel/user_view_model.dart';

import 'custom/themes/custom_theme.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({super.key});

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
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 350,
                    // color: Colors.orange,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Step up to the challenge!',
                            style: Theme.of(context).textTheme.displayMedium,
                          ),
                          SizedBox(
                            width: 300,
                            child: Text(
                              "Walk your way to a healthier life and earn rewards along the way.",
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ]),
                  ),
                  const SizedBox(
                    height: 30,
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
                      child: const ContentClass(),
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

class ContentClass extends StatelessWidget {
  const ContentClass({super.key});

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    const double widthGoal = 150;

    return SizedBox(
      width: 300,
      // color: Colors.grey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Wrap(
            children: [
              const Text("Here's how:"),
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                  height: 200,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 300,
                        child: Row(
                          children: <Widget>[
                            Image(
                              image: AssetImage('assets/images/footprint.png'),
                              width: 47,
                              height: 47,
                            ),
                            const SizedBox(
                              width: 30,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Set your Goal',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  width: widthGoal,
                                  child: Text(
                                    "Choose a level that's right for you",
                                    textAlign: TextAlign.justify,
                                    style:
                                        TextStyle(fontSize: deviceWidth / 35),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 300,
                        child: Row(
                          children: <Widget>[
                            Icon(Icons.smartphone_outlined, size: 47),
                            // Image(
                            //   image: AssetImage(
                            //       'assets/images/icon _smartphone_device.png'),
                            //   width: 47,
                            //   height: 47,
                            // ),
                            const SizedBox(
                              width: 30,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Track your steps',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                SizedBox(
                                  width: widthGoal,
                                  child: Text(
                                    "Check yout step count daily",
                                    textAlign: TextAlign.justify,
                                    style:
                                        TextStyle(fontSize: deviceWidth / 35),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 300,
                        // color: Colors.amber,
                        child: Row(
                          children: <Widget>[
                            Icon(Icons.shopping_cart_rounded, size: 47),
                            // Image(
                            //   image: AssetImage('assets/images/icon _cart.png'),
                            //   width: 47,
                            //   height: 47,
                            // ),
                            const SizedBox(
                              width: 30,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Redeem rewards',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                SizedBox(
                                  width: widthGoal,
                                  child: Text(
                                      "Stay motivated with these irresistible rewards",
                                      textAlign: TextAlign.justify,
                                      style: TextStyle(
                                        fontSize: deviceWidth / 35,
                                      )),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ))
            ],
          ),
          SizedBox(
            height: 100,
            child: Wrap(
              children: [
                Row(
                  children: [
                    Expanded(child:
                        LayoutBuilder(builder: (BuildContext, BoxConstraints) {
                      if (BoxConstraints.minWidth < Config.minWidth + 30) {
                        // return CustomElevatedButton(
                        //     onPressed: () {
                        //       Logger().i("Check here");
                        //       // =>
                        //       //   Navigator.of(context).pushNamed('/btmNav'),
                        //     },
                        //     child: Text(
                        //       'CONNECT YOUR TRACKER TO START',
                        //       style: TextStyle(fontSize: 12),
                        //     ));
                        return Consumer<HealthConnViewModel>(
                          builder: (context, viewModel, child) =>
                              CustomElevatedButton(
                            onPressed: () async {
                              var data = await viewModel.getAuthorize();

                              if (data) {
                                Provider.of<UserViewModel>(context,
                                        listen: false)
                                    .setUser();
                                Navigator.of(context).pushNamed('/btmNav');
                              } else {}
                            },
                            child: Text(
                              'Connect Your Tracker to START: ${viewModel.authorize}',
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                        );
                      } else {
                        return CustomElevatedButton(
                            onPressed: () =>
                                Navigator.of(context).pushNamed('/btmNav'),
                            child: Text('CONNECT YOUR TRACKER TO START'));
                      }

                      //   CustomElevatedButton(
                      //       onPressed: () =>
                      //           Navigator.of(context).pushNamed('/btmNav'),
                      //       child: Text('CONNECT YOUR TRACKER TO START')),
                      // ),
                    }))
                  ],
                ),
                const SizedBox(
                  height: 40,
                ),
                Row(
                  children: [
                    Expanded(
                      child: CustomOutlinedButton(
                        onPressed: () => SnackBar(content: Text('SKIP')),
                        iconData: null,
                        text: 'SKIP',
                        disabled: false,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
