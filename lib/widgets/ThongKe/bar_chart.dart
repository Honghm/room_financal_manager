import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BarChartThongKeThang extends StatefulWidget {
  List<double> thongKeKhoanChi;
  List<double> thongKeKhoanThu;
  BarChartThongKeThang({this.thongKeKhoanThu, this.thongKeKhoanChi});
  @override
  State<StatefulWidget> createState() => BarChartThongKeThangState();
}

class BarChartThongKeThangState extends State<BarChartThongKeThang> {
  // final Color leftBarColor = Colors.green;
  // final Color rightBarColor = const Color(0xffff5182);
  // final double width = 7;

  List<BarChartGroupData> rawBarGroups;
  List<BarChartGroupData> showingBarGroups;

  int touchedGroupIndex;

  @override
  void initState() {
    super.initState();
    List<BarChartGroupData> items = [];
    for(int i = 0; i<widget.thongKeKhoanChi.length;i++){
      items.add(makeGroupData(i, widget.thongKeKhoanThu[i]/500, widget.thongKeKhoanChi[i]/500));
    }
    rawBarGroups = items;
    showingBarGroups = rawBarGroups;
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              SizedBox(height: 10,),
              Center(
                child: Text(
                  'THỐNG KÊ CHI TIÊU',
                  style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 10,),
              Center(
                child: Text(
                  'Từ ngày 21/12 - 27/12',
                  style: TextStyle(color: Colors.black54, fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                height: 38,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: BarChart(
                    BarChartData(
                      maxY: 50,
                      titlesData: FlTitlesData(
                        show: true,
                        bottomTitles: SideTitles(
                          showTitles: true,
                          getTextStyles: (value) => const TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 12),
                          margin: 10,

                          getTitles: (double value) {
                            switch (value.toInt()) {
                              case 0:
                                return 'T1';
                              case 1:
                                return 'T2';
                              case 2:
                                return 'T3';
                              case 3:
                                return 'T4';
                              case 4:
                                return 'T5';
                              case 5:
                                return 'T6';
                              case 6:
                                return 'T7';
                              case 7:
                                return 'T8';
                              case 8:
                                return 'T9';
                              case 9:
                                return 'T10';
                              case 10:
                                return 'T11';
                              case 11:
                                return 'T12';
                              default:
                                return '';
                            }
                          },
                        ),
                        leftTitles: SideTitles(
                          showTitles: true,
                          getTextStyles: (value) => const TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 12),
                          margin: 10,
                          reservedSize: 50,
                          getTitles: (value) {
                            if (value == 0) {
                              return '';
                            } else if (value == 4) {
                              return '0.5TR';
                            }  else if (value == 9) {
                              return '1TR';
                            } else if (value == 14) {
                              return '1.5TR';
                            }else if (value == 19) {
                              return '2TR';
                            }else if (value == 24) {
                              return '2.5TR';
                            }else if (value == 29) {
                              return '3TR';
                            }else if (value == 34) {
                              return '3.5TR';
                            }else if (value == 39) {
                              return '4TR';
                            } else if (value == 44) {
                              return '4.5TR';
                            } else if (value == 49) {
                              return '5TR';
                            }
                            else {
                              return '';
                            }
                          },
                        ),
                      ),
                      borderData: FlBorderData(
                        show: false,
                      ),
                      barGroups: showingBarGroups,

                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
            ],
          ),
        ),
      ),
    );
  }


  BarChartGroupData makeGroupData(int x, double y1, double y2) {
    return BarChartGroupData(barsSpace: 1, x: x,  barRods: [
      BarChartRodData(
        y: y1,
        colors: [Colors.green],
        width: 7,
      ),
      BarChartRodData(
        y: y2,
        colors: [Color(0xffff5182)],
        width: 7,
      ),

    ]);
  }

  // Widget makeTransactionsIcon() {
  //   const double width = 4.5;
  //   const double space = 3.5;
  //   return Row(
  //     mainAxisSize: MainAxisSize.min,
  //     crossAxisAlignment: CrossAxisAlignment.center,
  //     children: <Widget>[
  //       Container(
  //         width: width,
  //         height: 10,
  //         color: Colors.white.withOpacity(0.4),
  //       ),
  //       const SizedBox(
  //         width: space,
  //       ),
  //       Container(
  //         width: width,
  //         height: 28,
  //         color: Colors.white.withOpacity(0.8),
  //       ),
  //       const SizedBox(
  //         width: space,
  //       ),
  //       Container(
  //         width: width,
  //         height: 42,
  //         color: Colors.white.withOpacity(1),
  //       ),
  //       const SizedBox(
  //         width: space,
  //       ),
  //       Container(
  //         width: width,
  //         height: 28,
  //         color: Colors.white.withOpacity(0.8),
  //       ),
  //       const SizedBox(
  //         width: space,
  //       ),
  //       Container(
  //         width: width,
  //         height: 10,
  //         color: Colors.white.withOpacity(0.4),
  //       ),
  //     ],
  //   );
  // }
}