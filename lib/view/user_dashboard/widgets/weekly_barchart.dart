import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../model/step.dart';
import '../../../viewmodel/health_conn_view/health_conn_view_model.dart';

class WeeklyBarChart extends StatefulWidget {
  const WeeklyBarChart({super.key});

  @override
  State<WeeklyBarChart> createState() => _WeeklyBarChartState();
}

class _WeeklyBarChartState extends State<WeeklyBarChart> {
  List<StepData> stepData = [];

  @override
  void initState() {
    super.initState();
    Provider.of<HealthConnViewModel>(context, listen: false).getWeeklyStep();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HealthConnViewModel>(
      builder: (context, health, child) => health.weeklyStep.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : Scaffold(
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Text('Your Weekly Steps',
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(fontWeight: FontWeight.bold)),
                  const SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 0),
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
                        series: <ChartSeries<StepData, String>>[
                          ColumnSeries<StepData, String>(
                            dataSource: health.weeklyStep,
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(5),
                              topRight: Radius.circular(5),
                            ),
                            xValueMapper: (StepData data, _) => data.x,
                            yValueMapper: (StepData data, _) => data.y,
                            dataLabelSettings:
                                const DataLabelSettings(isVisible: true),
                            animationDuration: 0,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
