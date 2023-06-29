import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:wmsm_flutter/model/chart.dart';

class VoucherAnalytics extends StatefulWidget {
  const VoucherAnalytics({super.key});

  @override
  State<VoucherAnalytics> createState() => _VoucherAnalyticsState();
}

class _VoucherAnalyticsState extends State<VoucherAnalytics> {
  late List<ChartData> typeData;
  late List<ChartData> quantityData;

  @override
  void initState() {
    // Initialize the voucher data
    typeData = [];
    quantityData = [];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection('vouchers').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            String type = '', name = '', stringTotalPrice = '';
            int quantity = 0, foodCount = 0, drinkCount = 0;
            typeData.clear();
            quantityData.clear();
            double totalVoucherPrice = 0;
            stringTotalPrice = totalVoucherPrice.toStringAsFixed(2);
            for (int i = 0; i < snapshot.data!.docs.length; i++) {
              type = snapshot.data!.docs[i]['type'];
              name = snapshot.data!.docs[i]['name'];
              quantity = snapshot.data!.docs[i]['quantity'];
              totalVoucherPrice +=
                  double.parse(snapshot.data!.docs[i]['price']) *
                      snapshot.data!.docs[i]['quantity'];
              stringTotalPrice = totalVoucherPrice.toStringAsFixed(2);

              if (type == 'food') {
                foodCount++;
              } else {
                drinkCount++;
              }

              quantityData.add(ChartData(name, quantity));
            }
            typeData.add(ChartData(
                'Food', foodCount, const Color.fromARGB(255, 216, 147, 90)));
            typeData.add(ChartData(
                'Drink', drinkCount, const Color.fromARGB(255, 170, 110, 170)));

            return SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: Card(
                  elevation: 2,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 30),
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
                          Text(
                            'Total voucher added: ${snapshot.data!.docs.length}',
                            style: const TextStyle(fontSize: 15),
                          ),
                          const SizedBox(height: 20),

                          //*bar chart (Voucher type count)
                          SfCartesianChart(
                            primaryXAxis: CategoryAxis(
                              majorGridLines: const MajorGridLines(width: 0),
                            ),
                            legend: Legend(isVisible: false),
                            tooltipBehavior: TooltipBehavior(
                                enable: true, animationDuration: 1, header: ''),
                            series: <ChartSeries<ChartData, String>>[
                              ColumnSeries<ChartData, String>(
                                dataSource: typeData,
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                ),
                                pointColorMapper: (ChartData data, _) =>
                                    data.color,
                                xValueMapper: (ChartData data, _) => data.x,
                                yValueMapper: (ChartData data, _) => data.y,
                                dataLabelSettings:
                                    const DataLabelSettings(isVisible: true),
                                animationDuration: 0,
                              ),
                            ],
                          ),
                          const SizedBox(height: 30),

                          //*radial bar (Voucher quantity)
                          Text(
                            'Total voucher prices: RM$stringTotalPrice',
                            style: const TextStyle(fontSize: 15),
                          ),
                          VoucherQuantityGraph(
                            quantityData: quantityData,
                          ),

                          const SizedBox(height: 20),
                        ]),
                  )),
            );
          } else {
            return const CircularProgressIndicator();
          }
        });
  }
}

class VoucherQuantityGraph extends StatelessWidget {
  const VoucherQuantityGraph({super.key, required this.quantityData});

  final List<ChartData> quantityData;

  @override
  Widget build(BuildContext context) {
    return SfCircularChart(
      tooltipBehavior: TooltipBehavior(enable: true),
      margin: EdgeInsets.zero,
      series: <CircularSeries>[
        PieSeries<ChartData, String>(
          dataSource: quantityData,
          enableTooltip: true,
          xValueMapper: (ChartData data, _) => data.x,
          yValueMapper: (ChartData data, _) => data.y,
          dataLabelSettings: const DataLabelSettings(isVisible: true),
          name: 'Voucher Name per Voucher price',
        )
      ],
      legend: Legend(
          height: '100%',
          position: LegendPosition.bottom,
          isVisible: true,
          overflowMode: LegendItemOverflowMode.wrap),
    );
  }
}
