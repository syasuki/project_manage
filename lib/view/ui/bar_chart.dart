import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class BarChartSample4 extends StatefulWidget {
  const BarChartSample4({super.key});

  @override
  State<StatefulWidget> createState() => BarChartSample4State();
}

class BarChartSample4State extends State<BarChartSample4> {
  final Color dark = const Color(0xff3b8c75);
  final Color normal = const Color(0xff64caad);
  final Color light = const Color(0xff73e8c9);

  Widget bottomTitles(double value, TitleMeta meta) {
    const style = TextStyle(color: Colors.black, fontSize: 10,fontWeight: FontWeight.bold);
    String text;
    switch (value.toInt()) {
      case 0:
        text = 'Apr';
        break;
      case 1:
        text = 'May';
        break;
      case 2:
        text = 'Jun';
        break;
      case 3:
        text = 'Jul';
        break;
      case 4:
        text = 'Aug';
        break;
      default:
        text = '';
        break;
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: Text(text, style: style),
    );
  }

  Widget leftTitles(double value, TitleMeta meta) {
    if (value == meta.max) {
      return Container();
    }
    const style = TextStyle(
      color: Colors.black,
      fontSize: 10,
      fontWeight: FontWeight.bold
    );
    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: Text(
        meta.formattedValue,
        style: style,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.66,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        color: Colors.grey[200],
        child: Padding(
          padding: const EdgeInsets.only(top: 16),
          child: BarChart(
            BarChartData(
              alignment: BarChartAlignment.start,
              barTouchData: BarTouchData(
                enabled: true,
              ),
              titlesData: FlTitlesData(
                show: true,
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 28,
                    getTitlesWidget: bottomTitles,
                  ),
                ),
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 40,
                    getTitlesWidget: leftTitles,
                  ),
                ),
                topTitles: AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                rightTitles: AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
              ),
              gridData: FlGridData(
                show: true,
                checkToShowHorizontalLine: (value) => value % 10 == 0,
                getDrawingHorizontalLine: (value) => FlLine(
                  color: Colors.black,
                  strokeWidth: 1,
                ),
                drawVerticalLine: false,
              ),
              borderData: FlBorderData(
                show: false,
                border:Border.all(
                  color: Colors.red,
                )
              ),
              groupsSpace: 4,
              barGroups: getData(),
            ),
          ),
        ),
      ),
    );
  }

  List<BarChartGroupData> getData() {
    return [
      BarChartGroupData(
        x: 0,
        barsSpace: 1,
        barRods: [
          BarChartRodData(
            toY: 17,
            rodStackItems: [
              BarChartRodStackItem(0, 2, dark),
              BarChartRodStackItem(2, 12, normal),
              BarChartRodStackItem(12, 17, light),
            ],
            borderRadius: BorderRadius.circular(50)
          ),
          BarChartRodData(
            toY: 24,
            rodStackItems: [
              BarChartRodStackItem(0, 13, dark),
              BarChartRodStackItem(13, 14, normal),
              BarChartRodStackItem(14, 24, light),
            ],
              borderRadius: BorderRadius.circular(50)
          ),
          BarChartRodData(
            toY: 23,
            rodStackItems: [
              BarChartRodStackItem(0, 6, dark),
              BarChartRodStackItem(6, 18, normal),
              BarChartRodStackItem(18, 23, light),
            ],
              borderRadius: BorderRadius.circular(50)
          ),
          BarChartRodData(
            toY: 29,
            rodStackItems: [
              BarChartRodStackItem(0, 9, dark),
              BarChartRodStackItem(9, 15, normal),
              BarChartRodStackItem(15, 29, light),
            ],
              borderRadius: BorderRadius.circular(50)
          ),
          BarChartRodData(
            toY: 32,
            rodStackItems: [
              BarChartRodStackItem(0, 2, dark),
              BarChartRodStackItem(2, 17, normal),
              BarChartRodStackItem(17, 32, light),
            ],
              borderRadius: BorderRadius.circular(50)
          ),
          BarChartRodData(
              toY: 17,
              rodStackItems: [
                BarChartRodStackItem(0, 2, dark),
                BarChartRodStackItem(2, 12, normal),
                BarChartRodStackItem(12, 17, light),
              ],
              borderRadius: BorderRadius.circular(50)
          ),
          BarChartRodData(
              toY: 24,
              rodStackItems: [
                BarChartRodStackItem(0, 13, dark),
                BarChartRodStackItem(13, 14, normal),
                BarChartRodStackItem(14, 24, light),
              ],
              borderRadius: BorderRadius.circular(50)
          ),
          BarChartRodData(
              toY: 23,
              rodStackItems: [
                BarChartRodStackItem(0, 6, dark),
                BarChartRodStackItem(6, 18, normal),
                BarChartRodStackItem(18, 23, light),
              ],
              borderRadius: BorderRadius.circular(50)
          ),
          BarChartRodData(
              toY: 29,
              rodStackItems: [
                BarChartRodStackItem(0, 9, dark),
                BarChartRodStackItem(9, 15, normal),
                BarChartRodStackItem(15, 29, light),
              ],
              borderRadius: BorderRadius.circular(50)
          ),
          BarChartRodData(
              toY: 32,
              rodStackItems: [
                BarChartRodStackItem(0, 2, dark),
                BarChartRodStackItem(2, 17, normal),
                BarChartRodStackItem(17, 32, light),
              ],
              borderRadius: BorderRadius.circular(50)
          ),
          BarChartRodData(
              toY: 17,
              rodStackItems: [
                BarChartRodStackItem(0, 2, dark),
                BarChartRodStackItem(2, 12, normal),
                BarChartRodStackItem(12, 17, light),
              ],
              borderRadius: BorderRadius.circular(50)
          ),
          BarChartRodData(
              toY: 24,
              rodStackItems: [
                BarChartRodStackItem(0, 13, dark),
                BarChartRodStackItem(13, 14, normal),
                BarChartRodStackItem(14, 24, light),
              ],
              borderRadius: BorderRadius.circular(50)
          ),
          BarChartRodData(
              toY: 23,
              rodStackItems: [
                BarChartRodStackItem(0, 6, dark),
                BarChartRodStackItem(6, 18, normal),
                BarChartRodStackItem(18, 23, light),
              ],
              borderRadius: BorderRadius.circular(50)
          ),
          BarChartRodData(
              toY: 29,
              rodStackItems: [
                BarChartRodStackItem(0, 9, dark),
                BarChartRodStackItem(9, 15, normal),
                BarChartRodStackItem(15, 29, light),
              ],
              borderRadius: BorderRadius.circular(50)
          ),
          BarChartRodData(
              toY: 32,
              rodStackItems: [
                BarChartRodStackItem(0, 2, dark),
                BarChartRodStackItem(2, 17, normal),
                BarChartRodStackItem(17, 32, light),
              ],
              borderRadius: BorderRadius.circular(50)
          ),
          BarChartRodData(
              toY: 17,
              rodStackItems: [
                BarChartRodStackItem(0, 2, dark),
                BarChartRodStackItem(2, 12, normal),
                BarChartRodStackItem(12, 17, light),
              ],
              borderRadius: BorderRadius.circular(50)
          ),
          BarChartRodData(
              toY: 24,
              rodStackItems: [
                BarChartRodStackItem(0, 13, dark),
                BarChartRodStackItem(13, 14, normal),
                BarChartRodStackItem(14, 24, light),
              ],
              borderRadius: BorderRadius.circular(50)
          ),
          BarChartRodData(
              toY: 23,
              rodStackItems: [
                BarChartRodStackItem(0, 6, dark),
                BarChartRodStackItem(6, 18, normal),
                BarChartRodStackItem(18, 23, light),
              ],
              borderRadius: BorderRadius.circular(50)
          ),
          BarChartRodData(
              toY: 29,
              rodStackItems: [
                BarChartRodStackItem(0, 9, dark),
                BarChartRodStackItem(9, 15, normal),
                BarChartRodStackItem(15, 29, light),
              ],
              borderRadius: BorderRadius.circular(50)
          ),
          BarChartRodData(
              toY: 32,
              rodStackItems: [
                BarChartRodStackItem(0, 2, dark),
                BarChartRodStackItem(2, 17, normal),
                BarChartRodStackItem(17, 32, light),
              ],
              borderRadius: BorderRadius.circular(50)
          ),
          BarChartRodData(
              toY: 17,
              rodStackItems: [
                BarChartRodStackItem(0, 2, dark),
                BarChartRodStackItem(2, 12, normal),
                BarChartRodStackItem(12, 17, light),
              ],
              borderRadius: BorderRadius.circular(50)
          ),
          BarChartRodData(
              toY: 24,
              rodStackItems: [
                BarChartRodStackItem(0, 13, dark),
                BarChartRodStackItem(13, 14, normal),
                BarChartRodStackItem(14, 24, light),
              ],
              borderRadius: BorderRadius.circular(50)
          ),
          BarChartRodData(
              toY: 23,
              rodStackItems: [
                BarChartRodStackItem(0, 6, dark),
                BarChartRodStackItem(6, 18, normal),
                BarChartRodStackItem(18, 23, light),
              ],
              borderRadius: BorderRadius.circular(50)
          ),
          BarChartRodData(
              toY: 29,
              rodStackItems: [
                BarChartRodStackItem(0, 9, dark),
                BarChartRodStackItem(9, 15, normal),
                BarChartRodStackItem(15, 29, light),
              ],
              borderRadius: BorderRadius.circular(50)
          ),
          BarChartRodData(
              toY: 32,
              rodStackItems: [
                BarChartRodStackItem(0, 2, dark),
                BarChartRodStackItem(2, 17, normal),
                BarChartRodStackItem(17, 32, light),
              ],
              borderRadius: BorderRadius.circular(50)
          ),
          BarChartRodData(
              toY: 17,
              rodStackItems: [
                BarChartRodStackItem(0, 2, dark),
                BarChartRodStackItem(2, 12, normal),
                BarChartRodStackItem(12, 17, light),
              ],
              borderRadius: BorderRadius.circular(50)
          ),
          BarChartRodData(
              toY: 24,
              rodStackItems: [
                BarChartRodStackItem(0, 13, dark),
                BarChartRodStackItem(13, 14, normal),
                BarChartRodStackItem(14, 24, light),
              ],
              borderRadius: BorderRadius.circular(50)
          ),
          BarChartRodData(
              toY: 23,
              rodStackItems: [
                BarChartRodStackItem(0, 6, dark),
                BarChartRodStackItem(6, 18, normal),
                BarChartRodStackItem(18, 23, light),
              ],
              borderRadius: BorderRadius.circular(50)
          ),
          BarChartRodData(
              toY: 29,
              rodStackItems: [
                BarChartRodStackItem(0, 9, dark),
                BarChartRodStackItem(9, 15, normal),
                BarChartRodStackItem(15, 29, light),
              ],
              borderRadius: BorderRadius.circular(50)
          ),
          BarChartRodData(
              toY: 32,
              rodStackItems: [
                BarChartRodStackItem(0, 2, dark),
                BarChartRodStackItem(2, 17, normal),
                BarChartRodStackItem(17, 32, light),
              ],
              borderRadius: BorderRadius.circular(50)
          ),
          BarChartRodData(
              toY: 32,
              rodStackItems: [
                BarChartRodStackItem(0, 2, dark),
                BarChartRodStackItem(2, 17, normal),
                BarChartRodStackItem(17, 32, light),
              ],
              borderRadius: BorderRadius.circular(50)
          ),
        ],
      ),

    ];
  }
}