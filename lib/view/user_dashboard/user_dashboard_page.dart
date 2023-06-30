import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:wmsm_flutter/main.dart';
import 'package:wmsm_flutter/model/users.dart';
import 'package:wmsm_flutter/view/custom/widgets/custom_elevatedbutton.dart';
import 'package:wmsm_flutter/view/user_dashboard/widgets/barchart.dart';

class UserDashboard extends StatelessWidget {
  const UserDashboard({
    super.key,
    required this.user,
  });

  final Users user;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              title: Text('Home', style: Theme.of(context).textTheme.bodyLarge),
              automaticallyImplyLeading: false,
              actions: [
                GestureDetector(
                  onTap: () {
                    MyApp.navigatorKey.currentState!.pushNamed('/notification');
                  },
                  child: const Badge(
                    label: Text('12'),
                    isLabelVisible: true,
                    child: Icon(LineAwesomeIcons.bell),
                  ),
                ),
                const SizedBox(width: 20),
              ],
            ),
            SliverToBoxAdapter(
              child: Column(
                children: [
                  //?Welcome back card
                  Card(
                    elevation: 2,
                    color: Theme.of(context).primaryColor,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(8.0, 20.0, 8.0, 20.0),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: Column(
                          children: [
                            Text(
                              'Welcome back\n${user.fullname}!',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 20),
                            //?Step count card
                            Card(
                              elevation: 2,
                              color: Colors.white,
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(0, 20.0, 0, 20.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 15.0),
                                      child: Text('Daily Step Count:',
                                          style: Theme.of(context)
                                              .textTheme
                                              .displaySmall),
                                    ),
                                    const SizedBox(height: 20),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          width: 200,
                                          child: Column(
                                            children: const [
                                              Text('1000',
                                                  style: TextStyle(
                                                      fontSize: 60,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              Text('steps',
                                                  style: TextStyle(
                                                      fontSize: 25,
                                                      fontWeight:
                                                          FontWeight.bold))
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          width: 80,
                                          child: Image.asset(
                                            'assets/images/walk_dashboard.png',
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),

                  //?Yellow container

                  Container(
                    color: Theme.of(context).primaryColor,
                    width: double.infinity,
                    child: Column(
                      children: [
                        const SizedBox(height: 20),
                        //?Challenges card
                        DashboardCardWidget(
                          title: 'Challenges',
                          imgPath: 'assets/images/challenge.png',
                          infoCard: 'Get rewarded by joining challenge!',
                          onPressed: () {
                            MyApp.navigatorKey.currentState!
                                .pushNamed('/challengePage');
                          },
                        ),
                        const SizedBox(height: 20),
                        DashboardCardWidget(
                          title: 'Health Article',
                          imgPath: 'assets/images/newspaper.png',
                          infoCard: 'Health article is out now!',
                          onPressed: () {
                            MyApp.navigatorKey.currentState!
                                .pushNamed('/articlePage');
                          },
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: const BarChart(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DashboardCardWidget extends StatelessWidget {
  const DashboardCardWidget({
    super.key,
    required this.imgPath,
    required this.title,
    required this.infoCard,
    required this.onPressed,
  });

  final String imgPath;
  final String title;
  final String infoCard;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: Theme.of(context)
                .textTheme
                .bodyLarge
                ?.copyWith(fontWeight: FontWeight.bold)),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.8,
          child: Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      imgPath,
                      width: MediaQuery.of(context).size.width * 0.2,
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Wrap(
                            children: [
                              Text(
                                infoCard,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          CustomElevatedButton(
                            //?Navigate to the challenge page / article page
                            onPressed: onPressed,
                            child: const Text('Join'),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              )),
        ),
      ],
    );
  }
}
