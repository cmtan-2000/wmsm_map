import 'package:flutter/material.dart';

class AdminDashboard extends StatelessWidget {
  const AdminDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.blueGrey,
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              title: Text('Home', style: Theme.of(context).textTheme.bodyLarge),
              automaticallyImplyLeading: false,
            ),
            SliverToBoxAdapter(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Card(
                    elevation: 2,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 30),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text(
                              'Total Registered Users',
                              style: Theme.of(context).textTheme.displaySmall,
                            ),
                            const SizedBox(height: 20),
                            Text(
                              '10 users',
                              style: Theme.of(context).textTheme.displayLarge,
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            Text(
                              'Last updated: 30/5/2023',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ]),
                    ),
                  ),
                  const SizedBox(height: 40),
                  Card(
                    elevation: 2,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 30),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text(
                              'Ongoing Challenges',
                              style: Theme.of(context).textTheme.displaySmall,
                            ),
                            const SizedBox(height: 20),
                          ]),
                    ),
                  )
                ])),
          ],
        ),
      ),
    );
  }
}
