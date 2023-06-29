import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:wmsm_flutter/model/chart.dart';
import 'package:wmsm_flutter/view/user_dashboard/api/pdf_report.dart';
import 'package:wmsm_flutter/view/user_dashboard/widgets/challenge_analytics.dart';
import 'package:wmsm_flutter/view/user_dashboard/widgets/voucher_analytics.dart';
import 'package:wmsm_flutter/viewmodel/user_view_model.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  FirebaseFirestore db = FirebaseFirestore.instance;
  bool isLoading = true;
  String stringVPrice = '';
  double vprice = 0.0;

  late List<ChartData> voucherTypeData;
  late List<ChartData> voucherPriceData;
  late List<int> quantityForOne;
  late List<ChartData> challengeData;

  @override
  void initState() {
    super.initState();
    initialiseUser();
    voucherTypeData = [];
    voucherPriceData = [];
    quantityForOne = [];
    challengeData = [];
  }

  void initialiseUser() async {
    final userViewModel = Provider.of<UserViewModel>(context, listen: false);

    final userCount = await userViewModel.userCountMethod();
    userViewModel.fetchGenderData();

    setState(() {
      userViewModel.userCount = userCount;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserViewModel>(builder: (context, userValue, child) {
      return StreamBuilder(
        stream: FirebaseFirestore.instance.collection('vouchers').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            int drinkCount = 0, foodCount = 0, totalVoucherCount = 0;

            voucherTypeData.clear();
            voucherPriceData.clear();
            for (var doc in snapshot.data!.docs) {
              vprice = double.parse(doc.data()['price']);

              voucherPriceData.add(ChartData(doc.data()['name'], vprice));
              quantityForOne.add(doc.data()['quantity']);

              if (doc.data()['type'] == 'food') {
                foodCount++;
              } else {
                drinkCount++;
              }
            }

            totalVoucherCount = snapshot.data!.docs.length;
            voucherTypeData.add(ChartData('Food', foodCount));
            voucherTypeData.add(ChartData('Drink', drinkCount));

            return StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('challenges')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    challengeData.clear();
                    for (int i = 0; i < snapshot.data!.docs.length; i++) {
                      challengeData.add(ChartData(
                          snapshot.data!.docs[i].data()['title'],
                          snapshot.data!.docs[i].data()['challengers'].length));
                    }

                    return Scaffold(
                      body: Container(
                        color: Colors.blueGrey,
                        child: CustomScrollView(
                          slivers: [
                            SliverAppBar(
                              title: Text('Home',
                                  style: Theme.of(context).textTheme.bodyLarge),
                              automaticallyImplyLeading: false,
                              actions: [
                                IconButton(
                                  icon: const Icon(LineAwesomeIcons.pdf_file_1),
                                  onPressed: () async {
                                    await PdfReportApi.generate(
                                        userValue.genderData,
                                        voucherTypeData,
                                        totalVoucherCount,
                                        voucherPriceData,
                                        quantityForOne,
                                        challengeData);
                                  },
                                ),
                              ],
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
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Text(
                                              'Total Registered Users',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .displaySmall,
                                            ),
                                            const SizedBox(height: 20),
                                            isLoading
                                                ? const CircularProgressIndicator()
                                                : Text(
                                                    '${userValue.userCount} users',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .displayLarge,
                                                  ),
                                            const SizedBox(
                                              height: 40,
                                            ),
                                            Text(
                                              "Last updated: ${DateFormat('dd-MMM-yyyy').format(DateTime.now())}",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall,
                                            ),
                                          ]),
                                    ),
                                  ),
                                  const SizedBox(height: 40),
                                  const GenderChart(),
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
                    return const CircularProgressIndicator();
                  }
                });
          } else {
            return const CircularProgressIndicator();
          }
        },
      );
    });
  }
}

// Future<Uint8List> _readImageData(String name) async {
//   final data = await rootBundle.load('assets/images/$name');
//   return data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
// }

class GenderChart extends StatelessWidget {
  const GenderChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<UserViewModel>(builder: (context, value, child) {
      List<ChartData> genderData = value.genderData;
      return SizedBox(
        width: MediaQuery.of(context).size.width * 0.8,
        child: Card(
          elevation: 2,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  'User Gender Analytics',
                  style: Theme.of(context)
                      .textTheme
                      .displaySmall
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                SfCartesianChart(
                  primaryXAxis: CategoryAxis(
                    majorGridLines: const MajorGridLines(width: 0),
                  ),
                  legend: Legend(isVisible: false),
                  tooltipBehavior: TooltipBehavior(
                      enable: true, animationDuration: 1, header: ''),
                  series: <ChartSeries<ChartData, String>>[
                    ColumnSeries<ChartData, String>(
                      dataSource: genderData,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                      pointColorMapper: (ChartData data, _) => data.color,
                      xValueMapper: (ChartData data, _) => data.x,
                      yValueMapper: (ChartData data, _) => data.y,
                      dataLabelSettings:
                          const DataLabelSettings(isVisible: true),
                      animationDuration: 0,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
