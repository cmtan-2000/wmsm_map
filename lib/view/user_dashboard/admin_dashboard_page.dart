import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:wmsm_flutter/view/user_dashboard/widgets/challenge_analytics.dart';
import 'package:wmsm_flutter/view/user_dashboard/widgets/voucher_analytics.dart';

class AdminDashboard extends StatelessWidget {
  AdminDashboard({super.key});
  FirebaseFirestore db = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: db.collection('users').get(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          //Get the number of document in users collection
          int userCount = snapshot.data!.docs.length;
          Logger().i(userCount);

          return Scaffold(
            body: Container(
              color: Colors.blueGrey,
              child: CustomScrollView(
                slivers: [
                  SliverAppBar(
                    title: Text('Home',
                        style: Theme.of(context).textTheme.bodyLarge),
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
                                    style: Theme.of(context)
                                        .textTheme
                                        .displaySmall,
                                  ),
                                  const SizedBox(height: 20),
                                  Text(
                                    '$userCount users',
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayLarge,
                                  ),
                                  const SizedBox(
                                    height: 40,
                                  ),
                                  Text(
                                    "Last updated: ${DateFormat('dd-MMM-yyyy').format(DateTime.now())}",
                                    style:
                                        Theme.of(context).textTheme.bodySmall,
                                  ),
                                ]),
                          ),
                        ),
                        const SizedBox(height: 40),
                        const ChallengeAnalytics(),
                        const SizedBox(height: 40),
                        const VoucherAnalytics(),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
