import 'package:flutter/material.dart';
import 'package:shoes_shop_admin/helpers/screen_size.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../models/app_data.dart';

class AppDataGraph extends StatelessWidget {
  const AppDataGraph({
    super.key,
    required this.data,
  });

  final List<AppData> data;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      height: 400,
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: SfCartesianChart(
          primaryXAxis: CategoryAxis(),
          // Chart title
          title: ChartTitle(
            text: 'ShoesShop Analysis for app data',
          ),
          legend: Legend(isVisible: true),
          // Enable tooltip
          tooltipBehavior: TooltipBehavior(enable: true),
          series: <ChartSeries<AppData, String>>[
            LineSeries<AppData, String>(
              dataSource: data,
              xValueMapper: (AppData sales, _) => sales.title,
              yValueMapper: (AppData sales, _) => sales.number,
              name: 'Numbers',
              // Enable data label
              dataLabelSettings: const DataLabelSettings(isVisible: true),
            )
          ],
        ),
      ),
    );
  }
}
