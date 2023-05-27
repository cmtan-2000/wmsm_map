import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wmsm_flutter/viewmodel/health_conn_view/health_conn_view_model.dart';

class HeahthPage extends StatefulWidget {
  const HeahthPage({super.key});

  @override
  State<HeahthPage> createState() => _HeahthPageState();
}

class _HeahthPageState extends State<HeahthPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<HealthConnViewModel>(
      builder: (context, viewModel, child) => Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                viewModel.message,
                style: const TextStyle(fontSize: 24),
              ),
              ElevatedButton(
                onPressed: () {
                  viewModel.updateMessage("New message");
                },
                child: const Text('Update Message'),
              ),
              Text(
                viewModel.authorize.toString(),
                style: const TextStyle(fontSize: 24),
              ),
              ElevatedButton(
                onPressed: () {
                  viewModel.getAuthorize();
                },
                child: const Text('Authorization'),
              ),
              Text(
                ' Step user: ${viewModel.step['step'].toString()}',
                style: const TextStyle(fontSize: 24),
              ),
              ElevatedButton(
                onPressed: () {
                  viewModel.getSteps();
                },
                child: const Text('Authorization'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
