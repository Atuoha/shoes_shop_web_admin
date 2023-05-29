import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../models/chart_sample.dart';


class CategoryDataPie extends StatelessWidget {
  const CategoryDataPie({
    super.key,
  });

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
        child: _buildDefaultPieChart(),
      ),
    );
  }
}

/// Returns the circular  chart with pie series.
SfCircularChart _buildDefaultPieChart() {
  return SfCircularChart(
    title: ChartTitle(text: 'Categories with Products Quantity'),
    legend: Legend(isVisible: true),
    series: _getDefaultPieSeries(),
  );
}

/// Returns the pie series.
List<PieSeries<ChartSampleData, String>> _getDefaultPieSeries() {
  return <PieSeries<ChartSampleData, String>>[
    PieSeries<ChartSampleData, String>(
      explode: true,
      explodeIndex: 0,
      explodeOffset: '10%',
      dataSource: <ChartSampleData>[
        ChartSampleData(x: 'Fila', y: 13, text: 'Fila \n 13%'),
        ChartSampleData(x: 'Adidas', y: 24, text: 'Adidas \n 24%'),
        ChartSampleData(x: 'Puma', y: 25, text: 'Puma \n 25%'),
        ChartSampleData(x: 'Nike', y: 38, text: 'Nike \n 38%'),
        ChartSampleData(x: 'Reebok', y: 28, text: 'Reebok \n 38%'),
      ],
      xValueMapper: (ChartSampleData data, _) => data.x,
      yValueMapper: (ChartSampleData data, _) => data.y,
      dataLabelMapper: (ChartSampleData data, _) => data.text,
      startAngle: 90,
      endAngle: 90,
      dataLabelSettings: const DataLabelSettings(isVisible: true),
    ),
  ];
}
