import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class _stepData {
  _stepData(this.x, this.y);
  final String x;
  final int y;
}

class MonthlyBarChart extends StatefulWidget {
  const MonthlyBarChart({super.key});

  @override
  State<MonthlyBarChart> createState() => _MonthlyBarChartState();
}

class _MonthlyBarChartState extends State<MonthlyBarChart> {
  late List<_stepData> stepData;

  @override
  void initState() {
    stepData = [
      _stepData(
        "Sun",
        700,
      ),
      _stepData(
        "Mon",
        300,
      ),
      _stepData(
        "Tue",
        5000,
      ),
      _stepData(
        "Wed",
        1500,
      ),
      _stepData(
        "Thurs",
        700,
      ),
      _stepData(
        "Fri",
        1500,
      ),
      _stepData(
        "Sat",
        1000,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          const SizedBox(
            height: 20,
          ),
          Text('Your Monthly Steps',
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 0),
            child: SfCartesianChart(
              palette: const [Color.fromARGB(255, 1, 125, 197)],
              primaryXAxis: CategoryAxis(
                majorGridLines: const MajorGridLines(width: 0),
              ),

              // Enable legend
              legend: Legend(isVisible: false),
              // Enable tooltip
              tooltipBehavior: TooltipBehavior(
                  enable: true, animationDuration: 1, header: ''),
              series: <ChartSeries<_stepData, String>>[
                ColumnSeries<_stepData, String>(
                  dataSource: stepData,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(5),
                    topRight: Radius.circular(5),
                  ),
                  xValueMapper: (_stepData data, _) => data.x,
                  yValueMapper: (_stepData data, _) => data.y,
                  dataLabelSettings: const DataLabelSettings(isVisible: true),
                  animationDuration: 0,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
