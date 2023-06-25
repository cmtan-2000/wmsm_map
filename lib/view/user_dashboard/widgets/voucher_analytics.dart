import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class VoucherAnalytics extends StatefulWidget {
  const VoucherAnalytics({super.key});

  @override
  State<VoucherAnalytics> createState() => _VoucherAnalyticsState();
}

class _VoucherAnalyticsState extends State<VoucherAnalytics>
    with AutomaticKeepAliveClientMixin {
  _ChartData selectedData = _ChartData('', 0);
  late List<_ChartData> typeData;
  late List<_ChartData> quantityData;

  @override
  bool get wantKeepAlive => true;

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
            String type = '', name = '';
            int quantity = 0;
            typeData.clear();
            quantityData.clear();
            int foodCount = 0;
            int drinkCount = 0;
            for (int i = 0; i < snapshot.data!.docs.length; i++) {
              type = snapshot.data!.docs[i]['type'];
              name = snapshot.data!.docs[i]['name'];
              quantity = int.parse(snapshot.data!.docs[i]['quantity']);

              if (type == 'food') {
                foodCount++;
              } else {
                drinkCount++;
              }

              quantityData.add(_ChartData(name, quantity));
            }
            typeData.add(_ChartData(
                'Food', foodCount, const Color.fromARGB(255, 216, 147, 90)));
            typeData.add(_ChartData(
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
                            series: <ChartSeries<_ChartData, String>>[
                              ColumnSeries<_ChartData, String>(
                                dataSource: typeData,
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                ),
                                pointColorMapper: (_ChartData data, _) =>
                                    data.color,
                                xValueMapper: (_ChartData data, _) => data.x,
                                yValueMapper: (_ChartData data, _) => data.y,
                                dataLabelSettings:
                                    const DataLabelSettings(isVisible: true),
                                animationDuration: 0,
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),

                          //*radial bar (Voucher quantity)

                          SfCircularChart(
                            margin: EdgeInsets.zero,
                            title: ChartTitle(text: 'Voucher quantity'),
                            series: <CircularSeries>[
                              PieSeries<_ChartData, String>(
                                dataSource: quantityData,
                                enableTooltip: true,
                                xValueMapper: (_ChartData data, _) => data.x,
                                yValueMapper: (_ChartData data, _) => data.y,
                                dataLabelSettings:
                                    const DataLabelSettings(isVisible: true),
                                name: 'Voucher quantity',
                              )
                            ],
                            legend: Legend(
                                height: '100%',
                                position: LegendPosition.bottom,
                                isVisible: true,
                                overflowMode: LegendItemOverflowMode.wrap),
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

class _ChartData {
  _ChartData(this.x, this.y, [this.color]);

  final String x;
  final int y;
  Color? color;

  //create constructor of chart data
}
