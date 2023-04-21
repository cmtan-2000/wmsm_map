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
            onPressed: () {
              _controller.restart();
              print('Pressed resend link');
            },
            text: 'Resend (${time.toInt()})');
      },
      onFinished: () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Timer has ended. Please try register again.'),
            backgroundColor: Colors.red,
          ),
        );
      },
    );
  }
}
