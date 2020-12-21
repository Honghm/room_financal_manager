import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class LineReportChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 2.2,
      child: LineChart(
        LineChartData(
          gridData: FlGridData(show: false),
          borderData: FlBorderData(show: false),
          titlesData: FlTitlesData(show: false),
          lineBarsData: [
            LineChartBarData(
              spots: getSports(),
              isCurved: true,
              dotData: FlDotData(show: false),
              belowBarData: BarAreaData(show: false),
              colors: [Colors.blue[400]],
              barWidth: 2,
            ),
          ],
        ),
      ),
    );
  }

  List<FlSpot> getSports() {
    return [
      FlSpot(0, 0.5),
      FlSpot(1, 7),
      FlSpot(2, 2),
      FlSpot(3, 3),
      FlSpot(4, 6),
      FlSpot(5, 0.5),
      FlSpot(6, 0),
    ];
  }
}