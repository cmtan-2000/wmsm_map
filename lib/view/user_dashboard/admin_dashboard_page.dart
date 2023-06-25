import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:wmsm_flutter/view/user_dashboard/widgets/challenge_analytics.dart';
import 'package:wmsm_flutter/view/user_dashboard/widgets/voucher_analytics.dart';
import 'package:wmsm_flutter/viewmodel/user_view_model.dart';

class AdminDashboard extends StatelessWidget {
  AdminDashboard({super.key});
  FirebaseFirestore db = FirebaseFirestore.instance;

  Future<void> _createPDF() async {
    PdfDocument pdf = PdfDocument();
    pdf.pages.add();
    Future<List<int>> bytes = pdf.save();
    pdf.dispose();
  }

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
                    actions: [
                      IconButton(
                        icon: const Icon(LineAwesomeIcons.pdf_file_1),
                        onPressed: _createPDF,
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
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}

class GenderChart extends StatefulWidget {
  const GenderChart({super.key});

  @override
  State<GenderChart> createState() => _GenderChartState();
}

class _GenderChartState extends State<GenderChart> {
  @override
  void initState() {
    super.initState();
    final userViewModel = Provider.of<UserViewModel>(context, listen: false);
    userViewModel.fetchGenderData();
  }

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
