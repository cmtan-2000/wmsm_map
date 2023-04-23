import 'package:flutter/material.dart';
import 'package:timer_count_down/timer_controller.dart';
import 'package:timer_count_down/timer_count_down.dart';
import 'package:wmsm_flutter/view/custom/widgets/custom_outlinedbutton.dart';

class CustomTimer extends StatefulWidget {
  const CustomTimer({super.key});

  @override
  State<CustomTimer> createState() => _CustomTimerState();
}

class _CustomTimerState extends State<CustomTimer> {
  final int duration = 30; //*set timer duration
  final CountdownController _controller = CountdownController(autoStart: true);
  bool isResend = false;
  @override
  Widget build(BuildContext context) {
    return Countdown(
      controller: _controller,
      //*duration of the timer, put 5for testing purposes
      seconds: 5,
      interval: const Duration(milliseconds: 100),
      build: (_, double time) {
        return CustomOutlinedButton(
          iconData: null,
          onPressed: isResend
              ? () {
                  _controller.restart();
                  // Todo: Perform resend OTP
                  setState(() {
                    isResend = false;
                  });
                }
              : null,
          text: 'Resend (${time.toInt()})',
          disabled: !isResend,
        );
      },
      onFinished: () {
        setState(() {
          isResend = true;
        });
      },
    );
  }
}
