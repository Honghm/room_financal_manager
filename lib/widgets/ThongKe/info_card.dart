
import 'package:flutter/material.dart';
import 'package:room_financal_manager/models/KhoanChiCaNhan.dart';
import 'package:room_financal_manager/widgets/ThongKe/line_chart.dart';

class InfoCard extends StatelessWidget {
  final String title;
  final String icon;
  double TongChi;
  List<double> dsTienChi;
  // double TongThu;
  // List<double> dsTienThu;
  final Function press;
   InfoCard({
    Key key,
    this.title,
    this.icon,
    this.TongChi,
     // this.TongThu,
    this.dsTienChi,
     // this.dsTienThu,
    this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return GestureDetector(
          onTap: press,
          child: Container(
            width: constraints.maxWidth / 2 - 10,
            // Here constraints.maxWidth provide us the available width for the widget
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: <Widget>[
                        // wrapped within an expanded widget to allow for small density device
                        Expanded(
                          child: Container(
                            alignment: Alignment.topLeft,
                            height: 30,
                            width: 30,
                            child: Image.network(icon)
                          ),
                        ),
                        SizedBox(width: 5),
                        Text(
                          title,
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: RichText(
                            text: TextSpan(
                              style: TextStyle(color: Colors.black),
                              children: [
                                // TextSpan(
                                //   text: "$TongThu K",
                                //   style:TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green)
                                // ),
                                TextSpan(
                                    text: "$TongChi K",
                                    style:TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: Colors.red)
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: LineReportChart(dsTienChi: dsTienChi,),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}