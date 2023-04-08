import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../viewmodel/user_view_model.dart';

class UserView extends StatelessWidget {
  const UserView({super.key});

  @override
  Widget build(BuildContext context) {
    final userViewModel = Provider.of<UserViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('User'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Name: ${userViewModel.name}',
              style: const TextStyle(fontSize: 20),
            ),
            Text(
              'Age: ${userViewModel.age}',
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 16),
            TextField(
              decoration: const InputDecoration(
                hintText: 'Enter your name',
              ),
              onChanged: (value) {
                userViewModel.setUser(value, userViewModel.age);
              },
            ),
            const SizedBox(height: 16),
            TextField(
              decoration: const InputDecoration(
                hintText: 'Enter your age',
              ),
              onChanged: (value) {
                userViewModel.setUser(userViewModel.name, int.parse(value));
              },
            ),
          ],
        ),
      ),
    );
  }
}
