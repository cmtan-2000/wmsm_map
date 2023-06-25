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
    //TODO: get data from challengers firebase
    data = [
      _ChartData('David', 25),
      _ChartData('Steve', 38),
      _ChartData('Jack', 34),
      _ChartData('Others', 52)
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.8,
      child: Card(
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
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
                const Text(
                  'Total challenge added: 5',
                  style: TextStyle(fontSize: 15),
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
                        name: 'Compare_challenges')
                  ],
                ),
              ]),
        ),
      ),
    );
  }
}

class _ChartData {
  _ChartData(this.x, this.y);

  final String x;
  final double y;
}
