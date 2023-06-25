import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:wmsm_flutter/model/step.dart';

class VoucherAnalytics extends StatefulWidget {
  const VoucherAnalytics({super.key});

  @override
  State<VoucherAnalytics> createState() => _VoucherAnalyticsState();
}

class _VoucherAnalyticsState extends State<VoucherAnalytics> {
  List<StepData> stepData = [
    StepData('Mon', 2000),
    StepData('Tue', 3000),
    StepData('Wed', 4000),
    StepData('Thu', 5000),
    StepData('Fri', 6000),
    StepData('Sat', 7000),
    StepData('Sun', 8000),
  ];
  @override
  void initState() {
    // Initialize the voucher data
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
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    'Voucher Analytics',
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
                  const SizedBox(height: 10),
                  SfCartesianChart(
                    primaryXAxis: CategoryAxis(
                      majorGridLines: const MajorGridLines(width: 0),
                    ),
                    legend: Legend(isVisible: false),
                    tooltipBehavior: TooltipBehavior(
                        enable: true, animationDuration: 1, header: ''),
                    series: <ChartSeries<StepData, String>>[
                      ColumnSeries<StepData, String>(
                        dataSource: stepData,
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
                ]),
          )),
    );
  }
}
