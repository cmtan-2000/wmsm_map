import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/countdown.dart';
import 'package:flutter_countdown_timer/countdown_controller.dart';
import 'package:wmsm_flutter/view/custom/widgets/custom_outlinedbutton.dart';

class CustomTimer extends StatefulWidget {
  const CustomTimer({super.key});

  @override
  State<CustomTimer> createState() => _CustomTimerState();
}

class _CustomTimerState extends State<CustomTimer> {
  final int duration = 30;
  late CountdownController countdownController;

  @override
  void initState() {
    super.initState();
    countdownController = CountdownController(
      duration: Duration(seconds: duration),
      onEnd: () {
        print('Countdown Ended');
      },
    );
    countdownController.start(); //*start the timer
  }

  @override
  void dispose() {
    countdownController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Countdown(
      countdownController: countdownController,
      builder: (BuildContext context, Duration remaining) {
        return CustomOutlinedButton(
            iconData: null,
            context: context,
            onPressed: () {
              print('Pressed resend link');
            },
            text: 'Resend (${remaining.inSeconds})');
      },
    );
  }
}
