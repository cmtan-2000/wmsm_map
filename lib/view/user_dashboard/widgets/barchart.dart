import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wmsm_flutter/view/user_dashboard/widgets/monthly_barchart.dart';
import 'package:wmsm_flutter/view/user_dashboard/widgets/weekly_barchart.dart';
import 'package:wmsm_flutter/viewmodel/health_conn_view/health_conn_view_model.dart';

class BarChart extends StatefulWidget {
  const BarChart({super.key});

  @override
  State<BarChart> createState() => _BarChartState();
}

class _BarChartState extends State<BarChart> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HealthConnViewModel>(
      builder: (context, health, child) => health.authorize
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TabBar(
                    indicator: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Theme.of(context).primaryColor),
                    controller: _tabController,
                    labelColor: Colors.white,
                    unselectedLabelColor: Colors.grey[600],
                    isScrollable: true,
                    indicatorSize: TabBarIndicatorSize.tab,
                    tabs: const [Tab(text: 'Weekly'), Tab(text: 'Monthly')],
                  ),
                ),
                SizedBox(
                  width: double.maxFinite,
                  height: MediaQuery.of(context).size.height * 0.48,
                  child:
                      TabBarView(controller: _tabController, children: const [
                    WeeklyBarChart(),
                    MonthlyBarChart(),
                  ]),
                ),
              ],
            )
          : Card(
              elevation: 2,
              color: Theme.of(context).primaryColor,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8.0, 20.0, 8.0, 20.0),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: Column(
                    children: [
                      SizedBox(
                        width: 147,
                        child: Image.asset(
                          'assets/images/error_not.png',
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                        // ignore: prefer_const_constructors
                      ),
                      const Text(
                        'Not connected to Google Fit',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
