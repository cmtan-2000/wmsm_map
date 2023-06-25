import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ChallengeAnalytics extends StatefulWidget {
  const ChallengeAnalytics({super.key});

  @override
  State<ChallengeAnalytics> createState() => _ChallengeAnalyticsState();
}

class _ChallengeAnalyticsState extends State<ChallengeAnalytics> {
  late List<_ChartData> data;

  @override
  void initState() {
    data = [];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('challenges').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          data.clear();
          for (int i = 0; i < snapshot.data!.docs.length; i++) {
            int userCount = snapshot.data!.docs[i]['challengers'].length;
            String title = snapshot.data!.docs[i]['title'];

            data.add(_ChartData(title, userCount));
          }

          return SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            child: Card(
              elevation: 2,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        'Challenge Analytics',
                        style: Theme.of(context)
                            .textTheme
                            .displaySmall
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        'Total challenge added: ${snapshot.data!.docs.length}',
                        style: const TextStyle(fontSize: 15),
                      ),
                      //BarChart for challenge
                      SfCircularChart(
                        tooltipBehavior:
                            TooltipBehavior(enable: true, animationDuration: 1),
                        margin: EdgeInsets.zero,
                        series: <CircularSeries>[
                          DoughnutSeries<_ChartData, String>(
                              dataSource: data,
                              xValueMapper: (_ChartData data, _) => data.x,
                              yValueMapper: (_ChartData data, _) => data.y,
                              dataLabelSettings:
                                  const DataLabelSettings(isVisible: true),
                              name: 'Total number of users enrolled')
                        ],
                        legend: Legend(
                            position: LegendPosition.bottom,
                            isVisible: true,
                            overflowMode: LegendItemOverflowMode.wrap),
                      ),
                    ]),
              ),
            ),
          );
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}

class _ChartData {
  _ChartData(this.x, this.y);

  final String x;
  final int y;
}
