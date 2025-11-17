import 'package:flutter/material.dart';
import 'package:super_adminPanel/Resources/Colors.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class NumberTypesWidget extends StatelessWidget {
  const NumberTypesWidget({super.key});

  double scale(BuildContext context, double size) {
    final w = MediaQuery.of(context).size.width;
    if (w < 500) return size * 0.8;
    if (w < 900) return size * 0.9;
    return size;
  }

  @override
  Widget build(BuildContext context) {
    final List<SalesData> chartData = [
      SalesData('Business', 350),
      SalesData('Personal', 250),
    ];

    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isMobile = constraints.maxWidth < 600;

          return Center(
            child: Container(
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),

              height: isMobile ? 280 : 330,

              child: SfCartesianChart(
                isTransposed: true,

                title: ChartTitle(
                  text: 'Number Type',
                  alignment: ChartAlignment.near,
                  textStyle: TextStyle(
                    fontSize: scale(context, 16),
                    fontWeight: FontWeight.w900,
                    color: Colors.black,
                  ),
                ),

                primaryXAxis: CategoryAxis(
                  title: AxisTitle(
                    text: 'Lead',
                    textStyle: TextStyle(
                      fontSize: scale(context, 13),
                      fontWeight: FontWeight.w900,
                      color: Colors.black,
                    ),
                  ),
                  labelStyle: TextStyle(
                    fontSize: scale(context, 12),
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  axisLine: const AxisLine(color: Colors.black, width: 1),
                ),

                primaryYAxis: NumericAxis(
                  title: AxisTitle(
                    text: 'Count',
                    textStyle: TextStyle(
                      fontSize: scale(context, 13),
                      fontWeight: FontWeight.w900,
                      color: Colors.black,
                    ),
                  ),
                  isInversed: false,
                  minimum: 0,
                  maximum: 400,
                  interval: 100,
                  labelStyle: TextStyle(
                    fontSize: scale(context, 11),
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),

                  majorGridLines: const MajorGridLines(
                    color: AppColors.dividerColor,
                    width: 0.0,
                  ),
                  axisLine: const AxisLine(color: Colors.black, width: 1),
                ),

                series: <ColumnSeries<SalesData, String>>[
                  ColumnSeries<SalesData, String>(
                    dataSource: chartData,
                    xValueMapper: (SalesData data, _) => data.type,
                    yValueMapper: (SalesData data, _) => data.sales,

                    sortingOrder: SortingOrder.descending,

                    width: isMobile ? 0.55 : 0.6,
                    spacing: 0.3,
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(8),

                    dataLabelSettings: DataLabelSettings(
                      isVisible: false,
                      ),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}


class SalesData {
  final String type;
  final int sales;
  SalesData(this.type, this.sales);
}
