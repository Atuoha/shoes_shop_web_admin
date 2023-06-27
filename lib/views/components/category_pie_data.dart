import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../models/chart_sample.dart';


class CategoryDataPie extends StatelessWidget {
  const CategoryDataPie({
    super.key,
    required this.chartSampleData,
  });

  final List<ChartSampleData> chartSampleData;

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
        child: _buildDefaultPieChart(chartSampleData),
      ),
    );
  }
}

/// Returns the circular  chart with pie series.
SfCircularChart _buildDefaultPieChart(List<ChartSampleData> chartSampleData) {
  return SfCircularChart(
    title: ChartTitle(text: 'Categories with Products Quantity'),
    legend: Legend(isVisible: true),
    series: _getDefaultPieSeries(chartSampleData),
  );
}

/// Returns the pie series.
List<PieSeries<ChartSampleData, String>> _getDefaultPieSeries(List<ChartSampleData> chartSampleData) {
  return <PieSeries<ChartSampleData, String>>[
    PieSeries<ChartSampleData, String>(
      explode: true,
      explodeIndex: 0,
      explodeOffset: '10%',
      dataSource: chartSampleData

      ,
      xValueMapper: (ChartSampleData data, _) => data.x,
      yValueMapper: (ChartSampleData data, _) => data.y,
      dataLabelMapper: (ChartSampleData data, _) => data.text,
      startAngle: 90,
      endAngle: 90,
      dataLabelSettings: const DataLabelSettings(isVisible: true),
    ),
  ];
}


