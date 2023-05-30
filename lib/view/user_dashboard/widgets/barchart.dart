import 'package:flutter/material.dart';
import 'package:wmsm_flutter/view/user_dashboard/widgets/monthly_barchart.dart';
import 'package:wmsm_flutter/view/user_dashboard/widgets/weekly_barchart.dart';

//TODO: need to implement with change notifier?
//TODO: KAJI HOW TO DO THIS

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
    return Column(
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
          child: TabBarView(controller: _tabController, children: const [
            WeeklyBarChart(),
            MonthlyBarChart(),
          ]),
        ),
      ],
    );
  }
}
