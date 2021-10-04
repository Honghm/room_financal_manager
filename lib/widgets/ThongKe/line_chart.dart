import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class LineReportChart extends StatelessWidget {
  // final List<double> dsTienThu;
  final List<double> dsTienChi;
  LineReportChart({
    Key key,
    // this.dsTienThu,
    this.dsTienChi
}): super(key: key);
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
              spots: getKhoanChi(),
              isCurved: true,
              dotData: FlDotData(show: false),
              belowBarData: BarAreaData(show: false),
              colors: [Colors.blue[400]],
              barWidth: 2,
            ),
            // LineChartBarData(
            //   spots: getKhoanThu(),
            //   isCurved: true,
            //   dotData: FlDotData(show: false),
            //   belowBarData: BarAreaData(show: false),
            //   colors: [Colors.red[400]],
            //   barWidth: 2,
            // ),
          ],
        ),
      ),
    );
  }

  List<FlSpot> getKhoanChi() {
    List<FlSpot> listSpot = [];
    if(dsTienChi.isNotEmpty){
      for(int i = 0;i < dsTienChi.length;i++){
        listSpot.add(FlSpot(i.toDouble(),dsTienChi[i]));
      }
    }else{
      listSpot.add(FlSpot(0,0));
    }

    return listSpot;
  }
  // List<FlSpot> getKhoanThu() {
  //   List<FlSpot> listSpot = [];
  //   if(dsTienThu.isNotEmpty){
  //     for(int i = 0;i < dsTienThu.length;i++){
  //       listSpot.add(FlSpot(i.toDouble(),dsTienThu[i]));
  //     }
  //   }else{
  //     listSpot.add(FlSpot(0,0));
  //   }
  //
  //   return listSpot;
  // }
}